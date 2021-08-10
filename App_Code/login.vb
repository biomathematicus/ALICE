Imports Microsoft.VisualBasic

Public Class login
    Inherits System.Web.UI.Page
    Private first As String
    Private last As String

    Public Property firstname() As String

        Get
            Return first
        End Get

        Set(value As String)
            first = value
        End Set

    End Property

    Public Property lastname() As String

        Get
            Return last
        End Get

        Set(value As String)
            last = value
        End Set

    End Property

End Class