Imports Literatronica.DBService
Imports System.Xml.Xsl
Imports System.Xml


Namespace Literatronica


    Partial Class Initium
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

          
            Dim sAction As String

            Dim oDBService As New Connection

            Dim sLinguaCok, sLinguaQry, sUserID As String
            oDBService.ManageCookies(sLinguaCok, sLinguaQry, sUserID, MyBase.Page)

            'RETRIEVE DATA FROM DATABASE
            Dim sSQL As String
            Dim sLingua As String = "BRITANNIA"
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            sLinguaQry = oDBService.formatSQLInput(sLinguaQry)
            If Trim(sLinguaQry) = "" Then sLinguaQry = "BRITANNIA"
            sUserID = oDBService.formatSQLInput(sUserID)

            sSQL = "exec out_Initium" & _
              " @Language='" & sLinguaQry & "'" & _
              ",@OpusType=''" & _
              ",@PageCode='P_INITIUM'" & _
              ",@PageName='Initium.aspx'" & _
              ",@userID='" & sUserID & "'"
            Try
                doc.LoadXml(oDBService.DBXML(sSQL))
                trans.Load(Server.MapPath("..\XSL\p_initium.xsl"))
                XMLContent.Document = doc


                XMLContent.Transform = trans
            Catch ex As Exception
                If sUserID = "" Then Response.Redirect("../BBS_" & sLinguaCok & "/log_off_user.asp")
                Response.Redirect("Nuntius.aspx?lng=" & sLinguaCok & "&nuntius=T_ERROR")
            End Try

        End Sub

    End Class

End Namespace
