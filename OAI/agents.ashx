<%@ WebHandler Language="VB" Class="agents" %>
'----------------------------------------------------------------------------
' agents.ashx  – Single-agent handler (first model in config) using OpenAI.vb
'----------------------------------------------------------------------------
Imports Literatronica                    ' Connection helper
Imports System.Web
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Reflection
Imports System.Linq
Imports System.Net
'Imports Auxiliator                       ' OpenAI class

Public Class agents : Implements IHttpHandler,
							   System.Web.SessionState.IReadOnlySessionState

	'─── Single OpenAI instance + meta (shared) ──────────────────────────────
	Private Shared ReadOnly _lock As New Object()
	Private Shared _cfgPath As String      ' full JSON path currently in use
	Private Shared _agent As OpenAI
	Private Shared _agentName As String
	Private Shared _gen As String
	Private Shared _desc As String
	Private _idNauta As Integer = -1   ' resolved once per request
	Private ReadOnly js As New JavaScriptSerializer()

	Public ReadOnly Property IsReusable As Boolean Implements IHttpHandler.IsReusable
		Get
			Return True
		End Get
	End Property

	' Ensure modern TLS so OpenAI HTTPS handshake succeeds
	Shared Sub New()
		ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 Or SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls
	End Sub

	'─── DB connection string (shared for all requests) ──────────────────────
	Private ReadOnly connStr As String = (New Connection()).DB_CONN_STRING

#Region "▌ Build (or reuse) agent from first MODEL entry in JSON"

	'==========================================
	' Instance method so it can use the instance-level parameters &
	' instance members without hitting the Shared restriction.
	'==========================================
	Private Sub EnsureAgent(idOpus As Integer, idPagina As Integer)
		'— fetch JSON path from DB —------------------------------------------------
		Dim cfgPath As String
		Using cn As New SqlConnection(connStr)
			cn.Open()
			cfgPath = GetAgentFilePath(idOpus, idPagina, cn)
		End Using
		If String.IsNullOrWhiteSpace(cfgPath) Then
			Throw New HttpException(500, "JSON config path not found in database.")
		End If
		'— rebuild only if path changed —------------------------------------------
		If _agent IsNot Nothing AndAlso
		   String.Equals(_cfgPath, cfgPath, StringComparison.OrdinalIgnoreCase) Then
			'Exit Sub
		End If
		Dim physicalPath As String = HttpContext.Current.Server.MapPath(cfgPath)

		SyncLock _lock
			If _agent Is Nothing Then 'OrElse Not String.Equals(_cfgPath, cfgPath, StringComparison.OrdinalIgnoreCase) 
				Dim js As New JavaScriptSerializer()
				Dim root = js.Deserialize(Of Dictionary(Of String, Object))(
							 IO.File.ReadAllText(physicalPath))

				'Dim firstRec = DirectCast(root("MODELS"), IList)(0)

				'➤ pull CONFIG once
				Dim cfg As Dictionary(Of String, Object) =
					DirectCast(root("CONFIG"), Dictionary(Of String, Object))
				_gen = CStr(cfg("general_instructions"))
				_desc = CStr(cfg("description"))

				Dim models As IList = DirectCast(root("MODELS"), IList)   ' ArrayList
				Dim firstRec As Dictionary(Of String, Object) =
					DirectCast(models(0), Dictionary(Of String, Object))

				Dim apiKey As String = ConfigurationManager.AppSettings("OPENAI_API_KEY")
				If String.IsNullOrWhiteSpace(apiKey) Then
					apiKey = Environment.GetEnvironmentVariable("OPENAI_API_KEY")
				End If

				_agentName = CStr(firstRec("agent_name"))
				_agent = New OpenAI(CStr(firstRec("model_code")),
										_agentName,
										apiKey,
										CDbl(firstRec("temperature")),
										CInt(firstRec("max_completion_tokens")))
				_cfgPath = cfgPath
				SeedAgent()
			End If
		End SyncLock
	End Sub

	'==========================================
	Private Sub SeedAgent()
		'➤ seed history only if it’s a *fresh* agent (no DB history yet)
		_agent.History.Clear()
		_agent.History.Add(New ChatMessage With {.role = "system", .content = _gen})
		_agent.History.Add(New ChatMessage With {.role = "system", .content = _desc})
	End Sub

