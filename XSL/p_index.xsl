<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="l_html_header.xsl" />
	<xsl:include href="l_menu_top.xsl" />
	<xsl:include href="l_footer.xsl" />
	<xsl:include href="l_counter.xsl" />
	<xsl:template match="/">
		<html lang="EN">
			<!-- Insert HTML header -->
			<xsl:apply-templates select="//html_header" />
			<body>
			<xsl:if test="//user_logon !='LOGGED-OFF'">
				<table width="800px" align="center" border="0" cellpadding="0" cellspacing="0" id="tblMain" name="tblMain">
					<tr valign="top">
						<td rowspan="3" valign="top">
							<!-- Insert left menu -->
							<xsl:apply-templates select="//left_menu" />
						</td>
						<td valign="top" width="100%">
							<!-- Insert header -->
							<xsl:apply-templates select="//top_menu" />
						</td>
						<td rowspan="3" valign="top">
							<!-- Insert right menu -->
							<xsl:apply-templates select="//right_menu" />
						</td>
					</tr>
					<tr>
						<td valign="top" height="350" align="left" CLASS="MEDIUM">
							<!-- ************ BEGINS CONTENT ************ -->
							<!-- Breadcrumbs -->
							<a href="initium.aspx">
								<xsl:attribute name="href">initium.aspx?lng=<xsl:value-of select="//language" /></xsl:attribute>
								<span class="MEDIUM"><xsl:value-of select="//P_INITIUM" /></span>
							</a>
							<B>&#62;</B>
							<span class="BOLDMEDIUM"><xsl:value-of select="//P_INDEX" /></span>
							<p />
							<xsl:value-of select="//T_REGIS_WARNING" disable-output-escaping="yes" />
							<table width="100%" border="0" cellpadding="3" cellspacing="0">
								<xsl:for-each select="/doc/opus_list/opus">
									<tr valign="top">
										<td CLASS="TITLE_DARK">
											<!-- Page Status-->
											<xsl:apply-templates select="page_counter" />
										</td>
									</tr>
									<tr valign="top">
										<td CLASS="CONTENT">
											<xsl:value-of select="content" disable-output-escaping="yes" /> &#160;
											<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
												<xsl:attribute name="href">javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="page_counter/id_opus" />','<xsl:value-of select="page_counter/id_pagina" />')</xsl:attribute>
												<xsl:value-of select="//L_MORE" />
											</a>
										</td>
									</tr>
									<tr>
										<td>&#160;</td>
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
				</xsl:if>
				<xsl:if test="//user_logon ='LOGGED-OFF'">
					<script>
						window.location.href = 'Nuntius.aspx?lng=<xsl:value-of select="//language" />&#38;nuntius=T_UNAUTHORIZED'
					</script>
				</xsl:if>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>