<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="l_html_header.xsl" />
	<xsl:include href="l_menu_top.xsl" />
	<xsl:include href="l_menu_left.xsl" />
	<xsl:include href="l_menu_right.xsl" />
	<xsl:include href="l_footer.xsl" />
	<xsl:template match="/">
		<html>
			<head><xsl:apply-templates select="//html_header" /></head>
			<body leftmargin="0" topmargin="0" bottommargin="0" rightmargin="0">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
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
							<!-- xsl:apply-templates select="//right_menu" / -->
						</td>
					</tr>
					<tr>
						<td valign="top" height="400">
							<!-- ************ BEGINS CONTENT ************ -->
							This page is under construction
							<!-- ************  ENDS CONTENT  ************ -->
						</td>
					</tr>
					<tr>
						<td class="BAR_OFF">
							<!-- Insert footer -->
							<xsl:apply-templates select="//footer" />
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>