<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="l_html_header.xsl" />
	<xsl:include href="l_menu_top.xsl" />
	<xsl:include href="l_menu_left.xsl" />
	<xsl:include href="l_menu_right.xsl" />
	<xsl:include href="l_footer.xsl" />
	<xsl:template match="/">
		<html lang="EN">
			<!-- Insert HTML header -->
			<xsl:apply-templates select="//html_header" />
			<body>
				<table width="600" align="center" border="0" cellpadding="0" cellspacing="0" id="tblMain" name="tblMain">
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
						<td valign="top" height="350" align="left" class="XSMALL">
							<!-- ************ BEGINS CONTENT ************ -->
							<!-- Breadcrumbs -->
							<a href="initium.aspx"><span class="XSMALL"><xsl:value-of select="//P_INITIUM" /></span></a> &#62;
							<span class="BOLDXSMALL"><xsl:value-of select="//L_SEARCH" /></span>
							<p />
							<table border="0" cellpadding="2" width="100%"  align="left">
								<tr>
									<td CLASS="TITLE_DARK" colspan="2">
										<b><xsl:value-of select="//L_SEARCH_RESULTS" /></b>: &#160;
										<xsl:value-of select="//L_SEARCH_STRING" />
									</td>
								</tr>
								<xsl:if test="count(/doc/quaestio/pagina) &lt; 1">
									<tr>
										<td class="CONTENT"><xsl:value-of select="//L_SEARCH_NOT_FND" /></td>
									</tr>
								</xsl:if>
								<xsl:for-each select="/doc/quaestio/pagina">
									<tr valign="top">
										<td CLASS="TITLE_DARK">
											<xsl:value-of select="id" /><br />
											<xsl:if test="//user_id != ''">
												<xsl:choose>
											  		<xsl:when test="visited[. = 'true']">
														<img src="../images/system/ico_visited.gif">
															<xsl:attribute name="alt"><xsl:value-of select="//L_VISITED" /></xsl:attribute>
														</img>
													</xsl:when>
													<xsl:otherwise>
														<img src="../images/system/ico_visited_not.gif">
															<xsl:attribute name="alt"><xsl:value-of select="//L_VISITED_NOT" /></xsl:attribute>
														</img>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>
										</td>
										<td CLASS="TITLE_LIGHT">
											<span class="BOLD"><xsl:value-of select="ds_opus" /></span>&#160;-&#160;
											<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
												<xsl:attribute name="href">javascript:document.frmSession.action='../src/Pagina.aspx?lng=<xsl:value-of select="//language" />&#38;opus=<xsl:value-of select="id_opus" />&#38;pagina=<xsl:value-of select="id" />';document.frmSession.submit();</xsl:attribute>
												<b><xsl:value-of select="title" /></b>
											</a>
											<span class="XSMALL">
											  	<xsl:if test="visited[. = 'true'] and //user_id != ''">
													(<xsl:value-of select="//L_VISITED" />)<br />
													<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
														<xsl:attribute name="href">javascript:document.frmSession.action='../src/Tractus.aspx?lng=<xsl:value-of select="//language" />&#38;action=del&#38;opus=<xsl:value-of select="id_opus" />&#38;pagina=<xsl:value-of select="id" />';document.frmSession.submit();</xsl:attribute>
														<img src="../images/system/ico_delete.gif" border="0">
															<xsl:attribute name="alt"><xsl:value-of select="//L_CHAPTER_DEL" /></xsl:attribute>
														</img>&#160;
														<span class="XSMALL"><xsl:value-of select="//L_CHAPTER_DEL" /></span>
													</a>&#160;
													<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
														<xsl:attribute name="href">javascript:document.frmSession.action='../src/Tractus.aspx?lng=<xsl:value-of select="//language" />&#38;action=delall&#38;opus=<xsl:value-of select="id_opus" />&#38;pagina=<xsl:value-of select="id" />';document.frmSession.submit();</xsl:attribute>
														<img src="../images/system/ico_delete_all.gif" border="0">
															<xsl:attribute name="alt"><xsl:value-of select="//L_CHAPTER_DEL_ALL" /></xsl:attribute>
														</img>&#160;
														<span class="XSMALL"><xsl:value-of select="//L_CHAPTER_DEL_ALL" /></span>
													</a>
												</xsl:if>
											  	<xsl:if test="visited[. = 'false'] and //user_id != ''">
													(<xsl:value-of select="//L_VISITED_NOT" />)
												</xsl:if>
											</span>
											<br />
											<xsl:value-of select="tag" />
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