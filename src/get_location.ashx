<%@ WebHandler Language="VB" Class="get_location" %>

Imports System
Imports System.Web

Public Class get_location : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        
        
        
        Location.Location_ = context.Request.Form("locations_1")

        Dim xx As Integer
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class