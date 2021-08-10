Imports System.Xml.Xsl
Imports System.Xml

Partial Class admin_sa_reading_lst
    Inherits System.Web.UI.Page

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'CHECK COOKIES
        Dim oDBService As New Connection
        Dim sLinguaCok, sLinguaQry, sUserID, sOpusID As String
        oDBService.ManageCookies(sLinguaCok, sLinguaQry, sUserID, MyBase.Page)

        'RETRIEVE DATA FROM DATABASE
        Dim sSQL As String
        Dim doc As XmlDocument = New XmlDocument
        Dim trans As XslTransform = New XslTransform
        'Create DLL Instance
        oDBService = New Connection
        'Clean malicious code from parameters that will be sent to the database
        sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
        sUserID = oDBService.formatSQLInput(sUserID)
        sOpusID = oDBService.formatSQLInput(Request("id_opus"))
        If sOpusID Is Nothing Or sOpusID = "" Then sOpusID = "0"

        sSQL = "exec sa_reading_lst" &
          " @Language=" & sLinguaCok &
          ",@OpusType=''" &
          ",@PageCode='sa_menu'" &
          ",@PageName='sa_reading_lst.aspx'" &
          ",@userID='" & sUserID & "'" &
          ",@Action='" & oDBService.formatSQLInput(Request("action")) & "'" &
          ",@OpusId=" & sOpusID &
          ",@ReadingGroup='" & oDBService.formatSQLInput(Request("group")) & "'"
        doc.LoadXml(oDBService.DBXML(sSQL))
        trans.Load(Server.MapPath("..\XSL\sa_reading_lst.xsl"))

        XMLContent.Document = doc
        XMLContent.Transform = trans
    End Sub

End Class