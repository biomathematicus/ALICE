Imports Literatronica
Imports System.Xml.Xsl
Imports System.Xml

Namespace Literatronica

    Partial Class sa_opus_dtl
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
            'Variables for saving, inserting and deleting data
            Dim id_opus, id_artifex, cd_opus_type, ds_title_his, ds_tag_his, ds_content_his, _
             ds_title_bri, ds_tag_bri, ds_content_bri, hAction, in_visible As String
            'Dataservice
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
            sUserID = oDBService.formatSQLInput(sUserID)
            If Request.QueryString("artifex") <> "" Then
                id_artifex = oDBService.formatSQLInput(Request.QueryString("artifex"))
            Else
                id_artifex = oDBService.formatSQLInput(Request.Form("id_artifex"))
            End If
            If Request.QueryString("opus") <> "" Then
                id_opus = oDBService.formatSQLInput(Request.QueryString("opus"))
            Else
                id_opus = oDBService.formatSQLInput(Request.Form("id_opus"))
            End If
            cd_opus_type = oDBService.formatSQLInput(Request.Form("cd_opus_type"))
            ds_title_his = oDBService.formatTextInput(Request.Form("ds_title_his"))
            ds_tag_his = oDBService.formatTextInput(Request.Form("ds_tag_his"))
            ds_content_his = oDBService.formatTextInput(Request.Form("ds_content_his"))
            ds_title_bri = oDBService.formatTextInput(Request.Form("ds_title_bri"))
            ds_tag_bri = oDBService.formatTextInput(Request.Form("ds_tag_bri"))
            ds_content_bri = oDBService.formatTextInput(Request.Form("ds_content_bri"))
            hAction = Request.Form("hAction")
            If hAction = "Update" Then hAction = "Actualizar"
            If hAction = "Delete" Then hAction = "Borrar"
            hAction = oDBService.formatSQLInput(hAction)
            in_visible = oDBService.formatSQLInput(Request.Form("in_visible"))

            'Calculate book
            If hAction = "calcular" Then
                For index_1 = 0 To 6
                    oDBService.CalculateBook(id_opus, index_1)
                Next
				Response.Redirect("sa_opus_optum.aspx?opus=" & id_opus & "&lng=" & sLinguaCok)
			Else
                sSQL = "exec sa_opus_dtl" &
                  " @Language='" & sLinguaCok & "'" &
                  ",@OpusType=''" &
                  ",@PageCode='sa_menu'" &
                  ",@PageName='sa_opus_dtl.aspx'" &
                  ",@userID='" & sUserID & "'" &
                  ",@hAction='" & hAction & "'" &
                  ",@id_opus=" & id_opus &
                  ",@id_artifex=" & id_artifex &
                  ",@cd_opus_type='" & cd_opus_type & "'" &
                  ",@ds_title_his='" & ds_title_his & "'" &
                  ",@ds_tag_his='" & ds_tag_his & "'" &
                  ",@ds_content_his='" & ds_content_his & "'" &
                  ",@ds_title_bri='" & ds_title_bri & "'" &
                  ",@ds_tag_bri='" & ds_tag_bri & "'" &
                  ",@in_visible='" & in_visible & "'" &
                  ",@ds_content_bri='" & ds_content_bri & "'"
                doc.LoadXml(oDBService.DBXML(sSQL))
                'response.write (Request.Form("in_visible"))
                'response.end ()
                trans.Load(Server.MapPath("..\XSL\sa_opus_dtl.xsl"))
                '   doc.Save(Server.MapPath("..\sa_opus_dtl.xml"))
                If Request.QueryString("redirect") = "true" Then _
				 Response.Redirect("sa_opus_optum.aspx?opus=" & id_opus & "&lng=" & sLinguaCok)

				XMLContent.Document = doc
                XMLContent.Transform = trans
            End If
        End Sub

    End Class

End Namespace