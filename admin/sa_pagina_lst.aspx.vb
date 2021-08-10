Imports Literatronica.DBService
Imports System.Xml.Xsl
Imports System.Xml

Namespace Literatronica

    Partial Class sa_pagina_lst
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
            Dim sSQL As String, n As Integer
            Dim sOpus As String
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
            sUserID = oDBService.formatSQLInput(sUserID)
            sOpus = oDBService.formatSQLInput(Request.QueryString("opus"))
            'Delete anchor from parameter
            n = sOpus.ToString.IndexOf("#")
            If n > 0 Then sOpus = sOpus.ToString.Substring(0, sOpus.ToString.Length - n - 1)

            sSQL = "exec sa_pagina_lst" &
              " @Language='" & sLinguaCok & "'" &
              ",@Opus_Id=" & sOpus &
              ",@OpusType=''" &
              ",@PageCode='sa_menu'" &
              ",@PageName='sa_pagina_lst.aspx'" &
              ",@userID='" & sUserID & "'"
            doc.LoadXml(oDBService.DBXML(sSQL))
            trans.Load(Server.MapPath("..\XSL\sa_pagina_lst.xsl"))

            XMLContent.Document = doc
            XMLContent.Transform = trans
        End Sub

    End Class

End Namespace