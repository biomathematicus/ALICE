<%@ WebHandler Language="VB" Class="SubmitHandlerPagina" %>

Imports Literatronica
Imports System.Web
Imports System.Data.SqlClient

Public Class SubmitHandlerPagina
	Implements IHttpHandler

	Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
		Dim oDBService As New Connection

		context.Response.ContentType = "text/plain"
		Dim assessmentText As String = oDBService.formatSQLInput(context.Request.Form("ds_assess_his"))
		Dim idOpus As Integer = Convert.ToInt32(oDBService.formatSQLInput(context.Request.Form("id_opus")))
		Dim idPagina As Integer = Convert.ToInt32(oDBService.formatSQLInput(context.Request.Form("id_pagina")))
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
	End Sub

	Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
		Get
			Return False
		End Get
	End Property
End Class
