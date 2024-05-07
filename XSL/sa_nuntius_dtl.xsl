<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
						<td valign="top" height="350" CLASS="CONTENT">
							<!-- ************ BEGINS CONTENT ************ -->
							<!-- BREADCRUMBS -->
							<a>
                <xsl:attribute name="href">
                  sa_menu.aspx?lng=<xsl:value-of select="//language" />
                </xsl:attribute>
                <xsl:value-of select="//sa_menu" />
              </a> &#62;
              <xsl:choose>
                <xsl:when test="//user_id =1">
                  <a>
                    <xsl:attribute name="href">
                      sa_nuntius_lst.aspx?lng=<xsl:value-of select="//language" />
                    </xsl:attribute>
                    <xsl:value-of select="//sa_nuntius_lst" />
                  </a> &#62;
                </xsl:when>
                <xsl:otherwise>
                  <a>
                    <xsl:attribute name="href">
                      javascript:document.frmSession.action='sa_opus_lst.aspx?artifex=<xsl:value-of select="//user_id" />&amp;author=true&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
                    </xsl:attribute>
                    <xsl:value-of select="/doc/admin_tags/sa_opus_lst" />
                  </a> &#62;
                </xsl:otherwise>
              </xsl:choose>
							<b><xsl:value-of select="//sa_nuntius_dtl" /></b>
							<p />
							<!-- TABLE WITH DATA -->
							<form name="sa_nuntius_dtl" method="post" action="">
							<table border="0" cellpadding="2" align="center"  CLASS="CONTENT">
								<tr>
									<td CLASS="TITLE_DARK">
										<b><xsl:value-of select="//sa_nuntius_dtl" /></b>
										-
										<xsl:choose>
											<xsl:when test="/doc/sa_nuntius_dtl/hAction[. = 'Agregar']">
												<input type="text" name="cd_nuntius" cols="40">
													<xsl:attribute name="value">
														<xsl:value-of select="//cd_nuntius" />
													</xsl:attribute>
												</input>
											</xsl:when>
											<xsl:otherwise>
												<b><xsl:value-of select="//cd_nuntius" /></b>
												<input type="hidden" name="cd_nuntius">
													<xsl:attribute name="value">
														<xsl:value-of select="//cd_nuntius" />
													</xsl:attribute>
												</input>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td CLASS="TITLE_DARK" align="right">
										<input type="button">
											<xsl:attribute name="onclick">javascript:document.sa_nuntius_dtl.hAction.value = '<xsl:value-of select="/doc/sa_nuntius_dtl/hAction" />';document.sa_nuntius_dtl.action='sa_nuntius_dtl.aspx?redirect=true&#38;lng=<xsl:value-of select="//language" />';document.sa_nuntius_dtl.submit();</xsl:attribute>
											<xsl:attribute name="value"><xsl:value-of select="/doc/sa_nuntius_dtl/hAction" /></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td CLASS="TITLE_LIGHT">
										<b>HISPANIA</b>
									</td>
									<td CLASS="TITLE_LIGHT">
										<b>BRITANNIA</b>
									</td>
								</tr>
								<tr>
									<td CLASS="TITLE_LIGHT">
										<textarea name="ds_nuntius_his" cols="40" rows="17" wrap="VIRTUAL">
											<xsl:value-of select="//ds_nuntius_his" disable-output-escaping="yes" />
										</textarea>
									</td>
									<td CLASS="TITLE_LIGHT">
										<textarea name="ds_nuntius_bri" cols="40" rows="17" wrap="VIRTUAL">
											<xsl:value-of select="//ds_nuntius_bri" disable-output-escaping="yes" />
										</textarea>
									</td>
								</tr>
								<tr>
									<td CLASS="TITLE_LIGHT" COLSPAN="2"  align="right">
										<input type="hidden" name="cd_lingua">
											<xsl:attribute name="value">
												<xsl:value-of select="//cd_lingua" />
											</xsl:attribute>
										</input>
										<input type="hidden" name="hAction" />
										<input type="button">
											<xsl:attribute name="onclick">javascript:document.sa_nuntius_dtl.hAction.value = '<xsl:value-of select="/doc/sa_nuntius_dtl/hAction" />';document.sa_nuntius_dtl.action='sa_nuntius_dtl.aspx?redirect=true&#38;lng=<xsl:value-of select="//language" />';document.sa_nuntius_dtl.submit();</xsl:attribute>
											<xsl:attribute name="value"><xsl:value-of select="/doc/sa_nuntius_dtl/hAction" /></xsl:attribute>
										</input>
									</td>
								</tr>
							</table>
							</form>
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