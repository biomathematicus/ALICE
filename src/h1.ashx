<%@ WebHandler Language="VB" Class="h1" %>

Imports System.Web
Imports System.Web.Services
Imports System.IO
Imports Literatronica.DBService
Imports System.Xml.Xsl
Imports System.Xml
Public Class h1
    Implements System.Web.IHttpHandler
    Private UPLOAD_PATH As String = System.Configuration.ConfigurationManager.AppSettings("UPLOAD_PATH")
    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        Dim oDBService As New Connection
        Dim sUser, sOpus, sPagina, sPath, iid_new As String
        Dim iid_user, iid_pagina, iid_opus As Integer
        Dim sExtention As String
        Dim sDir As String
        Dim ss As String
        Dim fname As String
        Dim sSQL As String
        Dim sLingua, id_opus, id_pagina, sUserID As String
        Dim doc As XmlDocument = New XmlDocument
        Dim trans As XslTransform = New XslTransform
        'Create DLL Instance
        oDBService = New Connection
        sUser = Upload.sUser
        sOpus = Upload.sOpus
        sPagina = Upload.sPagina
        iid_opus = Upload.iOpus_id
        iid_pagina = Upload.iPagina_id
        iid_user = Upload.iUser_id
        iid_new = Upload.sNew_id

        Dim sTemp As String
        sTemp = String.Concat(UPLOAD_PATH, iid_user)
        '     sTemp = String.Concat("~/uploads/", sOpus)
        sDir = sTemp
        sTemp = String.Concat(sTemp, "/")
        ' sDir = String.Concat(sTemp, sPagina)
        ' sTemp = String.Concat(sDir, "/")
        sUser = sTemp + "User" + iid_user.ToString + "Course" + iid_opus.ToString + "_Lesson" + iid_new
        '  sPath = String.Concat(sTemp, sUser)

        sDir = Replace(sDir, ".", "")
        sDir = Replace(sDir, " ", "_")
        sDir = Replace(sDir, ":", "_")
        sDir = Replace(sDir, "(", "_")
        sDir = Replace(sDir, ")", "_")
        sPath = Replace(sPath, ".", "")
        sPath = Replace(sPath, " ", "_")
        sPath = Replace(sPath, ":", "_")
        sPath = Replace(sPath, "(", "_")
        sPath = Replace(sPath, ")", "_")


        If context.Request.Files.Count > 0 Then
            Dim files As HttpFileCollection = context.Request.Files
            For i As Integer = 0 To files.Count - 1
                Dim file As HttpPostedFile = files(i)
                '      Dim fname As String
                If HttpContext.Current.Request.Browser.Browser.ToUpper() = "IE" OrElse HttpContext.Current.Request.Browser.Browser.ToUpper() = "INTERNETEXPLORER" Then
                    Dim testfiles As String() = file.FileName.Split(New Char() {"\"c})
                    fname = testfiles(testfiles.Length - 1)
                Else
                    fname = file.FileName
                    sExtention = Path.GetExtension(file.FileName)
                    sPath = sUser & sExtention

                End If
                Dim path1 As String
                path1 = context.Server.MapPath(sDir)
                fname = context.Server.MapPath(sPath)
                Try
                    ' Determine whether the directory exists.
                    If Directory.Exists(path1) Then
                        If My.Computer.FileSystem.FileExists(fname) Then
                            Return
                        End If
                    Else
                        ' Try to create the directory.
                        Dim di As DirectoryInfo = Directory.CreateDirectory(path1)
                    End If

                Catch e As Exception
                    context.Response.ContentType = "text/plain"
                    context.Response.Write("Please Try Later!")
                End Try

                file.SaveAs(fname)
            Next
        End If
        context.Response.ContentType = "text/plain"
        context.Response.Write("File Uploaded Successfully!")
        'Dim id_opus, id_pagina, sUserID As Integer
        id_opus = sOpus
        id_pagina = sPagina
        sUserID = sUser
        Dim iPagina, iOpus, iUser As Integer
        Dim url As String
        iOpus = Upload.iOpus_id
        iPagina = Upload.iPagina_id
        iUser = Upload.iUser_id

        sSQL = "exec p_labor_add" & _
                 " @Opus_Id=" & iOpus & _
                ",@id_pagina=" & iPagina & _
                ",@userID=" & iUser & _
                ",@url='" & sPath & "'"
        'response.write (sSQL)
        'response.end() 

        oDBService.DBXML(sSQL)


    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class