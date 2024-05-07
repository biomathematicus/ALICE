<%@ WebHandler Language="VB" Class="Upload_lesson" %>

Imports System.Web
Imports System.Web.Services
Imports System.IO
Imports Literatronica
Imports System.Xml.Xsl
Imports System.Xml
Public Class Upload_lesson
    Implements System.Web.IHttpHandler
    '  Private UPLOAD_PATH As String = System.Configuration.ConfigurationManager.AppSettings("UPLOAD_PATH")
    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        'Dim oDBService As New Connection
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
        ' oDBService = New Connection

        Dim sTemp As String
        '     sTemp = String.Concat("~/uploads/", sOpus)
        sDir = "~/docs/2018FallBINF8980"

        Dim count As Integer = 1
        Dim fileNameOnly, extension, path_, newFullPath, tempFileName, Real_fname As String
        extension = "pdf"
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
                    extension = sExtention

                End If
                Dim path1 As String
                path1 = context.Server.MapPath(sDir)
                Real_fname = context.Server.MapPath(sDir + "/" + fname)
                fileNameOnly = Path.GetFileNameWithoutExtension(fname)
                path_ = path1
                newFullPath = Real_fname
                Try
                    ' Determine whether the directory exists.
                    If Directory.Exists(path1) Then
                        If My.Computer.FileSystem.FileExists(Real_fname) Then

                            While (My.Computer.FileSystem.FileExists(newFullPath))
                                count = count + 1
                                tempFileName = String.Format("{0}({1})", fileNameOnly, count)
                                newFullPath = path_ & tempFileName + extension
                            End While

                            'Return
                            Real_fname = newFullPath
                        End If
                    Else
                        ' Try to create the directory.
                        Dim di As DirectoryInfo = Directory.CreateDirectory(path1)
                    End If

                Catch e As Exception
                    context.Response.ContentType = "text/plain"
                    context.Response.Write("Please Try Later!")
                End Try

                file.SaveAs(Real_fname)
            Next
        End If
        context.Response.ContentType = "text/plain"
        context.Response.Write("File Uploaded Successfully!")

    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class