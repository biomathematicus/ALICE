<%@ WebHandler Language="VB" Class="Comment_handler" %>

Imports System
Imports System.Web
Imports System.Web.Services
Imports System.IO
Imports Literatronica
Imports System.Xml.Xsl
Imports System.Xml
Public Class Comment_handler : Implements IHttpHandler

	Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

		Dim grade, comment, user_id, nauta_id, pagina_id, opus_id As String
		Dim oDBService As New Connection
		Dim sSQL As String
		Dim sLingua, id_opus, id_pagina, sUserID As String
		Dim doc As XmlDocument = New XmlDocument
		Dim trans As XslTransform = New XslTransform
		'Create DLL Instance
		oDBService = New Connection

		opus_id = oDBService.formatSQLInput(context.Request.Form("opus_id"))
		pagina_id = oDBService.formatSQLInput(context.Request.Form("pagina_id"))
		nauta_id = oDBService.formatSQLInput(context.Request.Form("nauta_id"))
		user_id = oDBService.formatSQLInput(context.Request.Form("user_id"))
		grade = oDBService.formatSQLInput(context.Request.Form("grad"))
		comment = oDBService.formatSQLInput(context.Request.Form("comment"))

		sSQL = "exec P_comment_add " &
				" @id_opus=" & opus_id &
				",@id_pagina=" & pagina_id &
				",@id_nauta=" & nauta_id &
				",@userID=" & user_id &
				",@grade='" & grade & "'" &
				",@comment='" & comment & "'"

		oDBService.DBXML(sSQL)

		'If context.Request.QueryString("inbox") = "true" Then
		'	context.Response.Redirect("../admin/sa_menu.aspx?chorus=" + context.Request.QueryString("chorus"))
		'End If

	End Sub

	Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
		Get
			Return False
		End Get
	End Property

End Class