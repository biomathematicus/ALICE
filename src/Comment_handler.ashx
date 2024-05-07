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

        
        Dim grade,comment,user_id,pagina_id,opus_id As String
        
        
        Dim oDBService As New Connection
        Dim sSQL As String
        Dim sLingua, id_opus, id_pagina, sUserID As String
        Dim doc As XmlDocument = New XmlDocument
        Dim trans As XslTransform = New XslTransform
        'Create DLL Instance
        oDBService = New Connection
        
        
        grade = context.Request.Form("grad")
        comment = context.Request.Form("comment")
        user_id = context.Request.Form("user_id")
        pagina_id = context.Request.Form("pagina_id")
        opus_id = context.Request.Form("opus_id")
        
        comment = comment.Replace("<", "&lt;")
        comment = comment.Replace(">", "&gt;")
        comment = comment.Replace("&", "&#38;")
        comment = comment.Replace("'", "	&#39;")
        comment = comment.Replace("\""", "&#34;")
        
        sSQL = "exec P_comment_add" & _
         " @Opus_Id='" & opus_id & "'" & _
        ",@id_pagina='" & pagina_id & "'" & _
        ",@userID='" & user_id & "'" & _
        ",@grade='" & grade & "'" & _
        ",@comment='" & comment & "'"
        'response.write (sSQL)
        'response.end() 
        
        oDBService.DBXML(sSQL)
        
        
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class