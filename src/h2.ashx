<%@ WebHandler Language="VB" Class="h2" %>

Imports System.Web
Imports System.Web.Services
Imports System.IO
Public Class h2
    Implements System.Web.IHttpHandler

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        
        
       
        Upload.sUser = context.Request.Form("user1")
        Upload.sOpus = context.Request.Form("opus1")
        Upload.sPagina = context.Request.Form("pagina1")
        Upload.iOpus_id = context.Request.Form("opus_id")
        Upload.iPagina_id = context.Request.Form("pagina_id")
        Upload.iUser_id = context.Request.Form("user_id")
        Upload.sNew_id = context.Request.Form("new_id")
        

    

    
    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class