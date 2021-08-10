Imports Literatronica.DBService
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
            Dim sLingua, id_opus, sAction, id_pagina, sAcces, sCategory As String
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
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
            sCategory = "0"
            sCategory = Request.Form("pagina_cat")
            'sCategory = Request.Form("pagina_cat_status")

            sAcces = Request.Form("sendata1")
            If sCategory = "" Then
                sCategory = "-1"
            End If
            If sAcces = "click" Then
                sAcces = "0000"
            End If
            If sAcces <> "" Then
            Else
                sAcces = "0000"
            End If

            sSQL = "exec out_TRACTUS" &
              " @Language='" & sLinguaCok & "'" &
              ",@OpusType=''" &
              ",@Action='" & sAction & "'" &
              ",@Acces='" & sAcces & "'" &
              ",@PageCode='P_INDEX'" &
              ",@PageName='Tractus.aspx'" &
              ",@id_opus=" & id_opus &
              ",@id_pagina=" & id_pagina &
              ",@userID='" & sUserID & "'" &
              ",@id_category=" & sCategory
            '   Try
            doc.LoadXml(oDBService.DBXML(sSQL))
            trans.Load(Server.MapPath("..\XSL\p_TRACTUS.xsl"))
            XMLContent.Document = doc
            XMLContent.Transform = trans
            'doc.Save(Server.MapPath("..\tractus.xml"))
            '  Catch ex As Exception
            'Response.Redirect("Nuntius.aspx?lng=" & sLinguaCok & "&nuntius=T_ERROR")

            '   End Try
        End Sub

    End Class

End Namespace