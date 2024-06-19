<%@ WebHandler Language="VB" class="oaiAgent"%>
Imports System.Web
Imports System.Web.Services
Imports System.IO
Imports System.Net
Imports System.Text
Imports System.Web.Script.Serialization

Public Class oaiAgent
	Implements IHttpHandler

	Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
		ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12
		context.Response.ContentType = "application/json"

		Dim conversation As String = context.Request.Form("conversation")

		' Retrieve the API key from the environment variable
		Dim apiKey As String = System.Environment.GetEnvironmentVariable("OPENAI_API_KEY")
		If String.IsNullOrEmpty(apiKey) Then
			context.Response.Write("API Key is not configured properly.")
			context.Response.End()
			Return
		End If

		' Set up OpenAI API request
		Dim apiUrl As String = "https://api.openai.com/v1/assistants/threads/runs"
		Dim assistantId As String = "OPUS60_PAGINA1_NAUTA11" ' Ensure this ID is correct
		Dim threadId As String = "OPUS60_PAGINA1_NAUTA11" ' Ensure this ID is correct

		' Create HTTP request
		Dim request As HttpWebRequest = CType(WebRequest.Create(apiUrl), HttpWebRequest)
		request.Method = "POST"
		request.ContentType = "application/json"
		request.Headers.Add("Authorization", "Bearer " & apiKey)
		request.Headers.Add("OpenAI-Beta", "assistants=v2")

		' Prepare JSON payload
		Dim payload As New Dictionary(Of String, Object) From {
			{"assistant_id", assistantId},
			{"thread_id", threadId},
			{"messages", conversation}
		}
		Dim json As String = (New JavaScriptSerializer()).Serialize(payload)
		Dim byteArray As Byte() = Encoding.UTF8.GetBytes(json)

		' Write payload to request
		request.ContentLength = byteArray.Length
		Dim dataStream As Stream = request.GetRequestStream()
		dataStream.Write(byteArray, 0, byteArray.Length)
		dataStream.Close()

		' Get response
		Try
			Dim response As HttpWebResponse = CType(request.GetResponse(), HttpWebResponse)
			Dim reader As New StreamReader(response.GetResponseStream())
			Dim responseFromServer As String = reader.ReadToEnd()

			' Return response
			context.Response.Write(responseFromServer)
		Catch ex As WebException
			' Capture detailed error message
			Dim errorResponse As String = New StreamReader(ex.Response.GetResponseStream()).ReadToEnd()
			context.Response.ContentType = "text/plain"
			context.Response.Write("Error: " & ex.Message & vbCrLf & errorResponse)
		Catch ex As Exception
			context.Response.ContentType = "text/plain"
			context.Response.Write("Error: " & ex.Message)
		End Try
	End Sub

	Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
		Get
			Return False
		End Get
	End Property
End Class
