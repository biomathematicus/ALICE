Imports Literatronica
Imports System.Xml.Xsl
Imports System.Xml

Partial Class admin_sa_reading_rpt
    Inherits System.Web.UI.Page

	Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
		'CHECK COOKIES
		Dim oDBService As New Connection
		Dim sLinguaCok, sLinguaQry, sUserID As String
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

		sSQL = "exec sa_reading_rpt" &
		  " @Language=" & sLinguaCok &
		  ",@OpusType=''" &
		  ",@PageCode='sa_menu'" &
		  ",@PageName='sa_reading_rpt.aspx'" &
		  ",@userID='" & sUserID & "'" &
		  ",@OpusID='" & oDBService.formatSQLInput(Request("opus")) & "'" &
		  ",@ReadingGroup='" & oDBService.formatSQLInput(Request("group")) & "'" &
		  ",@NautaCode='" & Trim(oDBService.formatSQLInput(Request("nauta"))) & "'"

		Try
			doc.LoadXml(oDBService.DBXML(sSQL))
			trans.Load(Server.MapPath("..\XSL\sa_reading_rpt.xsl"))
			XMLContent.Document = doc
			XMLContent.Transform = trans

		Catch ex As Exception
			'doc.Save(Server.MapPath("..\sa_reading_rpt.xml"))
			Response.Redirect("../src/Nuntius.aspx?lng=" & sLinguaCok & "&nuntius=T_ERROR")
		End Try


	End Sub

End Class