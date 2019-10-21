Imports Literatronica.DBService
Imports System.Xml.Xsl
Imports System.Xml


Namespace Literatronica


Partial Class Nuntius
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
        Dim sSQL, cd_nuntius As String
        Dim sLingua As String
        Dim doc As XmlDocument = New XmlDocument
        Dim trans As XslTransform = New XslTransform
        Dim id_opus As Integer
        Dim sPageCode As String
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
        If Request.QueryString("opus") <> "" Then
            id_opus = oDBService.formatSQLInput(Request.QueryString("opus"))
        Else
            id_opus = 0
        End If
        If cd_nuntius = "T_ABOUT" Or Mid(cd_nuntius, 1, 11) = "OPUS_ABOUT_" Then sPageCode = "P_INDICIUM" Else sPageCode = "P_Nuntius"
        sSQL = "exec out_Nuntius" & _
          " @Language=" & sLinguaCok & _
          ",@OpusType=''" & _
          ",@PageCode='" & sPageCode & "'" & _
          ",@PageName='Nuntius.aspx'" & _
          ",@cd_nuntius='" & cd_nuntius & "'" & _
          ",@id_opus='" & id_opus & "'" & _
          ",@userID='" & sUserID & "'"
        Try
            doc.LoadXml(oDBService.DBXML(sSQL))
            trans.Load(Server.MapPath("..\XSL\p_Nuntius.xsl"))
            XMLContent.Document = doc
            XMLContent.Transform = trans
        Catch
            'if sUserID = "" then Response.redirect("../BBS_" & sLinguaCok & "/log_off_user.asp")
            Response.Redirect("Nuntius.aspx?lng=" & sLinguaCok & "&nuntius=T_ERROR")
        End Try
    End Sub

End Class

End Namespace
