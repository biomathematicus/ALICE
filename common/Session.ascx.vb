Imports System
Imports System.Web
Imports System.Web.UI

Namespace Literatronica.Literatronic

    Partial Class Session
        Inherits System.Web.UI.UserControl

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

        Private _PageName As String

        Public Property PageName() As String

            Get
                Return _PageName
            End Get

            Set(ByVal Value As String)
                _PageName = Value
            End Set

        End Property

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            'CHECK COOKIES
            Dim sLinguaCok As String
            Dim sLinguaQry As String
            Dim sUserID As String
            sLinguaQry = Request.QueryString("lng")
            Try
                If sLinguaQry <> "HISPANIA" And sLinguaQry <> "BRITANNIA" Then
                    sLinguaCok = Request.Cookies("Forum")("Lingua")
                    If sLinguaCok = "" Or sLinguaCok Is Nothing Then sLinguaCok = "BRITANNIA"
                    sLinguaQry = sLinguaCok
                Else
                    sLinguaCok = sLinguaQry
                    sUserID = Request.Cookies("Forum")("UserID")
                    Response.Cookies("Forum")("Lingua") = sLinguaQry
                    Response.Cookies("Forum")("UserID") = sUserID
                    Response.Cookies("Forum").Expires = DateAdd("yyyy", 1, Now())
                End If
                sUserID = Request.Cookies("Forum")("UserID")
                If sUserID Is Nothing Then sUserID = ""
                'The following line is needed because of the forum
                If Right(sUserID, 12) = "LOGGED%2DOFF" Then sUserID = ""
                If sUserID = "" Then Response.Redirect("../BBS_" & sLinguaCok & "/log_off_user.asp")
            Catch
                Response.Redirect(_PageName & ".aspx" & "?ref=Initium.aspx&act=ln&lng=")
                'sUserID = ""
                'sLinguaQry = "BRITANNIA"
            End Try
            If sLinguaCok <> "HISPANIA" And sLinguaCok <> "BRITANNIA" Then
                Response.Redirect("Lingua.aspx?ref=initium.aspx&act=ln&lng=")
                'sLinguaQry = "BRITANNIA"
            End If
        End Sub

    End Class

End Namespace