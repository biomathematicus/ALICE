Imports Literatronica
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
            Dim act As String
            Dim sOpus As String
			Dim sIdNauta As String
			Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
            sUserID = oDBService.formatSQLInput(sUserID)
			sArtifex = oDBService.formatSQLInput(Request.QueryString("artifex"))
			If sArtifex = "" Then sArtifex = "1"
			act = oDBService.formatSQLInput(Request.QueryString("action"))
            sOpus = oDBService.formatSQLInput(Request.QueryString("opus"))
			sIdNauta = oDBService.formatSQLInput(Request.QueryString("id_nauta"))
			If act = "date" Or act = "name" Then
            Else
                act = "nothing"
            End If
			sSQL = "exec sa_nautaLaborio_lst" &
			  " @Language='" & sLinguaCok & "'" &
			  ",@Artifex_id=" & sArtifex &
			  ",@id_nauta=" & sIdNauta &
			  ",@Opus=" & sOpus &
			  ",@OpusType=''" &
			  ",@PageCode='sa_menu'" &
			  ",@PageName='sa_nautaLaborio_lst.aspx'" &
			  ",@action='" & act & "'" &
			  ",@userID='" & sUserID & "'"
			doc.LoadXml(oDBService.DBXML(sSQL))
            trans.Load(Server.MapPath("..\XSL\sa_nautaLaborio_lst.xsl"))
            Session("artifex") = Request.QueryString("artifex")

            XMLContent.Document = doc
            XMLContent.Transform = trans
            'doc.Save(Server.MapPath("..\nauta.xml"))

        End Sub

    End Class

End Namespace