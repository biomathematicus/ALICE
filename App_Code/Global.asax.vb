Imports System.Web
Imports System.Web.SessionState

Namespace Literatronica

    Public Class [Global]
        Inherits System.Web.HttpApplication
        Public Shared DB_CONN_STRING As String = System.Configuration.ConfigurationManager.AppSettings("DB_CONN_STRING")

#Region " Component Designer Generated Code "

        Public Sub New()
            MyBase.New()

            'This call is required by the Component Designer.
            InitializeComponent()

            'Add any initialization after the InitializeComponent() call

        End Sub

        'Required by the Component Designer
        Private components As System.ComponentModel.IContainer

        'NOTE: The following procedure is required by the Component Designer
        'It can be modified using the Component Designer.
        'Do not modify it using the code editor.
        <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
            components = New System.ComponentModel.Container()
        End Sub

#End Region

        Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
            ' Fires when the application is started
        End Sub

        Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
            ' Fires when the session is started
        End Sub

        Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
            ' Fires at the beginning of each request
            If (Request.Path.IndexOf(Chr(92)) >= 0 Or _
                System.IO.Path.GetFullPath(Request.PhysicalPath) <> Request.PhysicalPath) Then
                Throw New HttpException(404, "Not Found")
            End If
        End Sub

        Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
            ' Fires upon attempting to authenticate the use
        End Sub

        Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
            ' Fires when an error occurs
            'Throw New HttpException(404, "Not Found")
        End Sub

        Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
            ' Fires when the session ends
        End Sub

        Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
            ' Fires when the application ends
        End Sub

    End Class

End Namespace