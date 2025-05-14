<%@ WebHandler Language="VB" Class="SubmitHandlerPagina" %>

Imports Literatronica
Imports System.Web
Imports System.Web.Services
Imports System.Data.SqlClient
Imports System.IO

Public Class SubmitHandlerPagina
	Implements IHttpHandler

	Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
		Dim oDBService As New Connection

		context.Response.ContentType = "text/plain"
		Dim action As String = oDBService.formatSQLInput(context.Request.Form("actionAJAX"))
		Dim idOpus As Integer = Convert.ToInt32(oDBService.formatSQLInput(context.Request.Form("id_opus")))
		Dim idChorus As Integer = Convert.ToInt32(oDBService.formatSQLInput(context.Request.Form("id_chorus")))
		Dim idNauta As Integer = Convert.ToInt32(oDBService.formatSQLInput(context.Request.Form("id_nauta")))
		Dim idPagina As Integer = Convert.ToInt32(oDBService.formatSQLInput(context.Request.Form("id_pagina")))

		Select Case action
			Case "STUDENT"
				Dim assessmentText As String = oDBService.formatSQLInput(context.Request.Form("txtSTUDENT"))
				Dim userID As Integer = Convert.ToInt32(oDBService.formatSQLInput(context.Request.Form("user_id")))
				If Not String.IsNullOrEmpty(assessmentText) Then
					Dim connectionString As String = oDBService.DB_CONN_STRING
					Using connection As New SqlConnection(connectionString)
						connection.Open()
						Dim transaction As SqlTransaction = connection.BeginTransaction()

						Try
							Dim sql As String = "IF EXISTS (SELECT 1 FROM LABOR WHERE id_nauta = @id_nauta AND id_opus = @id_opus AND id_pagina = @id_pagina) " &
												"UPDATE LABOR SET ds_labor = @ds_labor, dt_upload = GETDATE() WHERE id_nauta = @id_nauta AND id_opus = @id_opus AND id_pagina = @id_pagina " &
												"ELSE " &
												"INSERT INTO LABOR (id_nauta, id_opus, id_pagina, ds_labor, dt_upload) VALUES (@id_nauta, @id_opus, @id_pagina, @ds_labor, GETDATE())"

							Dim command As New SqlCommand(sql, connection, transaction)
							command.Parameters.AddWithValue("@id_nauta", userID)
							command.Parameters.AddWithValue("@id_opus", idOpus)
							command.Parameters.AddWithValue("@id_pagina", idPagina)
							command.Parameters.AddWithValue("@ds_labor", assessmentText)

							command.ExecuteNonQuery()
							transaction.Commit()
							context.Response.Write("Assessment saved successfully.")
						Catch ex As Exception
							transaction.Rollback()
							context.Response.Write("Error in saving assessment: " & ex.Message)
						End Try
					End Using
				Else
					context.Response.Write("No text provided.")
				End If
			Case "SLO"
				Dim SLOtext As String = oDBService.formatSQLInput(context.Request.Form("txtSLO"))
				Dim language As String = oDBService.formatSQLInput(context.Request.Form("cd_lingua"))
				If Not String.IsNullOrEmpty(SLOtext) Then
					Dim connectionString As String = oDBService.DB_CONN_STRING
					Using connection As New SqlConnection(connectionString)
						connection.Open()
						Dim transaction As SqlTransaction = connection.BeginTransaction()

						Try
							Dim sql As String = "UPDATE LINGUA_PAGINA SET ds_slo = @ds_slo WHERE cd_lingua = @cd_lingua AND id_opus = @id_opus AND id_pagina = @id_pagina"

							Dim command As New SqlCommand(sql, connection, transaction)
							command.Parameters.AddWithValue("@cd_lingua", language)
							command.Parameters.AddWithValue("@id_opus", idOpus)
							command.Parameters.AddWithValue("@id_pagina", idPagina)
							command.Parameters.AddWithValue("@ds_slo", SLOtext)

							command.ExecuteNonQuery()
							transaction.Commit()
							context.Response.Write("SLO saved successfully.")
						Catch ex As Exception
							transaction.Rollback()
							context.Response.Write("Error in saving SLO: " & ex.Message)
						End Try
					End Using
				Else
					context.Response.Write("No SLO provided.")
				End If
			Case "ASSESS"
				Dim ASSESStext As String = oDBService.formatSQLInput(context.Request.Form("txtASSESS"))
				Dim language As String = oDBService.formatSQLInput(context.Request.Form("cd_lingua"))
				If Not String.IsNullOrEmpty(ASSESStext) Then
					Dim connectionString As String = oDBService.DB_CONN_STRING
					Using connection As New SqlConnection(connectionString)
						connection.Open()
						Dim transaction As SqlTransaction = connection.BeginTransaction()

						Try
							Dim sql As String = "UPDATE LINGUA_PAGINA SET ds_assess = @ds_assess WHERE cd_lingua = @cd_lingua AND id_opus = @id_opus AND id_pagina = @id_pagina"

							Dim command As New SqlCommand(sql, connection, transaction)
							command.Parameters.AddWithValue("@cd_lingua", language)
							command.Parameters.AddWithValue("@id_opus", idOpus)
							command.Parameters.AddWithValue("@id_pagina", idPagina)
							command.Parameters.AddWithValue("@ds_assess", ASSESStext)

							command.ExecuteNonQuery()
							transaction.Commit()
							context.Response.Write("Assessment saved successfully.")
						Catch ex As Exception
							transaction.Rollback()
							context.Response.Write("Error in saving assessment: " & ex.Message)
						End Try
					End Using
				Else
					context.Response.Write("No assessment provided.")
				End If
			Case "LESSON"
				Dim LESSONtext As String = oDBService.formatSQLInput(context.Request.Form("txtLESSON"))
				Dim language As String = oDBService.formatSQLInput(context.Request.Form("cd_lingua"))
				If Not String.IsNullOrEmpty(LESSONtext) Then
					Dim connectionString As String = oDBService.DB_CONN_STRING
					Using connection As New SqlConnection(connectionString)
						connection.Open()
						Dim transaction As SqlTransaction = connection.BeginTransaction()

						Try
							Dim sql As String = "UPDATE LINGUA_PAGINA SET ds_content = @ds_lesson WHERE cd_lingua = @cd_lingua AND id_opus = @id_opus AND id_pagina = @id_pagina"

							Dim command As New SqlCommand(sql, connection, transaction)
							command.Parameters.AddWithValue("@cd_lingua", language)
							command.Parameters.AddWithValue("@id_opus", idOpus)
							command.Parameters.AddWithValue("@id_pagina", idPagina)
							command.Parameters.AddWithValue("@ds_lesson", LESSONtext)

							command.ExecuteNonQuery()
							transaction.Commit()
							context.Response.Write("Lesson saved successfully.")
						Catch ex As Exception
							transaction.Rollback()
							context.Response.Write("Error in saving lesson: " & ex.Message)
						End Try
					End Using
				Else
					context.Response.Write("No lesson provided.")
				End If
			Case "UPLOAD"
				Dim UPLOAD_PATH As String = System.Configuration.ConfigurationManager.AppSettings("UPLOAD_PATH") & Convert.ToString(idOpus) & "_" & Convert.ToString(idChorus) & "/"
				Dim uploadDir As String = context.Server.MapPath(UPLOAD_PATH)
				If Not Directory.Exists(uploadDir) Then
					Directory.CreateDirectory(uploadDir)
				End If
				Dim uniqueID As String = Guid.NewGuid().ToString()
				Dim finalFileName As String = "CHORUS_" & idChorus & "_OPUS_" & idOpus & "_PAGINA_" & idPagina & "_NAUTA_" & idNauta & "_" & uniqueID & ".pdf"
				Dim virtualPath As String = UPLOAD_PATH & finalFileName
				Dim savePath As String = Path.Combine(uploadDir, finalFileName)
				Dim files As HttpFileCollection = context.Request.Files
				Dim file As HttpPostedFile = files(0)

				Using connection As New SqlConnection(oDBService.DB_CONN_STRING)
					connection.Open()
					Dim transaction As SqlTransaction = connection.BeginTransaction()

					Try
						If file.ContentLength > 10 * 1024 * 1024 Then ' 10 MB
							context.Response.StatusCode = 400
							context.Response.Write("File too large. Max allowed size is 10 MB.")
							Return
						End If
						file.SaveAs(savePath)
						Dim sql As String = "INSERT INTO FOLIO (id_chorus, id_opus, id_pagina, id_nauta, ds_filename, dt_created) VALUES (@id_chorus, @id_opus, @id_pagina, @id_nauta, @ds_filename, GETDATE())"

						Dim command As New SqlCommand(sql, connection, transaction)
						command.Parameters.AddWithValue("@id_chorus", idChorus)
						command.Parameters.AddWithValue("@id_opus", idOpus)
						command.Parameters.AddWithValue("@id_pagina", idPagina)
						command.Parameters.AddWithValue("@id_nauta", idNauta)
						command.Parameters.AddWithValue("@ds_filename", virtualPath)
						command.ExecuteNonQuery()
						transaction.Commit()
						'context.Response.Write("File saved successfully")
						context.Response.Write(VirtualPathUtility.ToAbsolute(virtualPath))
					Catch ex As Exception
						transaction.Rollback()
						context.Response.Write("Error saving file:" & ex.Message)
					End Try
				End Using
			Case "DELETE_FILE"
				Dim filePath As String = context.Request.Form("file") ' relative path
				Dim fileName As String = context.Request.Form("file_name")

				Dim fullPath As String = context.Server.MapPath(filePath)

				Using connection As New SqlConnection(oDBService.DB_CONN_STRING)
					connection.Open()
					Dim transaction As SqlTransaction = connection.BeginTransaction()

					Try
						' Delete the file from disk if it exists
						If File.Exists(fullPath) Then
							File.Delete(fullPath)
						End If

						' Delete the FOLIO record using the relative file path
						Dim sql As String = "DELETE FROM FOLIO WHERE ds_filename = @ds_filename"
						Dim command As New SqlCommand(sql, connection, transaction)
						Dim s As String = filePath.Replace("/alice", "~").Replace("..", "~")
						command.Parameters.AddWithValue("@ds_filename", s)
						command.ExecuteNonQuery()

						transaction.Commit()
						context.Response.Write("Deleted")
					Catch ex As Exception
						transaction.Rollback()
						context.Response.StatusCode = 500
						context.Response.Write("Error deleting file: " & ex.Message)
					End Try
				End Using
				Return



		End Select

	End Sub

	Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
		Get
			Return False
		End Get
	End Property
End Class
