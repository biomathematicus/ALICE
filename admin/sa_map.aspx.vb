Imports Literatronica
Imports System.Xml.Xsl
Imports System.Xml

Namespace Literatronica

    Partial Class Tractus
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
            Dim sLingua, id_opus, sAction, id_pagina, sAcces, sPosition, sCheck As String
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            '
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            '
            sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
            sUserID = oDBService.formatSQLInput(sUserID)
            If Request.QueryString("opus") <> "" Then
                id_opus = oDBService.formatSQLInput(Request.QueryString("opus"))
            Else
                id_opus = oDBService.formatSQLInput(Request.Form("id_opus"))
            End If
            If Request.QueryString("pagina") <> "" Then
                id_pagina = oDBService.formatSQLInput(Request.QueryString("pagina"))
            Else
                id_pagina = oDBService.formatSQLInput(Request.Form("id_pagina"))
            End If
            If id_pagina = "" Then id_pagina = 0
            sAction = oDBService.formatSQLInput(Request.QueryString("action"))

            'check_name()
            sCheck = Request.Form("check_name")

            sAcces = Request.Form("sendata1")
            sPosition = Request.Form("sendata")

            Dim s As String = Request.Form("nodes_name")

            ' sPosition = Location.Location_
            If sAcces <> "" Then
            Else
                sAcces = "0000"
            End If

			sSQL = "exec sa_map" &
			  " @Language='" & sLinguaCok & "'" &
			  ",@OpusType=''" &
			  ",@Action='" & sAction & "'" &
			  ",@Acces='" & sPosition & "'" &
			  ",@PageCode='sa_menu'" &
			  ",@PageName='sa_map.aspx'" &
			  ",@id_opus=" & id_opus &
			  ",@sCheck='" & sCheck & "'" &
			  ",@userID='" & sUserID & "'"
			Try
                doc.LoadXml(oDBService.DBXML(sSQL))
                trans.Load(Server.MapPath("..\XSL\sa_map.xsl"))
                XMLContent.Document = doc
                XMLContent.Transform = trans
                '     doc.Save(Server.MapPath("..\map.xml"))
            Catch ex As Exception
                Response.Redirect("..\src\Nuntius.aspx?lng=" & sLinguaCok & "&nuntius=T_ERROR")

            End Try
        End Sub

    End Class

End Namespace