<%@ WebHandler Language="VB" Class="h2" %>

Imports System.Web
Imports System.Web.Services
Imports System.IO
Public Class h2
	Implements System.Web.IHttpHandler, IRequiresSessionState

	Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

		context.Session("sUser") = context.Request.Form("user1")
		context.Session("sOpus") = context.Request.Form("opus1")
		context.Session("sPagina") = context.Request.Form("pagina1")
		context.Session("iOpus_id") = context.Request.Form("opus_id")
		context.Session("iPagina_id") = context.Request.Form("pagina_id")
		context.Session("iUser_id") = context.Request.Form("user_id")
		context.Session("sNew_id") = context.Request.Form("new_id")

	End Sub

	ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
		Get
			Return False
		End Get
	End Property

End Class