﻿<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="l_html_header.xsl" />
	<xsl:include href="l_menu_top.xsl" />
	<xsl:include href="l_menu_left.xsl" />
	<xsl:include href="l_menu_right.xsl" />
	<xsl:include href="l_footer.xsl" />
	<xsl:template match="/">
		<html>
			<!-- Insert HTML header -->
			<xsl:apply-templates select="//html_header" />
			<body>
				<table width="800px" align="center" border="0" cellpadding="0" cellspacing="0" id="tblMain" name="tblMain">
					<tr valign="top">
						<td rowspan="3" valign="top" class='BAR_OFF'>
							<!-- Insert left menu -->
							<xsl:apply-templates select="//left_menu" />
						</td>
						<td valign="top" width="100%">
							<!-- Insert header -->
							<xsl:apply-templates select="//top_menu" />
						</td>
						<td rowspan="3" valign="top" class='BAR_OFF'>
							<!-- Insert right menu -->
							<xsl:apply-templates select="//right_menu" />
						</td>
					</tr>
					<tr>
						<td valign="top" height="350">
							<!-- ************ BEGINS CONTENT ************ -->
							<!-- Breadcrumbs -->
							<a>
								<xsl:attribute name="href">
									sa_menu.aspx?lng=<xsl:value-of select="//language" />
								</xsl:attribute>
								<xsl:value-of select="//user_role_name" />
							</a> &#62;
							<a>
								<xsl:attribute name="href">
									sa_opus_lst.aspx?artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />
								</xsl:attribute>
								<xsl:value-of select="//sa_opus_lst" />
							</a> &#62;
							<a>
								<xsl:attribute name="href">
									javascript:document.frmSession.action='sa_opus_optum.aspx?opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
								</xsl:attribute>
								<xsl:value-of select="//ds_title" />
							</a> &#62; 
							<a>
								<xsl:attribute name="href">
									javascript:document.frmSession.action='sa_nauta_lst.aspx?opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
								</xsl:attribute>
								<xsl:value-of select="//sa_nauta_lst" />
							</a> &#62;
							<b>
								<xsl:value-of select="//sa_reading_rpt" />
							</b>
							<p />

							<!-- Reading Report -->
							<table border="0" cellpadding="6" align="center">
								<tr>
									<td CLASS="TITLE_DARK" colspan="6">
										<b>
											<xsl:value-of select="//sa_reading_rpt" />
											: <xsl:value-of select="//name" /> (<xsl:value-of select="//username" />)
										</b>
									</td>
								</tr>
								<tr>
									<td>Paginas:</td>
									<td colspan="3">
										<xsl:value-of select ="//page_count" />
									</td>
								</tr>
								<tr>
									<td CLASS="TITLE_LIGHT">
										<b>Opus #</b>
									</td>
									<td CLASS="TITLE_LIGHT">
										<b>Pagina #</b>
									</td>
									<td CLASS="TITLE_LIGHT">
										<b>Pagina</b>
									</td>
									<td CLASS="TITLE_LIGHT">
										<b>Lingua</b>
									</td>
									<td CLASS="TITLE_LIGHT">
										<b>Tempus</b>
									</td>
								</tr>
								<xsl:for-each select="/doc/pages/page">
									<tr>
										<td CLASS="TITLE_LIGHT">
											<xsl:value-of select="id_opus" />
										</td>
										<td CLASS="TITLE_LIGHT">
											<xsl:value-of select="id_pagina" />
										</td>
										<td CLASS="TITLE_LIGHT">
											<xsl:value-of select="opus_title" />
											<br></br>
											<a>
												<xsl:attribute name="href">
													../src/pagina.aspx?lng=
													<xsl:value-of select="//language" />
													&#38;opus=
													<xsl:value-of select="id_opus" />
													&#38;pagina=
													<xsl:value-of select="id_pagina" />
												</xsl:attribute>
												<span class='XSMALL'>
													<xsl:value-of select="page_tag" />
												</span>
											</a>
										</td>
										<td CLASS="TITLE_LIGHT">
											<xsl:value-of select="cd_lingua" />
										</td>
										<td CLASS="TITLE_LIGHT">
											<xsl:value-of select="dt_created" />
										</td>
									</tr>
								</xsl:for-each>
							</table>
							<!-- ************  ENDS CONTENT  ************ -->
						</td>
					</tr>
					<tr>
						<td align="center">
							<!-- Insert footer -->
							<xsl:apply-templates select="//footer" />
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
