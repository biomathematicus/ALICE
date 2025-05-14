Imports Literatronica
Imports System.Xml.Xsl
Imports System.Xml
Imports System.Diagnostics


Namespace Literatronica

    Partial Class Folium
		Inherits BasePage

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

			Dim id_opus, id_pagina, sCategory As String
			System.IO.File.AppendAllText("C:\temp\debug_trace.txt", "ASPX page PID: " & Process.GetCurrentProcess().Id.ToString() & Environment.NewLine)

			'Clean malicious code from parameters that will be sent to the database
			oDBService.ManageCookies(sLinguaCok, sLinguaQry, sUserID, MyBase.Page)
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

            sCategory = "0"
            sCategory = Request.Form("pagina_cat")
            If sCategory = "" Then
                sCategory = "-1"
            End If

			Try
				sSQL = "exec out_PAGINA" &
				  " @Language='" & sLinguaCok & "'" &
				  ",@OpusType=''" &
				  ",@PageCode='P_INDEX'" &
				  ",@PageName='Pagina.aspx'" &
				  ",@id_opus=" & id_opus &
				  ",@id_pagina=" & id_pagina &
				  ",@userID='" & sUserID & "'" &
				  ",@id_category=" & sCategory
				'RETRIEVE DATA FROM DATABASE
				doc.LoadXml(oDBService.DBXML(sSQL))
				trans.Load(Server.MapPath("..\XSL\p_PAGINA.xsl"))
				XMLContent.Document = doc

				XMLContent.Transform = trans
			Catch ex As Exception
				'if sUserID = "" then Response.redirect("../BBS_" & sLinguaCok & "/log_off_user.asp")
				Response.Redirect("Nuntius.aspx?lng=" & sLinguaCok & "&nuntius=T_ERROR")
            End Try
        End Sub

    End Class

End Namespace