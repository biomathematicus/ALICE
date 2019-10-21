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

          <script   type="text/javascript"    >
<!-- show(<xsl:value-of select="/doc/id_pagina"/>,'<xsl:value-of select="//user_name"/>','<xsl:value-of select="//ds_opus"/>', '<xsl:value-of select="/doc/pag_title"/>','<xsl:value-of select="//user_id"/>','<xsl:value-of select="//id_opus"/>' ,'<xsl:value-of select="/doc/cd_new_id"/>' )
                            </xsl:attribute>-->

          </script>

          <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
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
						<td valign="top" height="350" CLASS="MEDIUM" align="left">
							<!-- ************ BEGINS CONTENT ************ -->
							<!-- Breadcrumbs Begin -->
              <table>
                <tr>
                  <td style="white-space: nowrap">
                    <a>
                      <xsl:attribute name="href">
                        initium.aspx?lng=<xsl:value-of select="//language" />
                      </xsl:attribute>
                      <span class="MEDIUM">
                        <xsl:value-of select="//P_INITIUM"/>
                      </span>
                    </a> <B>&#62;</B>
                    <a>
                      <xsl:attribute name="href">
                        index.aspx?lng=<xsl:value-of select="//language" />
                      </xsl:attribute>
                      <span class="MEDIUM">
                        <xsl:value-of select="//P_INDEX"/>
                      </span>
                    </a>
                    <B>&#62;</B>
                    <span class="BOLDMEDIUM">
                      <xsl:value-of select="//ds_opus"/>
                    </span>
                  </td>
                  <td width="80%"></td>
                  <xsl:if test="//user_id != ''">
                    
                   <tr>
                      <td colspan="2" class="TITLE_DARK">
                        <!-- Page Status-->
                        <xsl:apply-templates select="//page_counter" />
                      </td>
                    </tr>

                  </xsl:if>
                </tr>
              </table>
              <!-- Breadcrumbs End -->
              <p/>
							<form name="p_pagina" method="post" action="">
                <xsl:variable name="id_user_login" select="//user_logon" />
                <xsl:variable name="log_off" select="iob" />
                <xsl:if test="//user_logon = 'LOGGED-OFF'"    >
                  <xsl:value-of select="//T_REGIS_WARNING" disable-output-escaping="yes" />
                </xsl:if>
                <table border="0" cellpadding="2" align="left"  CLASS="CONTENT" width="100%">
                <!-- tr>
									<td colspan="2" CLASS="TITLE_DARK">
										<xsl:apply-templates select="//page_counter" />
									</td>
								</tr -->
								<tr>
									<td colspan="2" CLASS="TITLE_LIGHT">
										<xsl:choose>
											<xsl:when test="/doc/param/user_status[. = '3']">
												<!-- <xsl:value-of select="//L_PAGE"/>:  -->
												<span class="H1">
													<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
														<xsl:attribute name="href">javascript:document.frmSession.action='../admin/sa_pagina_dtl.aspx?lng=<xsl:value-of select="//language" />&#38;pagina=<xsl:value-of select="//id_pagina"/>&#38;opus=<xsl:value-of select="//id_opus" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();</xsl:attribute>
														<xsl:value-of select="//pag_title" />
													</a>
												</span>
											</xsl:when>
											<xsl:otherwise>
                        <!-- <xsl:value-of select="//L_PAGE"/>:  --> <span class="H1"><xsl:value-of select="//pag_title" /></span>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
								<tr>
									<td colspan="2" CLASS="CONTENT">
                    <!-- Begin tabulated menu -->
                    <table border="0" cellspacing="1" cellpadding="2" id="tblTab" name="tblTab" >
                      <tr>
                        <td width="74" id="tabIntro" class="TabOn" background="../images/system/bgd_tab_80x20.gif">
                          <a href="javascript:LoadTab('Intro')">Intro</a>
                        </td>
                        <td width="74" id="tabWiki" class="TabOff" style="visibility:hidden; display:none" background="../images/system/bgd_tab_80x20.gif">
                          <a href="javascript:LoadTab('Wiki');">Wiki</a>
                        </td>
                        <td width="74" id="tabPDF" class="TabOff" style="visibility:hidden; display:none" background="../images/system/bgd_tab_80x20.gif">
                          <a href="javascript:LoadTab('PDF');">PDF</a>
                        </td>
                        <td width="74" id="tabLiveScribe" class="TabOff" style="visibility:hidden; display:none" background="../images/system/bgd_tab_80x20.gif">
                          <a href="javascript:LoadTab('LiveScribe');">Livescribe</a>
                        </td>
                        <td width="74" id="tabMedia" class="TabOff" style="visibility:hidden; display:none" background="../images/system/bgd_tab_80x20.gif">
                          <a href="javascript:LoadTab('Media');">Media</a>
                        </td>
                        <td width="74" id="tabSource" class="TabOff" style="visibility:hidden; display:none" background="../images/system/bgd_tab_80x20.gif">
                          <a href="javascript:LoadTab('Source');">Source</a>
                        </td>
                        <xsl:if test="//user_logon !='LOGGED-OFF'">
                        <td width="74" id="tabTest" class="TabOff" background="../images/system/bgd_tab_80x20.gif">
                          <a href="javascript:LoadTab('Test');">Test</a>
                        </td>
                        </xsl:if>
                        
                      </tr>
                    </table>
		                <!-- Blue line -->
                    <xsl:text disable-output-escaping="yes">
		                <![CDATA[<table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td height="1" class="TabOff" colspan="15"><img src="../images/system/px_alpha.gif" height="1" width=""/></td></tr></table>]]>
		                </xsl:text>
                    <!-- End tabulated menu -->
                    <div id="container"></div>										
                    <div id="Wiki" style="visibility:hidden; display:none"><br/>No WIKI content has been added in this category.<br/><br/><br/><br/></div>
                    <div id="PDF" style="visibility:hidden; display:none"><br/>No PDF content has been added in this category.<br/><br/><br/><br/></div>
                    <div id="LiveScribe" style="visibility:hidden; display:none"><br/>No Livescribe content has been added in this category.<br/><br/><br/><br/></div>
                    <div id="Media" style="visibility:hidden; display:none"><br/>No MEDIA content has been added in this category.<br/><br/><br/><br/></div>
                    <div id="Source" style="visibility:hidden; display:none"><br/>No SOURCE content has been added in this category.<br/><br/><br/><br/></div>
 
                    <!-- test tab -->
                  <!--new pdf tab-->

                    <div id="PDF1"   >

                    </div>


                    <!--end of pdf tab-->
                    
                    
                    
                    
                    <xsl:if test="//user_logon !='LOGGED-OFF'">

                      <div id="Test" style="visibility:visible; display:none">
                      <form id="frmUpload" runat="server">
                        <input id="state" type="hidden">
                          <xsl:attribute name="value">
                            <xsl:value-of select="//language" />
                          </xsl:attribute>
                        </input>

                          <xsl:choose>
                            <xsl:when test="//take='0'">
                              <div>
                            <input type="file" accept=".pdf,.doc,.docx,.rtf" >
                            <xsl:attribute name="id"  >
                              <xsl:value-of select="/doc/id_pagina"/>
                            </xsl:attribute>
                          </input>
                          <input type="button" id="btnUpload" value="Upload Files"  >
                            <xsl:attribute name="onclick">
                              show(<xsl:value-of select="/doc/id_pagina"/>,'<xsl:value-of select="//user_name"/>',' ', '  ','<xsl:value-of select="//user_id"/>','<xsl:value-of select="//id_opus"/>' ,'<xsl:value-of select="/doc/cd_new_id"/>' )
                            </xsl:attribute>

                          </input>
                              </div>
                            </xsl:when>
                          </xsl:choose>

                        <xsl:choose>
                          <xsl:when test="//take &gt;'0'">
                            <div>

                              <a id="myLink" href="#">

                                <xsl:attribute name="onclick">produce_add( '<xsl:value-of select="//link_homework"/>') </xsl:attribute> <xsl:value-of select="//L_SEE_HM" /> </a>
       
                              <p>
                                <xsl:value-of select="//L_UPLOADED_HM" />                               </p>
                            </div>
                          </xsl:when>
                        </xsl:choose>
   
                        <!--upload home work-->
                        <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                          <xsl:attribute name="href" >
                            javascript:document.frmSession.action='../src/upload.aspx?lng=<xsl:value-of select="//language" />&#38;pagina=<xsl:value-of select="//id_pagina"/>&#38;opus=<xsl:value-of select="//id_opus" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
                          </xsl:attribute>
                          <xsl:value-of select="//L_SEE_SB_HM" />
                          <!--     <xsl:value-of select="//pag_title" /> -->
                        </a>
                        <!--upload home work-->
                      </form>
                    </div>
                    </xsl:if>

                    <div id="Intro" >
                      <xsl:value-of select="//pag_content"  disable-output-escaping="yes"/>
                    </div>
                    <script>LoadTab("Intro"); </script>
                    
                  </td>
								</tr>
                

							<tr><td colspan="2"><p>&#160;</p></td></tr>
								<xsl:if test="/doc/pending/link[. != '']">
								<tr>
									<td align="left" CLASS="TITLE_LIGHT" colspan="2">
										<span class="BOLDMEDIUM"><xsl:value-of select="//L_LINK_PENDING" disable-output-escaping="yes"/></span>
									</td>
								</tr>
								<tr>
									<td align="left"  CLASS="MEDIUM" colspan="2">
										<xsl:for-each select="/doc/pending/link">
											<xsl:value-of select="score"/>%&#160;  
											<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
												<xsl:attribute name="href">javascript:Page('<xsl:value-of select="//language"/>','<xsl:value-of select="//id_opus"/>','<xsl:value-of select="id_pagina"/>')</xsl:attribute>
												<xsl:value-of select="ds_title"/>
											</a>
											<br/>
											<xsl:value-of select="ds_tag"/><br/><br/>
										</xsl:for-each>
									</td>
								</tr>
								</xsl:if>
                  
								<xsl:if test="//cd_opus != 'LITERATRONIC'">
								<tr>
									<td align="left" CLASS="TITLE_LIGHT" width="50%">
									  <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
										<xsl:attribute name="href">
										  javascript:Page('<xsl:value-of select="//language"/>','<xsl:value-of select="//id_opus"/>','<xsl:value-of select="//pag_prv"/>')
										</xsl:attribute>
										<xsl:value-of select="//L_PREVIOUS" />
									  </a>
									</td>

                  
									<td align="right" CLASS="TITLE_LIGHT" width="50%">
									  <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
										<xsl:attribute name="href">
										  javascript:Page('<xsl:value-of select="//language"/>','<xsl:value-of select="//id_opus"/>','<xsl:value-of select="//pag_nxt"/>')
										</xsl:attribute>
										<xsl:value-of select="//L_NEXT" />
									  </a>
									</td>
								 </tr>
								</xsl:if>
                  
							</table>
							</form>

							<p/>
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
