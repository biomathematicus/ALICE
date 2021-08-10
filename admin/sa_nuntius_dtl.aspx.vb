Imports Literatronica.DBService
Imports System.Xml.Xsl
Imports System.Xml

Namespace Literatronica

    Partial Class sa_nuntius_dtl
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
            'Variables for saving, inserting and deleting data
            Dim hAction, cd_nuntius, ds_nuntius_bri, ds_nuntius_his As String
            'Dataservice
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
            sUserID = oDBService.formatSQLInput(sUserID)
            If Request.QueryString("nuntius") <> "" Then
                cd_nuntius = oDBService.formatSQLInput(Request.QueryString("nuntius"))
            Else
                cd_nuntius = oDBService.formatSQLInput(Request.Form("cd_nuntius"))
            End If
            ds_nuntius_his = oDBService.formatTextInput(Request.Form("ds_nuntius_his"))
            ds_nuntius_bri = oDBService.formatTextInput(Request.Form("ds_nuntius_bri"))
            hAction = oDBService.formatSQLInput(Request.Form("hAction"))

            sSQL = "exec sa_nuntius_dtl" &
              " @Language='" & sLinguaCok & "'" &
              ",@OpusType=''" &
              ",@PageCode='sa_menu'" &
              ",@PageName='sa_nuntius_dtl.aspx'" &
              ",@userID='" & sUserID & "'" &
              ",@hAction='" & hAction & "'" &
              ",@cd_nuntius='" & cd_nuntius & "'" &
              ",@ds_nuntius_his='" & ds_nuntius_his & "'" &
              ",@ds_nuntius_bri='" & ds_nuntius_bri & "'"
            doc.LoadXml(oDBService.DBXML(sSQL))
            trans.Load(Server.MapPath("..\XSL\sa_nuntius_dtl.xsl"))
            If Request.QueryString("author") = "true" Then
                Session("author") = "true"
            End If
            If Request.QueryString("redirect") = "true" Then
                If Session("author") = "true" Then
                    Response.Redirect("sa_opus_lst.aspx?artifex=" & Session("artifex") & "&lng=" & sLinguaCok)
                Else
                    Response.Redirect("sa_nuntius_lst.aspx?lng=" & sLinguaCok)
                End If
            End If
            XMLContent.Document = doc
            XMLContent.Transform = trans
        End Sub

    End Class

End Namespace