Imports System.Data.SqlClient

Partial Class src_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'CHECK COOKIES
        Dim oDBService As New Connection
        Dim sLinguaCok, sLinguaQry, sUserID, sCode As String
        oDBService.ManageCookies(sLinguaCok, sLinguaQry, sUserID, MyBase.Page)
        sCode = Request.QueryString("dict")

        'Clean parameter input
        sLinguaQry = oDBService.formatSQLInput(sLinguaQry)
        sCode = oDBService.formatSQLInput(sCode)

        'Create a datareader
        Dim oDataReader As SqlDataReader
        'Load the datareader
        Try
            oDataReader = oDBService.DataReaderOpen("select ds_nuntius from LINGUA_NUNTIUS where cd_lingua='" & _
                sLinguaQry & "' and cd_nuntius='" & sCode & "'")
            oDataReader.Read()
            Me.lblDict.Text = "<p>" & oDataReader(0) & "</p>"
            oDataReader.Close()
        Catch ex As Exception
            'Nothing for now
        End Try

    End Sub

End Class