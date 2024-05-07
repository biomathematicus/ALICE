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
            Dim sArtifex, sAcces, sPagina, sComment As String
            Dim iId As Integer
            Dim sOpus As String
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
            sUserID = oDBService.formatSQLInput(sUserID)
            ' sArtifex = oDBService.formatSQLInput(Request.QueryString("artifex"))
            sOpus = oDBService.formatSQLInput(Request.QueryString("opus"))
            sPagina = oDBService.formatSQLInput(Request.QueryString("pagina"))
            sComment = oDBService.formatSQLInput(Request.QueryString("comment"))
            ' iId = oDBService.formatSQLInput(Request.QueryString("id"))
            iId = 1
            sArtifex = "1"

            sAcces = Request.Form("question")
            If sAcces <> "" Then
            Else
                sAcces = "0000"
            End If
            sAcces = sAcces.Replace("<", "&lt;")
            sAcces = sAcces.Replace(">", "&gt;")
            sAcces = sAcces.Replace("&", "&#38;")
            sAcces = sAcces.Replace("'", "	&#39;")
            sAcces = sAcces.Replace("\""", "&#34;")

            sSQL = "exec out_question" & _
              " @Language='" & sLinguaCok & "'" & _
              ",@Artifex_id=" & sArtifex & _
              ",@Id='" & iId & "'" & _
              ",@Opus=" & sOpus & _
              ",@Pagina=" & sPagina & _
              ",@Comment=" & sComment & _
              ",@OpusType=''" & _
              ",@Acces='" & sAcces & "'" & _
              ",@PageCode='sa_opus_lst'" & _
              ",@PageName='sa_opus_lst.aspx'" & _
              ",@userID='" & sUserID & "'"
            doc.LoadXml(oDBService.DBXML(sSQL))
            ' doc.Save(Server.MapPath("..\question.xml"))

            trans.Load(Server.MapPath("..\XSL\p_question.xsl"))
            Session("artifex") = Request.QueryString("artifex")

            XMLContent.Document = doc
            XMLContent.Transform = trans

        End Sub

    End Class

End Namespace