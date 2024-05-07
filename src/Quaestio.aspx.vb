Imports Literatronica
Imports System.Xml.Xsl
Imports System.Xml

Namespace Literatronica

	Partial Class Quaestio
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
			Dim sLingua, sSearchString As String
			Dim doc As XmlDocument = New XmlDocument
			Dim trans As XslTransform = New XslTransform
			'Create DLL Instance
			oDBService = New Connection
			'Clean malicious code from parameters that will be sent to the database
			sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
			sUserID = oDBService.formatSQLInput(sUserID)
			sSearchString = oDBService.formatSQLInput(Request.Form("txtSearch"))

			sSQL = "exec out_QUAESTIO" &
			  " @Language='" & sLinguaCok & "'" &
			  ",@OpusType=''" &
			  ",@SearchString='" & sSearchString & "'" &
			  ",@PageCode='P_QUAESTIO'" &
			  ",@PageName='Quaestio.aspx'" &
			  ",@userID='" & sUserID & "'"
			Try
				doc.LoadXml(oDBService.DBXML(sSQL))
				trans.Load(Server.MapPath("..\XSL\p_QUAESTIO.xsl"))
				XMLContent.Document = doc
				XMLContent.Transform = trans
			Catch
				'if sUserID = "" then Response.redirect("../BBS_" & sLinguaCok & "/log_off_user.asp")
				Response.Redirect("Nuntius.aspx?lng=" & sLinguaCok & "&nuntius=T_ERROR")
			End Try
		End Sub

	End Class

End Namespace