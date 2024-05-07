Imports Literatronica
Imports System.Xml.Xsl
Imports System.Xml

Namespace Literatronica

    Partial Class sa_pagina_dtl
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
            Dim id_opus, id_pagina, am_link, ds_title_his, ds_tag_his, ds_content_his, _
             ds_title_bri, ds_tag_bri, ds_content_bri, hAction, sCapston, sCapstonStatus, sStartLesson, sStartLessonStatus As String
            Dim sPaginaType, sPaginaCat As String
            Dim sCapston1 As Boolean
            'Dataservice
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
            sUserID = oDBService.formatSQLInput(sUserID)
            'Fields retrieved from the HTML form
            If Request.QueryString("pagina") <> "" Then
                id_pagina = oDBService.formatSQLInput(Request.QueryString("pagina"))
            Else
                id_pagina = oDBService.formatSQLInput(Request.Form("id_pagina"))
            End If
            If Request.QueryString("opus") <> "" Then
                id_opus = oDBService.formatSQLInput(Request.QueryString("opus"))
            Else
                id_opus = oDBService.formatSQLInput(Request.Form("id_opus"))
            End If
            hAction = Request.Form("hAction")
            If hAction = "Update" Then hAction = "Actualizar"
            If hAction = "Delete" Then hAction = "Borrar"
            hAction = oDBService.formatSQLInput(hAction)
            am_link = oDBService.formatSQLInput(Request.Form("am_link"))
            If am_link = "" Then am_link = "0"
            ds_title_his = oDBService.formatTextInput(Request.Form("ds_title_his"))
            ds_tag_his = oDBService.formatTextInput(Request.Form("ds_tag_his"))
            ds_content_his = oDBService.formatTextInput(Request.Form("ds_content_his"))
            ds_title_bri = oDBService.formatTextInput(Request.Form("ds_title_bri"))
            ds_tag_bri = oDBService.formatTextInput(Request.Form("ds_tag_bri"))
            ds_content_bri = oDBService.formatTextInput(Request.Form("ds_content_bri"))
            sPaginaType = oDBService.formatTextInput(Request.Form("pagina_type"))
            sPaginaCat = oDBService.formatTextInput(Request.Form("pagina_cat"))
            sCapston = Request.Form("Capstone")
            sCapstonStatus = Request.Form("capstone_status")
            If sCapston Is Nothing And sCapstonStatus = "remove" Then

                sCapston = "false"
            End If
            If sCapston Is Nothing And sCapstonStatus Is Nothing Then

                sCapston = "nothing"
            End If

            sStartLesson = Request.Form("startlesson")
            sStartLessonStatus = Request.Form("startlesson_status")
            If sStartLesson Is Nothing And sStartLessonStatus = "remove" Then

                sStartLesson = "false"
            End If
            If sStartLesson Is Nothing And sStartLessonStatus Is Nothing Then

                sStartLesson = "nothing"
            End If

            sSQL = "exec sa_pagina_dtl" &
              " @Language='" & sLinguaCok & "'" &
              ",@OpusType=''" &
              ",@PageCode='sa_menu'" &
              ",@PageName='sa_pagina_dtl.aspx'" &
              ",@userID='" & sUserID & "'" &
              ",@hAction='" & hAction & "'" &
              ",@sCapston='" & sCapston & "'" &
              ",@sStartLesson='" & sStartLesson & "'" &
              ",@id_opus=" & id_opus &
              ",@id_pagina=" & id_pagina &
              ",@am_link=" & am_link &
              ",@ds_title_his='" & ds_title_his & "'" &
              ",@ds_tag_his='" & ds_tag_his & "'" &
              ",@ds_content_his='" & ds_content_his & "'" &
              ",@ds_title_bri='" & ds_title_bri & "'" &
              ",@ds_tag_bri='" & ds_tag_bri & "'" &
              ",@sPaginaType='" & sPaginaType & "'" &
              ",@sPaginaCat='" & sPaginaCat & "'" &
              ",@ds_content_bri='" & ds_content_bri & "'"

            doc.LoadXml(oDBService.DBXML(sSQL))
            trans.Load(Server.MapPath("..\XSL\sa_pagina_dtl.xsl"))
            If Request.QueryString("redirect") = "true" Then _
             Response.Redirect("sa_pagina_lst.aspx?opus=" & id_opus & "&lng=" & sLinguaCok & "&#" & id_pagina)
            ' doc.Save(Server.MapPath("..\debug.xml"))
            XMLContent.Document = doc
            XMLContent.Transform = trans
        End Sub

    End Class

End Namespace