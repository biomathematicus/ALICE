<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="l_html_header.xsl" />
	<xsl:include href="l_menu_top.xsl" />
	<xsl:include href="l_menu_left.xsl" />
	<xsl:include href="l_menu_right.xsl" />
	<xsl:include href="l_footer.xsl" />
	<xsl:template match="/">
		<xsl:variable name="ActionFlagName" select="'1'" />
		<html>
			<!-- Insert HTML header -->
			<xsl:apply-templates select="//html_header" />
			<style>
				/* Limit the maximum width of the first column */
				.column-1 {
				max-width: 400px; /* maximum width */
				word-wrap: break-word; /* Force wrapping of lines */
				white-space: normal; /* Allow wrapping */
				}

				/* Limit the maximum width of the second column */
				.column-2 {
				max-width: 250px; /* maximum width */
				word-wrap: break-word; /* Force wrapping of lines */
				white-space: normal; /* Allow wrapping */
				}
			</style>
			<body>
				<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'AUTHOR' or //user_role_code = 'UNIT'">
					<script   type="text/javascript">
					</script>
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
							<td valign="top" height="350" CLASS="CONTENT">
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
									<!--   sa_opus_lst.aspx?artifex=1&lng=BRITANNIA-->
								</a> &#62; <!--&#62;  <xsl:value-of select="//sa_nauta_lst" /> -->
								<a>
									<xsl:attribute name="href">
										javascript:document.frmSession.action='sa_opus_optum.aspx?opus=<xsl:value-of select="//opus_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
									</xsl:attribute>
									<xsl:value-of select="//OpusName1" />
								</a> &#62; <a>
									<xsl:attribute name="href">
										<!-- home work  sa_nautaLaborio_lst.aspx?opus=1&artifex=3993&lng=BRITANNIA -->
										sa_nauta_lst.aspx?opus=<xsl:value-of select="//opus_id" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />
									</xsl:attribute>
									<xsl:value-of select="//sa_nauta_lst" />
									<!--   sa_nauta_lst.aspx?opus=1&artifex=3993&lng=BRITANNIA-->
								</a> &#62; <b>
									<xsl:value-of select="//sa_nautaLaborio_lst" />
								</b>
								<p />

								<!-- TABLE OF WORKS -->

								<p>
									<b>
										<xsl:value-of select="//sa_nautaLaborio_lst" />:  <xsl:value-of select="//nm_nauta" /> (<xsl:value-of select="//ds_login" />)
									</b>
								</p>
								<table border="0" cellpadding="6" align="center">
									<td CLASS="TITLE_LIGHT">
										<b>ID</b>
									</td>
									<td CLASS="TITLE_LIGHT">
										<b>PAGINA</b>
									</td>
									<td CLASS="TITLE_LIGHT" width="45%">
										<b>LABOR</b>
									</td>
									<td CLASS="TITLE_LIGHT" width="5%">
										<b>PUNCTUM</b> 
									</td>
									<td CLASS="TITLE_LIGHT">
										<b><xsl:value-of select="//L_COMMENTS" /></b>
									</td>
									<td CLASS="TITLE_LIGHT">
										<xsl:value-of select="//L_Action" />
									</td>
									<xsl:for-each select="/doc/sa_opus_lst_page/opus">
										<tr CLASS="TITLE_LIGHT">
											<td>
												<xsl:value-of select="id_pagina" />
												<a>
													<xsl:attribute name="id">
														<xsl:value-of select="id_pagina" />
													</xsl:attribute>
												</a>
											</td>
											<td >
												<a>
													<xsl:attribute name="href">
														../src/pagina.aspx?lng=<xsl:value-of select="//language" />&#38;opus=<xsl:value-of select="//opus_id" />&#38;pagina=<xsl:value-of select="id_pagina" />
													</xsl:attribute>
													<xsl:value-of select="title" />
												</a>
											</td>
											<td class="column-1">
												<xsl:if test="ds_file != ''">
													<div>
														<xsl:attribute name="id">labor<xsl:value-of select="id_pagina"/></xsl:attribute>
														<xsl:value-of select="ds_labor" />
													</div>													
													<script>
														MarkdownToHtml('labor<xsl:value-of select="id_pagina"/>');
													</script>
												</xsl:if>
												<xsl:if test="ds_file = ''">
													<p> Not Submitted </p>
												</xsl:if>
											</td>
											<td CLASS="TITLE_LIGHT">
												<input type="text" name="fname" maxlength="3" size="3">
													<xsl:attribute name="id">score<xsl:value-of select="id_pagina" /></xsl:attribute>
													<xsl:attribute name="value"><xsl:value-of select="grade_con" /></xsl:attribute>
												</input>
											</td>
											<td CLASS="TITLE_LIGHT">
												<textarea rows="10" cols="30" name="txt_area">
													<xsl:attribute name="id">txt<xsl:value-of select="id_pagina" /></xsl:attribute>
													<xsl:value-of select="comment_con" />
												</textarea>
											</td>
											<td CLASS="TITLE_LIGHT">
												<input type="button"  value="Update">
													<xsl:attribute name="onclick">send_comments(<xsl:value-of select="//user_id" />, <xsl:value-of select="id_nauta" />,<xsl:value-of select="id_opus" />,<xsl:value-of select="id_pagina" /> );</xsl:attribute>
												</input>
											</td>
											<script>
												change_color(<xsl:value-of select="update_status_" />,<xsl:value-of select="id_pagina" />);
											</script>
										</tr>
									</xsl:for-each>
									<tr> </tr>
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
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>