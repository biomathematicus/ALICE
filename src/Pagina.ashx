<%@ WebHandler Language="VB" Class="SubmitHandlerPagina" %>

Imports Literatronica
Imports System.Web
Imports System.Data.SqlClient

Public Class SubmitHandlerPagina
	Implements IHttpHandler

	Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
		Dim oDBService As New Connection

		context.Response.ContentType = "text/plain"
		Dim action As String = oDBService.formatSQLInput(context.Request.Form("actionAJAX"))
		Dim idOpus As Integer = Convert.ToInt32(oDBService.formatSQLInput(context.Request.Form("id_opus")))
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
		End Select

	End Sub

	Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
		Get
			Return False
		End Get
	End Property
End Class
