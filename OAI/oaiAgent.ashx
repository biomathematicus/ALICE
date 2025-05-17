<%@ WebHandler Language="VB" Class="Auxiliator" %>

Imports System
Imports System.Web
Imports System.Data.SqlClient
Imports System.IO
Imports System.Net
Imports System.Text
Imports System.Web.Script.Serialization
Imports System.Collections.Generic
Imports Literatronica

Public Class Auxiliator : Implements IHttpHandler
	Dim oDBService As New Connection

	Private connStr As String = oDBService.DB_CONN_STRING
	Private openaiApiKey As String = IIf(System.Configuration.ConfigurationManager.AppSettings("OPENAI_API_KEY") = "",
											System.Environment.GetEnvironmentVariable("OPENAI_API_KEY"),
											System.Configuration.ConfigurationManager.AppSettings("OPENAI_API_KEY"))

	Public Sub ProcessRequest(context As HttpContext) Implements IHttpHandler.ProcessRequest
		context.Response.ContentType = "application/json"
		Dim serializer As New JavaScriptSerializer()
		Dim response As Object = New With {Key .success = False, Key .message = "Unknown error."}

		Try
			Dim action As String = context.Request("action")
			Dim id_opus As Integer = Integer.Parse(context.Request("id_opus"))
			Dim id_pagina As Integer = Integer.Parse(context.Request("id_pagina"))
			Dim ds_symbolum As String = context.Request("ds_symbolum")

			If String.IsNullOrEmpty(action) OrElse String.IsNullOrEmpty(ds_symbolum) Then
				Throw New ArgumentException("Missing parameters.")
			End If

			Select Case action.ToLower()
				Case "getstate"
					response = GetState(id_opus, id_pagina, ds_symbolum)

				Case "updatestate"
					Dim state_json As String = context.Request("state_json")
					response = UpdateState(id_opus, id_pagina, ds_symbolum, state_json)

				Case "sendmessage"
					Dim model As String = context.Request("model")
					Dim messageJson As String = context.Request("messages")
					response = SendMessage(id_opus, id_pagina, ds_symbolum, model, messageJson)

				Case Else
					response = New With {Key .success = False, Key .message = "Unknown action."}
			End Select

		Catch ex As Exception
			response = New With {Key .success = False, Key .message = ex.Message}
		End Try

		context.Response.Write(serializer.Serialize(response))
	End Sub

	Private Function GetState(id_opus As Integer, id_pagina As Integer, ds_symbolum As String) As Object
		Using conn As New SqlConnection(connStr)
			conn.Open()

			Dim id_nauta As Integer = GetNautaId(ds_symbolum, conn)
			If id_nauta = -1 Then Throw New Exception("Invalid token")

			Using cmd As New SqlCommand("getAuxiliator", conn)
				cmd.CommandType = CommandType.StoredProcedure
				cmd.Parameters.AddWithValue("@id_opus", id_opus)
				cmd.Parameters.AddWithValue("@id_pagina", id_pagina)
				cmd.Parameters.AddWithValue("@ds_symbolum", ds_symbolum)

				Using reader As SqlDataReader = cmd.ExecuteReader()
					If reader.Read() Then
						Dim json As String = If(Not IsDBNull(reader("ds_state_json")), reader("ds_state_json").ToString(), "")
						Return New With {Key .success = True, Key .state = json}
					Else
						Return New With {Key .success = True, Key .state = ""}
					End If
				End Using
			End Using
			conn.Close()
		End Using
	End Function

	Private Function UpdateState(id_opus As Integer, id_pagina As Integer, ds_symbolum As String, state_json As String) As Object
		Using conn As New SqlConnection(connStr)
			conn.Open()

			Using cmd As New SqlCommand("updateAuxiliator", conn)
				cmd.CommandType = CommandType.StoredProcedure
				cmd.Parameters.AddWithValue("@id_opus", id_opus)
				cmd.Parameters.AddWithValue("@id_pagina", id_pagina)
				cmd.Parameters.AddWithValue("@ds_symbolum", ds_symbolum)
				cmd.Parameters.AddWithValue("@ds_state_json", If(state_json, ""))
				cmd.ExecuteNonQuery()
				Return New With {Key .success = True}
			End Using

			conn.Close()
		End Using
	End Function

	Private Function SendMessage(id_opus As Integer, id_pagina As Integer, ds_symbolum As String, model As String, messageJson As String) As Object
		Dim serializer As New JavaScriptSerializer()
		Dim messages As List(Of Dictionary(Of String, Object)) = serializer.Deserialize(Of List(Of Dictionary(Of String, Object)))(messageJson)
		Dim stateResponse = GetState(id_opus, id_pagina, ds_symbolum)
		Dim stateJson As String = stateResponse.state
		Dim history As New List(Of Dictionary(Of String, Object))

		'If Not String.IsNullOrEmpty(stateJson) Then
		'	Dim existingState = serializer.Deserialize(Of Dictionary(Of String, Object))(stateJson)
		'	If existingState.ContainsKey("history") Then
		'		Dim rawList As ArrayList = DirectCast(existingState("history"), ArrayList)
		'		For Each item As Object In rawList
		'			history.Add(DirectCast(item, Dictionary(Of String, Object)))
		'		Next
		'	End If
		'End If

		'======================
		Dim conn As New SqlConnection(connStr)
		conn.Open()
		Dim existingState As New Dictionary(Of String, Object)
		Dim loadDefaults As Boolean = False

		If Not String.IsNullOrEmpty(stateJson) Then
			existingState = serializer.Deserialize(Of Dictionary(Of String, Object))(stateJson)

			' Load defaults only if not previously seeded
			If Not existingState.ContainsKey("seeded") OrElse Not CBool(existingState("seeded")) Then
				loadDefaults = True
			End If
		Else
			loadDefaults = True
		End If

		'Dim history As New List(Of Dictionary(Of String, Object))

		If loadDefaults Then
			Dim defaultHistory As New List(Of Dictionary(Of String, Object))

			Dim configPath As String = GetAgentFilePath(id_opus, id_pagina, conn)
			Dim physicalPath As String = HttpContext.Current.Server.MapPath(configPath)

			If File.Exists(physicalPath) Then
				Dim configJson As String = File.ReadAllText(physicalPath)
				Dim configData = serializer.Deserialize(Of Dictionary(Of String, Object))(configJson)

				If configData.ContainsKey("CONFIG") Then
					Dim configSection = DirectCast(configData("CONFIG"), Dictionary(Of String, Object))
					If configSection.ContainsKey("general_instructions") Then
						defaultHistory.Add(New Dictionary(Of String, Object) From {
							{"role", "system"},
							{"content", configSection("general_instructions").ToString()}
						})
					End If
				End If

				If configData.ContainsKey("knowledgeBase") Then
					Dim kbList = DirectCast(configData("knowledgeBase"), ArrayList)
					For Each entry In kbList
						Dim summary = TryCast(DirectCast(entry, Dictionary(Of String, Object))("summary"), String)
						If Not String.IsNullOrEmpty(summary) Then
							defaultHistory.Add(New Dictionary(Of String, Object) From {
								{"role", "system"},
								{"content", summary}
							})
						End If
					Next
				End If
			End If

			existingState("history") = defaultHistory
			existingState("seeded") = True
			history = defaultHistory
		Else
			' Deserialize existing history
			If existingState.ContainsKey("history") Then
				Dim rawList As ArrayList = DirectCast(existingState("history"), ArrayList)
				For Each item As Object In rawList
					history.Add(DirectCast(item, Dictionary(Of String, Object)))
				Next
			End If
		End If
		conn.Close()
		'======================

		' Add new messages to history
		For Each msg In messages
			history.Add(msg)
		Next

		' Prepare request to OpenAI
		System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12
		Dim req = HttpWebRequest.Create("https://api.openai.com/v1/chat/completions")
		req.Method = "POST"
		req.Headers.Add("Authorization", "Bearer " & openaiApiKey)
		req.ContentType = "application/json"

		Dim payload As New Dictionary(Of String, Object)
		payload("model") = model
		payload("messages") = history

		Dim jsonPayload As String = serializer.Serialize(payload)
		Using stream = req.GetRequestStream()
			Dim bytes = Encoding.UTF8.GetBytes(jsonPayload)
			stream.Write(bytes, 0, bytes.Length)
		End Using

		Dim replyText As String = ""
		Using resp = req.GetResponse()
			Using reader = New StreamReader(resp.GetResponseStream())
				Dim raw = reader.ReadToEnd()
				Dim parsed = serializer.Deserialize(Of Dictionary(Of String, Object))(raw)
				Dim choicesList As ArrayList = DirectCast(parsed("choices"), ArrayList)
				Dim choice As Dictionary(Of String, Object) = DirectCast(choicesList(0), Dictionary(Of String, Object))
				Dim msg As Dictionary(Of String, Object) = DirectCast(choice("message"), Dictionary(Of String, Object))
				replyText = msg("content").ToString()

				' Append assistant reply to history
				Dim replyObj As New Dictionary(Of String, Object)
				replyObj("role") = "assistant"
				replyObj("content") = replyText
				history.Add(replyObj)
			End Using
		End Using

		' Save updated history into existingState without replacing it entirely
		existingState("history") = history

		' Make sure "seeded" remains true if it was ever set
		If Not existingState.ContainsKey("seeded") Then
			existingState("seeded") = True
		End If

		Dim updatedStateJson As String = serializer.Serialize(existingState)
		UpdateState(id_opus, id_pagina, ds_symbolum, updatedStateJson)

		Return New With {
			Key .success = True,
			Key .reply = replyText
		}

	End Function

	Private Function GetNautaId(ds_symbolum As String, conn As SqlConnection) As Integer
		Using cmd As New SqlCommand("SELECT id_nauta FROM NAUTA WHERE ds_symbolum = @token", conn)
			cmd.Parameters.AddWithValue("@token", ds_symbolum)
			Dim result = cmd.ExecuteScalar()
			If result IsNot Nothing Then
				Return Convert.ToInt32(result)
			Else
				Return -1
			End If
		End Using
	End Function

	Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
		Get
			Return False
		End Get
	End Property

	Private Function GetAgentFilePath(id_opus As Integer, id_pagina As Integer, conn As SqlConnection) As String
		Using cmd As New SqlCommand("SELECT ds_AIagentFile FROM PAGINA WHERE id_opus = @id_opus AND id_pagina = @id_pagina", conn)
			cmd.Parameters.AddWithValue("@id_opus", id_opus)
			cmd.Parameters.AddWithValue("@id_pagina", id_pagina)
			Dim result = cmd.ExecuteScalar()
			Return If(result IsNot Nothing, result.ToString(), "")
		End Using
	End Function


End Class
