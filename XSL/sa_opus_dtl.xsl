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
				<table width="600" align="center" border="0" cellpadding="0" cellspacing="0">
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
                <xsl:value-of select="//sa_menu"/>
              </a> &#62;
              <xsl:if test="//user_id = 1">
                <a>
                  <xsl:attribute name="href">
                    sa_artifex_lst.aspx?lng=<xsl:value-of select="//language" />
                  </xsl:attribute>
                  <xsl:value-of select="//sa_artifex_lst"/>
                </a> &#62;
              </xsl:if>
              <a>
								<xsl:attribute name="href">javascript:document.frmSession.action='sa_opus_lst.aspx?artifex=<xsl:value-of select="//id_artifex"/>&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();</xsl:attribute>
								<xsl:value-of select="//sa_opus_lst" />
							</a> &#62;
							<b><xsl:value-of select="//sa_opus_dtl"/></b>
							<p/>
							<!-- TABLE WITH DATA -->
							<form name="sa_opus_dtl" method="post" action="">
							<table border="0" cellpadding="2" align="center"  CLASS="CONTENT">
								<tr>
									<td colspan="2" CLASS="TITLE_DARK">
										<b><xsl:value-of select="//sa_opus_dtl"/> 
										- 
										<xsl:value-of select="//opus_name"/></b><br/>
										<a>
											<xsl:attribute name="href">javascript:document.frmSession.action='../BBS_<xsl:value-of select="//language"/>/admin/select_forum_members.asp';document.frmSession.submit();</xsl:attribute>
											<xsl:value-of select="//artifex_name" />
										</a>									
									</td>
									<td CLASS="TITLE_DARK" ALIGN="right">
										<input type="button">
											<xsl:attribute name="onclick">javascript:document.sa_opus_dtl.hAction.value='<xsl:value-of select="/doc/sa_opus_dtl/hAction" />';document.sa_opus_dtl.language.value='<xsl:value-of select="//language" />';document.sa_opus_dtl.action='sa_opus_dtl.aspx?redirect=true&#38;lng=<xsl:value-of select="//language" />';document.sa_opus_dtl.submit();
                      </xsl:attribute>
                      <xsl:attribute name="value">
                        <xsl:choose>
                          <xsl:when test="//hAction = 'Borrar'">
                            <xsl:value-of select="//L_SA_DELETE" />
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="//L_SA_UPDATE" />
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                    </input>
                  </td>
                </tr>
                <tr>
                  <td CLASS="TITLE_LIGHT" valign="top">
                    <xsl:value-of select="//L_SA_AUTHOR" />
                  </td>
                  <td CLASS="TITLE_LIGHT" COLSPAN="2">
                    <xsl:value-of select="//artifex_name" />
                    <input type="hidden" name="id_artifex">
                      <xsl:attribute name="value">
                        <xsl:value-of select="//id_artifex" />
                      </xsl:attribute>
                    </input>
                  </td>
                </tr>
                <xsl:choose>
                  <xsl:when test="//user_id = 1">
                    <!-- If the user is adminsitrator, then allow to edit visibility status -->
                    <tr>
                      <td CLASS="TITLE_LIGHT" valign="top" nowrap="">
                        Visible
                      </td>
                      <td CLASS="TITLE_LIGHT" COLSPAN="2">
                        <xsl:choose>
                          <xsl:when test="//in_visible[.=1]">
                            <input type="checkbox" name="in_visible" checked="" />
                          </xsl:when>
                          <xsl:otherwise>
                            <input type="checkbox" name="in_visible"  />
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                    </tr>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- If the user not adminsitrator, then hide visibility status -->
                    <tr>
                      <td CLASS="TITLE_LIGHT" valign="top" nowrap="" colspan="3">
                        <xsl:choose>
                          <xsl:when test="//in_visible[.=1]">
                            <input type="hidden" name="in_visible" value="on" />
                          </xsl:when>
                          <xsl:otherwise>
                            <input type="hidden" name="in_visible"  />
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                    </tr>
                  </xsl:otherwise>
                </xsl:choose>
                <tr>
                  <td CLASS="TITLE_LIGHT" valign="top" nowrap="">
                    <xsl:value-of select="//L_SA_TYPE" />
                  </td>
                  <td CLASS="TITLE_LIGHT" COLSPAN="2">
                    <select name="cd_opus_type" id="cd_opus_type">
                      <option value="LITERATRONIC" selected="true">Literatr&#243;nica</option>
                      <option value="CONTEMPORARY">Contempor&#225;neo</option>
                      <option value="CLASSIC">Cl&#225;sico</option>
                      <option value="ESSAY">Ensayo</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td CLASS="TITLE_LIGHT" valign="top">
                    <xsl:value-of select="//L_SA_BOOK" /> ID
                  </td>
                  <td CLASS="TITLE_LIGHT" COLSPAN="2">
                    <xsl:value-of select="//id_opus" />
                    <input type="hidden" name="id_opus">
                      <xsl:attribute name="value">
                        <xsl:value-of select="//id_opus" />
                      </xsl:attribute>
                    </input>
                  </td>
                </tr>
                <tr>
                  <td CLASS="TITLE_LIGHT">
                    &#160;
                  </td>
                  <td CLASS="TITLE_DARK" align="center">
                    <b>HISPANIA</b>
                  </td>
                  <td CLASS="TITLE_DARK" align="center">
                    <b>BRITANNIA</b>
                  </td>
                </tr>
                <tr>
                  <td CLASS="TITLE_LIGHT" valign="top">
                    <xsl:value-of select="//L_SA_TITLE" />
                  </td>
                  <td CLASS="TITLE_LIGHT" align="center">
                    <input type="text" name="ds_title_his" size="40">
                      <xsl:attribute name="value">
                        <xsl:value-of select="//ds_title_his" />
                      </xsl:attribute>
                    </input>
                  </td>
                  <td CLASS="TITLE_LIGHT" align="center">
                    <input type="text" name="ds_title_bri" size="40">
                      <xsl:attribute name="value">
                        <xsl:value-of select="//ds_title_bri" />
                      </xsl:attribute>
                    </input>
                  </td>
                </tr>
                <xsl:if test="//id_opus > 0">
                  <tr>
                    <td CLASS="TITLE_LIGHT"></td>
                    <td  CLASS="TITLE_LIGHT" colspan="2">
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_nuntius_dtl.aspx?nuntius=OPUS_ABOUT_<xsl:value-of select="//id_opus"/>&amp;author=true&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
                      </xsl:attribute>
                        <xsl:value-of select="//L_SA_ABOUT" />
                      </a>
                    </td>
                  </tr>
                </xsl:if>
								<tr>
									<td CLASS="TITLE_LIGHT" valign="top">
										<xsl:value-of select="//L_SA_TAG" />
									</td>
									<td CLASS="TITLE_LIGHT">
										<textarea name="ds_tag_his" cols="40" rows="5" wrap="VIRTUAL">
											<xsl:value-of select="//ds_tag_his" />
										</textarea>
									</td>
									<td CLASS="TITLE_LIGHT">
										<textarea name="ds_tag_bri" cols="40" rows="5" wrap="VIRTUAL">
											<xsl:value-of select="//ds_tag_bri" />
										</textarea>
									</td>
								</tr>
								<tr>
									<td CLASS="TITLE_LIGHT" valign="top">
										<xsl:value-of select="//L_SA_CONTENT" />
									</td>
									<td CLASS="TITLE_LIGHT">
										<textarea name="ds_content_his" cols="40" rows="17" wrap="VIRTUAL">
											<xsl:value-of select="//ds_content_his" />
										</textarea>
									</td>
									<td CLASS="TITLE_LIGHT">
										<textarea name="ds_content_bri" cols="40" rows="17" wrap="VIRTUAL">
											<xsl:value-of select="//ds_content_bri" />
										</textarea>
									</td>
								</tr>
								<tr>
									<td CLASS="TITLE_DARK" ALIGN="right" COLSPAN="3">
										<input type="hidden" name="language">
											<xsl:attribute name="value">
												<xsl:value-of select="//cd_lingua" />
											</xsl:attribute>											
										</input>
										<input type="hidden" name="hAction"/>
										<input type="button">
											<xsl:attribute name="onclick">javascript:document.sa_opus_dtl.hAction.value = '<xsl:value-of select="/doc/sa_opus_dtl/hAction" />';document.sa_opus_dtl.language.value='<xsl:value-of select="//language" />';document.sa_opus_dtl.action='sa_opus_dtl.aspx?redirect=true&#38;lng=<xsl:value-of select="//language" />';document.sa_opus_dtl.submit();</xsl:attribute>
                      <xsl:attribute name="value">
                        <xsl:choose>
                          <xsl:when test="//hAction = 'Borrar'">
                            <xsl:value-of select="//L_SA_DELETE" />
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="//L_SA_UPDATE" />
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
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
