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
			<body>				
				<table width="800px" align="center" border="0" cellpadding="0" cellspacing="0">
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
						<td valign="top" height="350" align="left" >
							<!-- ************ BEGINS CONTENT ************ -->
							<table width="100%" border="0" cellpadding="1" cellspacing="1">
								<tr>
									<td width="50%" valign="top"><xsl:value-of select="//T_DEFINITION" disable-output-escaping="yes"/></td>
									<td width="50%" valign="top"><xsl:value-of select="//T_INTRODUCTION" disable-output-escaping="yes"/></td>
								</tr>
								<tr> 
									<td valign="top">

                    <xsl:if test="//user_logon != 'LOGGED-OFF'"    >

                      <table border="0" cellspacing="1" cellpadding="3" width="100%">
											<tr> 
												<td class="TITLE"><xsl:value-of select="//L_RECOMMENDED"/></td>
											</tr>
											<xsl:for-each select="/doc/randombook"> 
												<tr valign="top"> 
													<td class="TITLE_DARK">
														<!-- Page Status-->
														<xsl:apply-templates select="page_counter" />
													</td>
												</tr>
												<tr valign="top"> 
													<td class="CONTENT">
														<xsl:value-of select="content" disable-output-escaping="yes"/>&#160;
														<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;"> 
															<xsl:attribute name="href">javascript:Page('<xsl:value-of select="//language"/>','<xsl:value-of select="page_counter/id_opus"/>','<xsl:value-of select="page_counter/id_pagina"/>')</xsl:attribute> 
															<xsl:value-of select="//L_MORE" /> 
														</a>														
													</td>
												</tr>
											</xsl:for-each> 
										</table>
                    </xsl:if>
									</td>
                  <xsl:choose>
                    <xsl:when test="//user_logon[. = '']">
                      <td valign="top">
                        <xsl:value-of select="//T_WHY_REGISTER" disable-output-escaping="yes"/>
                      </td>
                    </xsl:when>
                    <xsl:otherwise>
                      <td valign="top">
                        <xsl:for-each select="/doc/recommended">
                          <table border="0" cellpadding="3" cellspacing="0"  valing="top">
                            <tr>
                              <td class="TITLE">
                                <xsl:value-of select="//L_LAST_VISITED"/>
                              </td>                              
                            </tr>
                            <tr valign="top">
                              <td class="TITLE_DARK">
                                <!-- Page Status-->
                                <xsl:apply-templates select="page_counter" />
                              </td>
                            </tr>
                            <tr valign="top">
                              <td class="CONTENT">
                                <span class="REMARK"></span>&#160;
                                <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                                  <xsl:attribute name="href">
                                    javascript:Page('<xsl:value-of select="//language"/>','<xsl:value-of select="page_counter/id_opus"/>','<xsl:value-of select="page_counter/id_pagina"/>')
                                  </xsl:attribute>
                                  <xsl:value-of select="ds_title" />
                                  <xsl:if test="last[. = 'true']">
                                  </xsl:if>
                                </a>: <xsl:value-of select="ds_tag"/>&#160;
                                <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                                  <xsl:attribute name="href">
                                    javascript:Page('<xsl:value-of select="//language"/>','<xsl:value-of select="page_counter/id_opus"/>','<xsl:value-of select="page_counter/id_pagina"/>')
                                  </xsl:attribute>
                                  <xsl:value-of select="//L_MORE" />
                                </a>
                              </td>
                            </tr>
                          </table>
                        </xsl:for-each>
                      </td>
                    </xsl:otherwise>
                  </xsl:choose> 
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