#End Region

	'==========================================
	Public Sub ProcessRequest(ctx As HttpContext) Implements IHttpHandler.ProcessRequest
		ctx.Response.ContentType = "application/json"

		Dim req = ctx.Request
		Dim action As String = req("action")
		' inside ProcessRequest, before you parse to Integer
		Dim idOpusRaw = If(req("id_opus"), req("opus"))
		Dim idPagRaw = If(req("id_pagina"), req("pagina"))
		Dim token = If(req("ds_symbolum"), req("symbolum"))

		' Resolve id_nauta from the token (ds_symbolum) just once
		Using cn As New SqlConnection(connStr)
			Using cmd As New SqlCommand(
				  "SELECT id_nauta FROM dbo.NAUTA WHERE ds_symbolum = @tok", cn)
				cmd.Parameters.AddWithValue("@tok", token)
				cn.Open()
				_idNauta = CInt(cmd.ExecuteScalar())
			End Using
		End Using

		' fall-back to the referrer’s query-string if still empty
		If String.IsNullOrEmpty(idOpusRaw) Then
			Dim qs = HttpUtility.ParseQueryString(ctx.Request.UrlReferrer.Query)
			idOpusRaw = qs("opus")
			idPagRaw = qs("pagina")
			token = If(token, qs("symbolum"))
		End If

		Dim idOpus As Integer = Integer.Parse(idOpusRaw)
		Dim idPagina As Integer = Integer.Parse(idPagRaw)

		EnsureAgent(idOpus, idPagina)

		Select Case action
			Case "sendmessage"
				Dim prompt = req("prompt")
				Dim reply = _agent.SendAsync(prompt).Result
				SaveState(idOpus, idPagina, token)
				ctx.Response.Write(js.Serialize(New With {.success = True, .reply = reply}))

			Case "getstate"
				Dim hist = LoadState(idOpus, idPagina, token)
				ctx.Response.Write(js.Serialize(New With {.success = True, .history = hist}))

			Case "updatestate"
				SaveState(idOpus, idPagina, token, req("state_json"))
				ctx.Response.Write(js.Serialize(New With {.success = True}))

			Case "deletechat"
				Using cn As New SqlConnection(connStr)
					Using cmd As New SqlCommand(
						"DELETE FROM dbo.AUXILIATOR " &
						"WHERE id_opus = @id_opus " &
						"  AND id_pagina = @id_pagina " &
						"  AND id_nauta = @id_nauta " &
						"  AND ds_agent_code = @ds_agent_code", cn)

						cmd.Parameters.AddWithValue("@id_opus", idOpus)
						cmd.Parameters.AddWithValue("@id_pagina", idPagina)
						cmd.Parameters.AddWithValue("@id_nauta", _idNauta)
						cmd.Parameters.AddWithValue("@ds_agent_code", _agent.ModelCode)
						cn.Open()
						cmd.ExecuteNonQuery()
					End Using
				End Using
				SeedAgent()
				ctx.Response.Write(js.Serialize(New With {.success = True}))

			Case Else
				ctx.Response.StatusCode = 400
				ctx.Response.Write(js.Serialize(New With {.success = False, .message = "Bad action"}))
		End Select
	End Sub

#Region "▌ DB helpers – stored procs unchanged"

	'==========================================
	Private Sub SaveState(idOpus As Integer, idPagina As Integer,
						  token As String,
						  Optional overrideJson As String = Nothing)
		Dim stateJson As String = If(overrideJson,
			js.Serialize(New With {.history = _agent.History}))

		Using cn As New SqlConnection(connStr)
			Using cmd As New SqlCommand("dbo.updateAuxiliator", cn)
				cmd.CommandType = CommandType.StoredProcedure
				cmd.Parameters.AddWithValue("@id_opus", idOpus)
				cmd.Parameters.AddWithValue("@id_pagina", idPagina)
				cmd.Parameters.AddWithValue("@ds_symbolum", token)
				cmd.Parameters.AddWithValue("@ds_agent_code", _agent.ModelCode)
				cmd.Parameters.AddWithValue("@ds_state_json", stateJson)
				cn.Open()
				cmd.ExecuteNonQuery()
			End Using
		End Using
	End Sub

	'==========================================
	Private Function LoadState(idOpus As Integer, idPagina As Integer,
							   token As String) As List(Of Object)
		Using cn As New SqlConnection(connStr)
			Using cmd As New SqlCommand("dbo.getAuxiliator", cn)
				cmd.CommandType = CommandType.StoredProcedure
				cmd.Parameters.AddWithValue("@id_opus", idOpus)
				cmd.Parameters.AddWithValue("@id_pagina", idPagina)
				cmd.Parameters.AddWithValue("@ds_symbolum", token)
				cmd.Parameters.AddWithValue("@ds_agent_code", _agent.ModelCode)
				cn.Open()

				Dim rdr = cmd.ExecuteReader()
				If rdr.Read() AndAlso Not rdr.IsDBNull(0) Then
					Dim blob = rdr.GetString(0)
					Dim obj = js.Deserialize(Of Dictionary(Of String, Object))(blob)
					If obj.ContainsKey("history") Then
						Dim h = DirectCast(obj("history"), IList)

						'── rebuild agent history via reflection ──────────────
						_agent.Reset()
						Dim listField = _agent.History               ' IList
						Dim msgType = listField.GetType().
										 GetGenericArguments()(0)     ' ChatMessage type
						Dim propRole = msgType.GetProperty("role",
											BindingFlags.IgnoreCase Or BindingFlags.Public Or BindingFlags.Instance)
						Dim propContent = msgType.GetProperty("content",
											BindingFlags.IgnoreCase Or BindingFlags.Public Or BindingFlags.Instance)

						For Each m As Dictionary(Of String, Object) In h     ' IList → Dictionary(Of String,Object)
							Dim msg = Activator.CreateInstance(msgType)
							propRole.SetValue(msg, CStr(m("role")))
							propContent.SetValue(msg, CStr(m("content")))
							listField.Add(msg)
						Next
						Return h.Cast(Of Object)().ToList()
					End If
				End If
			End Using
		End Using
		Return New List(Of Object)()
	End Function

#End Region

#Region "▌ Helper – fetch JSON path from PAGINA ▌"

	'==========================================
	Private Shared Function GetAgentFilePath(id_opus As Integer,
											 id_pagina As Integer,
											 conn As SqlConnection) As String
		Using cmd As New SqlCommand(
			"SELECT ds_AIagentFile FROM PAGINA WHERE id_opus = @id_opus AND id_pagina = @id_pagina",
			conn)
			cmd.Parameters.AddWithValue("@id_opus", id_opus)
			cmd.Parameters.AddWithValue("@id_pagina", id_pagina)
			Dim result = cmd.ExecuteScalar()
			Return If(result IsNot Nothing, result.ToString(), "")
		End Using
	End Function

#End Region

End Class
