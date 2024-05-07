<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="l_html_header.xsl" />
	<xsl:include href="l_menu_top.xsl" />
	<xsl:include href="l_menu_left.xsl" />
	<xsl:include href="l_menu_right.xsl" />
	<xsl:include href="l_footer.xsl" />
	<xsl:include href="l_counter.xsl" />
	<xsl:template match="/">
		<html lang="EN">
			<!-- Insert HTML header -->
			<xsl:apply-templates select="//html_header" />
			<style>
				#messageArea img {
				display: block;
				margin-left: auto;
				margin-right: auto;
				}
			</style>
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
						<td valign="top" height="350" class="CONTENT" align="left">
							<!-- ************ BEGINS CONTENT ************ -->
							<table width="100%" border="0" cellpadding="3" cellspacing="0" align="left">
								<xsl:if test="//id_opus[. != '0']">
									<tr>
										<td class="TITLE_DARK">
											<!-- Page Status-->
											<xsl:apply-templates select="//page_counter" />
										</td>
									</tr>
								</xsl:if>
								<tr>
									<td class="CONTENT">
										<div id="messageArea">
										<xsl:value-of select="//P_NUNTIUS" disable-output-escaping="yes" />
										</div>
										<script>
											MarkdownToHtml('messageArea');
										</script>
									</td>
								</tr>
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