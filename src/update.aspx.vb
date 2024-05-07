Imports Literatronica
Imports System.Xml.Xsl
Imports System.Xml

Namespace Literatronica

    Partial Class Folium
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
            Dim sLingua, id_opus, id_pagina As String
            Dim doc As XmlDocument = New XmlDocument
            Dim trans As XslTransform = New XslTransform
            'Create DLL Instance
            oDBService = New Connection
            'Clean malicious code from parameters that will be sent to the database
            sLinguaCok = oDBService.formatSQLInput(sLinguaCok)
            sUserID = oDBService.formatSQLInput(sUserID)
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

            sSQL = "exec out_PAGINA" & _
              " @Language='" & sLinguaCok & "'" & _
              ",@OpusType=''" & _
              ",@PageCode='P_INDEX'" & _
              ",@PageName='Pagina.aspx'" & _
              ",@id_opus=" & id_opus & _
              ",@id_pagina=" & id_pagina & _
              ",@userID='" & sUserID & "'"
            'response.write (sSQL)
            'response.end()
            doc.LoadXml(oDBService.DBXML(sSQL))
            Try

                trans.Load(Server.MapPath("..\XSL\p_PAGINA.xsl"))
                XMLContent.Document = doc
                XMLContent.Transform = trans
                '  doc.Save(Server.MapPath("..\pagina.xml"))
            Catch
                'if sUserID = "" then Response.redirect("../BBS_" & sLinguaCok & "/log_off_user.asp")
                Response.Redirect("Nuntius.aspx?lng=" & sLinguaCok & "&nuntius=T_ERROR")
            End Try
        End Sub

    End Class

End Namespace