<%@ WebHandler Language="VB" Class="FileUpload" %>


Imports Literatronica
Imports System.Web
Imports System.IO
Imports System.Data.SqlClient
Imports System.Web.Script.Serialization

Public Class FileUpload : Implements IHttpHandler

	Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
		context.Response.ContentType = "application/json"

		Dim oDBService As New Literatronica.Connection
		Dim result As New Dictionary(Of String, String)

		Try
			Dim idOpus As String = context.Request.Form("id_opus")
			Dim idChorus As String = context.Request.Form("id_chorus")
			Dim idNauta As String = context.Request.Form("id_nauta")
			Dim idPagina As String = context.Request.Form("id_pagina")

			If context.Request.Files.Count > 0 AndAlso Not String.IsNullOrEmpty(idOpus) AndAlso Not String.IsNullOrEmpty(idChorus) AndAlso Not String.IsNullOrEmpty(idNauta) AndAlso Not String.IsNullOrEmpty(idPagina) Then
				Dim file As HttpPostedFile = context.Request.Files("uploadedFile")
				If Not file.FileName.ToLower().EndsWith(".pdf") Then
					result("status") = "error"
					result("message") = "Only PDF files are allowed."
					Dim js As New JavaScriptSerializer()
					context.Response.Write(js.Serialize(result))
					Return
				End If

				Dim uploadDir As String = context.Server.MapPath("../uploads/" & idOpus)
				If Not Directory.Exists(uploadDir) Then
					Directory.CreateDirectory(uploadDir)
				End If

				Dim finalFileName As String = "CHORUS_" & idChorus & "_OPUS_" & idOpus & "_PAGINA_" & idPagina & "_NAUTA_" & idNauta & ".pdf"
				Dim savePath As String = Path.Combine(uploadDir, finalFileName)
				file.SaveAs(savePath)

				Using connection As New SqlConnection(oDBService.DB_CONN_STRING)
					connection.Open()
					Dim transaction As SqlTransaction = connection.BeginTransaction()

					Try
						Dim sql As String = "IF EXISTS (SELECT 1 FROM FOLIO WHERE id_nauta = @id_nauta AND id_chorus = @id_chorus AND id_pagina = @id_pagina) " &
								 "UPDATE FOLIO SET ds_filename = @ds_filename, dt_created = GETDATE() WHERE id_nauta = @id_nauta AND id_chorus = @id_chorus AND id_pagina = @id_pagina " &
								 "ELSE " &
								 "INSERT INTO FOLIO (id_chorus, id_pagina, id_nauta, ds_filename, dt_created) VALUES (@id_chorus, @id_pagina, @id_nauta, @ds_filename, GETDATE())"

						Dim command As New SqlCommand(sql, connection, transaction)
						command.Parameters.AddWithValue("@id_nauta", idNauta)
						command.Parameters.AddWithValue("@id_chorus", idChorus)
						command.Parameters.AddWithValue("@id_pagina", idPagina)
						command.Parameters.AddWithValue("@ds_filename", finalFileName)

						command.ExecuteNonQuery()
						transaction.Commit()

						result("status") = "success"
						result("message") = "File uploaded successfully."
						result("fileName") = finalFileName

					Catch ex As Exception
						transaction.Rollback()
						result("status") = "error"
						result("message") = ex.Message
					End Try
				End Using
			Else
				result("status") = "error"
				result("message") = "Missing file or required form fields."
			End If

		Catch ex As Exception
			result("status") = "error"
			result("message") = ex.Message
		End Try

		Dim serializer As New JavaScriptSerializer()
		context.Response.Write(serializer.Serialize(result))
	End Sub

	Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
		Get
			Return False
		End Get
	End Property

End Class
