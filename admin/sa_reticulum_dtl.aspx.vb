Imports Literatronica.DBService
Imports System.Xml.Xsl
Imports System.Xml

Namespace Literatronica

    Partial Class sa_reticulum_dtl
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
            Dim sLinguaCok, sLinguaQry, sUserID, sLinkType As String
            oDBService.ManageCookies(sLinguaCok, sLinguaQry, sUserID, MyBase.Page)

            'RETRIEVE DATA FROM DATABASE
            Dim sSQL As String
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Variables for saving, inserting and deleting data
            Dim id_opus, id_pagina, id_node, hAction, am_value As String
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
            sUserID = oDBService.formatSQLInput(sUserID)
            'Fields retrieved from the HTML form
            If Request.QueryString("pagina") <> "" Then
                id_pagina = oDBService.formatSQLInput(Request.QueryString("pagina"))
            Else
                id_pagina = oDBService.formatSQLInput(Request.Form("id_pagina"))
            End If
            If Request.QueryString("opus") <> "" Then
                id_opus = oDBService.formatSQLInput(Request.QueryString("opus"))
            Else
                id_opus = oDBService.formatSQLInput(Request.Form("id_opus"))
            End If
            If Request.QueryString("node") <> "" Then
                id_node = oDBService.formatSQLInput(Request.QueryString("node"))
            Else
                id_node = oDBService.formatSQLInput(Request.Form("id_node"))
            End If
            am_value = oDBService.formatSQLInput(Request.Form("am_value"))

            If Request.QueryString("LinkType") <> "" Then
                sLinkType = oDBService.formatSQLInput(Request.QueryString("LinkType"))
            Else
                sLinkType = oDBService.formatSQLInput(Request.Form("LinkType"))
            End If
            If am_value = "" Then am_value = "0"
            If id_node = "" Then id_node = "0"
            hAction = oDBService.formatSQLInput(Request.Form("hAction"))

            sSQL = "exec sa_reticulum_dtl" &
              " @Language=" & sLinguaCok &
              ",@OpusType=''" &
              ",@PageCode='sa_menu'" &
              ",@PageName='sa_reticulum_dtl.aspx'" &
              ",@hAction='" & hAction & "'" &
              ",@am_value=" & am_value &
              ",@id_opus=" & id_opus &
              ",@id_pagina=" & id_pagina &
              ",@id_node=" & id_node &
              ",@userID='" & sUserID & "'" &
              ",@LinkType='" & sLinkType & "'"
            doc.LoadXml(oDBService.DBXML(sSQL))
            trans.Load(Server.MapPath("..\XSL\sa_reticulum_dtl.xsl"))

            XMLContent.Document = doc
            XMLContent.Transform = trans
        End Sub

    End Class

End Namespace