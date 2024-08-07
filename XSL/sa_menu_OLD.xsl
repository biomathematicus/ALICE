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
				<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'AUTHOR' or //user_role_code = 'UNIT'">
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
								<table border="0" cellpadding="6" align="center">
									<tr>
										<td CLASS="TITLE_DARK">
											<b>
												<xsl:value-of select="//user_role_name" />
											</b>
										</td>
									</tr>
									<!-- Visible only to the admnistrator -->
									<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'AUTHOR' or //user_role_code = 'UNIT'">
										<tr>
											<td CLASS="TITLE_LIGHT">
												<a>
													<xsl:attribute name="href">
														sa_opus_lst.aspx?artifex=1&#38;lng=<xsl:value-of select="//language" />
													</xsl:attribute>
													<xsl:value-of select="//sa_opus_lst" />
												</a>
												<!--a>
												  <xsl:attribute name="href">
													  sa_artifex_lst.aspx?lng=<xsl:value-of select="//language" />
												  </xsl:attribute>
												  <xsl:value-of select="//sa_artifex_lst" />
												</a -->
											</td>
										</tr>
										<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'AUTHOR'">
											<tr>
												<td>
													<b>INBOX</b>
												</td>
											</tr>
											<xsl:for-each select="/doc/inbox/labor">
												<tr  CLASS="TITLE_LIGHT">
													<td>
														<b>STUDENT:</b>&#160;  <xsl:value-of select="nm_nauta" /> (<xsl:value-of select="ds_login" />)
														<br/>
														<b>OPUS:</b>&#160;
														<xsl:value-of select="opus_title" />
														<br/>
														<b>PAGINA:</b>&#160;
														<a>
															<xsl:attribute name="href">sa_nautaLaborio_lst.aspx?id_nauta=<xsl:value-of select="id_nauta"/>&#38;opus=<xsl:value-of select="id_opus"/>&#38;lng=<xsl:value-of select="//language" />#<xsl:value-of select="id_pagina"/></xsl:attribute>
															<xsl:value-of select="pagina_title" />
														</a>
														<br/>
														<b>WAIT:</b>&#160; <xsl:value-of select="wait" /> hours
														<br/>
														<b>Submitted:</b>&#160; <xsl:value-of select="dt_upload" />
														<br/>
														<div>
															<xsl:attribute name="id">labor<xsl:value-of select="id_pagina"/></xsl:attribute>
															<xsl:value-of select="ds_labor" />
														</div>
														<script>
															MarkdownToHtml('labor<xsl:value-of select="id_pagina"/>'); 
														</script>
													</td>
												</tr>
											</xsl:for-each>
										</xsl:if>
										<xsl:if test="//user_role_code = 'ADMIN'">
											<tr>
												<td CLASS="TITLE_LIGHT">
													<a>
														<xsl:attribute name="href">
															sa_nuntius_lst.aspx?lng=<xsl:value-of select="//language" />
														</xsl:attribute>
														<xsl:value-of select="//sa_nuntius_lst" />
													</a>
												</td>
											</tr>
											<tr>
												<td CLASS="TITLE_LIGHT">
													<a href="folio.aspx" target="_blank" >Folio</a>
												</td>
											</tr>
										</xsl:if>
										<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'UNIT'">
										<tr>
											<td CLASS="TITLE_DARK">
												<b>
													<xsl:value-of select="//sa_reading_rpt" /> - NAUTA
												</b>
											</td>
										</tr>
										<tr>
											<td CLASS="TITLE_LIGHT">
												<a>
													<xsl:attribute name="href">
														../admin/sa_reading_lst.aspx?lng=<xsl:value-of select="//language" />&#38;group=ADMIN&#38;lng=<xsl:value-of select="//language" />
													</xsl:attribute>
													NAUTA
												</a>
											</td>
										</tr>
										<tr>
											<td CLASS="TITLE_DARK">
												<b>
													<xsl:value-of select="//sa_reading_rpt" /> - OPUS
												</b>
											</td>
										</tr>
										<xsl:for-each select="/doc/reading_groups/opus">
											<tr>
												<td CLASS="TITLE_LIGHT">
													<span class='XSMALL'>
														<xsl:value-of select="id_opus" /> -
													</span>
													<a>
														<xsl:attribute name="href">
															../admin/sa_reading_lst.aspx?lng=<xsl:value-of select="//language" />&#38;group=<xsl:value-of select="cd_classis" />&#38;action=OPUS&#38;id_opus=<xsl:value-of select="id_opus" />
														</xsl:attribute>
														<span class='XSMALL'>
															<xsl:value-of select="ds_title" />
														</span>
													</a>
												</td>
											</tr>
										</xsl:for-each>
										</xsl:if>
									</xsl:if>
								</table>
								<!-- ************  ENDS CONTENT  ************ -->
							</td>
						</tr>
						<tr>
							<td align="center">
								<xsl:apply-templates select="//footer" />
							</td>
						</tr>
					</table>
				</xsl:if>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>