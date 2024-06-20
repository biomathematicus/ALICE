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
								</a> &#62;
								<a>
									<xsl:attribute name="href">
										javascript:document.frmSession.action='sa_opus_optum.aspx?opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
									</xsl:attribute>
									<xsl:value-of select="//ds_opus" />
								</a> &#62; <b>
									<xsl:value-of select="//sa_nauta_lst" />
								</b>
								<p />

								<!-- TABLE OF WORKS -->

								<input type="hidden" name="myText" value="testValue" />
								<select CLASS="TITLE_LIGHT" id="lstChorus_id" name="lstChorus" >
									<xsl:attribute name="onchange">
										javascript:redirect_nauta_lst('<xsl:value-of select="//language" />', <xsl:value-of select="//id_opus" />,<xsl:value-of select="//artifex_id" />,this);
									</xsl:attribute>
									<xsl:for-each select="/doc/sa_opus_lst/chorus">
										<option>
											<xsl:attribute name="value">
												<xsl:value-of select="id_chorus" />
											</xsl:attribute>
											<xsl:value-of select="ds_chorus" />
										</option>
									</xsl:for-each>
								</select>
								<table border="0" cellpadding="6" align="center">
									<!--*********************************************************************************-->
									<tr CLASS="TITLE_DARK">
										<td>
											<b>NAUTA</b>
										</td>
										<td>
											<b>LABOR</b>
										</td>
										<td>
											
										</td>
										<td>
											
										</td>
									</tr>
									<!--*********************************************************************************-->
									<xsl:for-each select="/doc/sa_opus_lst/nauta">
										<tr  CLASS="TITLE_LIGHT">
											<td>
												<xsl:value-of select="nm_nauta" />
											</td>
											<td>
												<xsl:value-of select="count" />
											</td>
											<td>
												<a>
													<xsl:attribute name="href">
														javascript:document.frmSession.action='sa_nautaLaborio_lst.aspx?id_nauta=<xsl:value-of select="id_nauta" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
													</xsl:attribute>
													<xsl:value-of select="/doc/admin_tags/sa_nautaLaborio_lst" />
												</a>
											</td>
											<td>
												<a>
													<xsl:attribute name="href">
														javascript:document.frmSession.action='sa_reading_rpt.aspx?opus=<xsl:value-of select="//id_opus" />&#38;nauta=<xsl:value-of select="ds_login" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();</xsl:attribute>
													<xsl:value-of select="/doc/admin_tags/sa_nautaVia_lst" />
												</a>
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
				</xsl:if>
				<script type="text/javascript">

					$( document ).ready(function() {
					$('#lstChorus_id > option[value="<xsl:value-of select="//previous_chorus" />"]').attr("selected", "selected")

					});
				</script>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>