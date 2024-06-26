﻿Imports Literatronica
Imports System.Xml.Xsl
Imports System.Xml

Namespace Literatronica

    Partial Class sa_nauta_lst
        Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

        'This call is required by the Web Form Designer.
        <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

        End Sub

        Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
            'CODEGEN: This method call is required by the Web Form Designer
            'Do not modify it using the code editor.
            InitializeComponent()
        End Sub

#End Region

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            'CHECK COOKIES
            Dim oDBService As New Connection
            Dim sLinguaCok, sLinguaQry, sUserID As String
            oDBService.ManageCookies(sLinguaCok, sLinguaQry, sUserID, MyBase.Page)

            'RETRIEVE DATA FROM DATABASE
            Dim sSQL As String
            Dim sArtifex As String
            Dim sOpus, sPagina As String
            Dim sChorus As String
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
            sUserID = oDBService.formatSQLInput(sUserID)
			sArtifex = oDBService.formatSQLInput(Request.QueryString("artifex"))
			If sArtifex = "" Then sArtifex = "1"
			sOpus = oDBService.formatSQLInput(Request.QueryString("opus"))
            ' sPagina = oDBService.formatSQLInput(Request.QueryString("pagina"))
            sChorus = oDBService.formatSQLInput(Request.QueryString("chorus")) 'HttpContext.Current.Request("myText")
			'  sChorus = "fa 2014"
			sSQL = "exec sa_nauta_lst" &
			  " @Language='" & sLinguaCok & "'" &
			  ",@Artifex_id=" & sArtifex &
			  ",@Opus=" & sOpus &
			  ",@Chorus='" & sChorus & "'" &
			  ",@OpusType=''" &
			  ",@PageCode='sa_menu'" &
			  ",@PageName='sa_nauta_lst.aspx'" &
			  ",@userID='" & sUserID & "'"
			doc.LoadXml(oDBService.DBXML(sSQL))
            trans.Load(Server.MapPath("..\XSL\sa_nauta_lst.xslt"))

            Session("artifex") = Request.QueryString("artifex")

            XMLContent.Document = doc
            XMLContent.Transform = trans
        End Sub

    End Class

End Namespace