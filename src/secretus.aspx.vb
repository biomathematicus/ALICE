Imports Literatronica.DBService
Imports System.Xml.Xsl
Imports System.Xml

Namespace Literatronica

    Partial Class Questio
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
            Dim loss As New login
            Dim status As String
            Dim oDBService As New Connection
            Dim sLinguaCok, sLinguaQry, sUserID As String
            Dim oCookie As HttpCookie
            Dim slogout As String
            oCookie = Request.Cookies("Forum")
            '****************************************************
            '      If oCookie Is Nothing Then
            'oCookie = New HttpCookie("Forum")
            'oCookie("Lingua") = "BRITANNIA"
            ' oCookie("UserID") = ""
            ' oCookie.Expires = DateAdd("yyyy", 1, Now())
            ' Response.Cookies.Add(oCookie)
            ' End If
            '***************************************************************************
            sUserID = "secretus"
            oDBService.ManageCookies(sLinguaCok, sLinguaQry, sUserID, MyBase.Page)
            'RETRIEVE DATA FROM DATABASE
            Dim sSQL As String
            Dim sLingua, sLogin, sPwd, sAction As String
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
            sUserID = oDBService.formatSQLInput(sUserID)
            sLogin = oDBService.formatSQLInput(Request.Form("txtLogin"))
            sPwd = oDBService.formatSQLInput(Request.Form("txtPassword"))
            sAction = oDBService.formatSQLInput(Request.Form("hAction"))
            slogout = oDBService.formatSQLInput(Request.QueryString("logout"))
            If slogout Is Nothing Then
            Else
                If slogout = "1" Then
                    sUserID = "LOGGED-OFF"
                End If
            End If
            sSQL = "exec out_SECRETUS" & _
            " @Language='" & sLinguaCok & "'" & _
            ",@OpusType=''" & _
            ",@LoginName='" & sLogin & "'" & _
            ",@LoginPassword='" & sPwd & "'" & _
            ",@PageCode='P_SECRETUS'" & _
            ",@PageName='Secretus.aspx'" & _
            ",@userID='" & sUserID & "'"
            Try
                doc.LoadXml(oDBService.DBXML(sSQL))

                Dim MyXMLNode As XmlNode = doc.SelectSingleNode("//successful_login")

                If MyXMLNode IsNot Nothing Then
                    status = MyXMLNode.ChildNodes(0).InnerText
                End If

                If sAction = "login" And status = "1" Then
                    oCookie("UserID") = sLogin
                    oCookie.Expires = DateAdd("yyyy", 1, Now())
                    oCookie("Lingua") = IIf(sLinguaCok = "", "BRITANNIA", sLinguaCok)
                Else
                    oCookie("UserID") = "LOGGED-OFF"
                    oCookie("Lingua") = IIf(sLinguaCok = "", "BRITANNIA", sLinguaCok)
                End If
                Response.Cookies.Add(oCookie)

                trans.Load(Server.MapPath("..\XSL\p_secretus.xsl"))
                XMLContent.Document = doc
                XMLContent.Transform = trans
            Catch
                'if sUserID = "" then Response.redirect("../BBS_" & sLinguaCok & "/log_off_user.asp")
                Response.Redirect("Nuntius.aspx?lng=" & sLinguaCok & "&nuntius=T_ERROR")
            End Try
            If status = "1" Then
                Response.Redirect("Initium.aspx")
                ' Dim s As String
            End If
        End Sub

    End Class

End Namespace