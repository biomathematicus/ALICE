'----------------------------------------------------------------------------
' OpenAI.vb  –  OpenAI chat agent wrapper (framework‑only, no NuGet)
' Fixed ArrayList ⇢ IList casts to stop InvalidCastException
'----------------------------------------------------------------------------

Imports System.Net.Http
Imports System.Net.Http.Headers
Imports System.Text
Imports System.Threading.Tasks
Imports System.Web.Script.Serialization

Namespace Literatronica

	Public Class ChatMessage
		Public Property role As String
		Public Property content As String
	End Class

	Public Class OpenAI
		'==== Fields =========================================================
		Private ReadOnly _apiKey As String
		Private ReadOnly _history As List(Of ChatMessage) = New List(Of ChatMessage)()
		Private Shared ReadOnly _http As HttpClient

		Private _agentName As String
		Private _modelCode As String
		Private _temperature As Double
		Private _maxTokens As Integer

		'==== Static ctor: one HttpClient for all ============================
		Shared Sub New()
			_http = New HttpClient()
			_http.Timeout = TimeSpan.FromSeconds(100)
		End Sub

		'==== Ctor ===========================================================
		Public Sub New(modelCode As String, agentName As String, apiKey As String,
					   Optional temperature As Double = 0.7, Optional maxTokens As Integer = 2048)
			_modelCode = modelCode
			_agentName = agentName
			_apiKey = apiKey
			_temperature = temperature
			_maxTokens = maxTokens
		End Sub

		'==== Public props ===================================================
		Public ReadOnly Property AgentName As String
			Get
				Return _agentName
			End Get
		End Property
		Public ReadOnly Property ModelCode As String
			Get
				Return _modelCode
			End Get
		End Property
		Public Property Temperature As Double
			Get
				Return _temperature
			End Get
			Set(v As Double)
				_temperature = v
			End Set
		End Property
		Public Property MaxTokens As Integer
			Get
				Return _maxTokens
			End Get
			Set(v As Integer)
				_maxTokens = v
			End Set
		End Property
		Public ReadOnly Property History As List(Of ChatMessage)
			Get
				Return _history
			End Get
		End Property

		'==== Send ===========================================================
		Public Async Function SendAsync(userText As String) As Task(Of String)
			If String.IsNullOrWhiteSpace(userText) Then Throw New ArgumentException("Prompt is empty.")

			Dim js As New JavaScriptSerializer()
			Dim reqBody As New Dictionary(Of String, Object) From {
				{"model", _modelCode},
				{"temperature", _temperature},
				{"max_tokens", _maxTokens},
				{"messages", BuildChatMessages(userText)}
			}
			Dim jsonBody As String = js.Serialize(reqBody)

			Using httpReq As New HttpRequestMessage(HttpMethod.Post, "https://api.openai.com/v1/chat/completions")
				httpReq.Headers.Authorization = New AuthenticationHeaderValue("Bearer", _apiKey)
				httpReq.Content = New StringContent(jsonBody, Encoding.UTF8, "application/json")

				Using httpResp = Await _http.SendAsync(httpReq).ConfigureAwait(False)
					If Not httpResp.IsSuccessStatusCode Then
						Throw New ApplicationException("OpenAI HTTP " & CInt(httpResp.StatusCode))
					End If
					Dim raw As String = Await httpResp.Content.ReadAsStringAsync().ConfigureAwait(False)
					Dim reply As String = ParseAssistantReply(raw)

					_history.Add(New ChatMessage With {.role = "user", .content = userText})
					_history.Add(New ChatMessage With {.role = "assistant", .content = reply})
					Return reply
				End Using
			End Using
		End Function

		Public Sub Reset()
			_history.Clear()
		End Sub

		'==== Static helper: build many agents from MODELS ====================
		Public Shared Function FromModelSection(jsonPath As String, apiKey As String) As List(Of OpenAI)
			Dim js As New JavaScriptSerializer()
			Dim root = js.Deserialize(Of Dictionary(Of String, Object))(IO.File.ReadAllText(jsonPath))
			If Not root.ContainsKey("MODELS") Then Throw New ArgumentException("MODELS section not found.")

			Dim models As IList = DirectCast(root("MODELS"), IList)   ' was Object()
			Dim list As New List(Of OpenAI)
			For Each m As Dictionary(Of String, Object) In models
				list.Add(New OpenAI(CStr(m("model_code")), CStr(m("agent_name")), apiKey,
									CDbl(m("temperature")), CInt(m("max_completion_tokens"))))
			Next
			Return list
		End Function

		'==== Internals =======================================================
		Private Function BuildChatMessages(latestPrompt As String) As List(Of ChatMessage)
			Dim msgs As New List(Of ChatMessage)(_history)
			msgs.Add(New ChatMessage With {.role = "user", .content = latestPrompt})
			Return msgs
		End Function

		Private Function ParseAssistantReply(rawJson As String) As String
			Dim js As New JavaScriptSerializer()
			Dim root = js.Deserialize(Of Dictionary(Of String, Object))(rawJson)
			Dim choices As IList = DirectCast(root("choices"), IList)  ' was Object()
			If choices.Count = 0 Then Return ""

			Dim first = DirectCast(choices(0), Dictionary(Of String, Object))
			Dim msg = DirectCast(first("message"), Dictionary(Of String, Object))
			Return CStr(msg("content"))
		End Function

	End Class
End Namespace
