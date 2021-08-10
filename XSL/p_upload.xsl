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
        <!-- script language="JavaScript" type="text/JavaScript" src="../common/PDF.js" />
        <script language="JavaScript" type="text/JavaScript" src="../common/pdf.worker.js"/ -->

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
                        <xsl:value-of select="//P_INITIUM" />
                      </span>
                    </a>
                    <B>&#62;</B>
                    <a>
                      <xsl:attribute name="href">
                        index.aspx?lng=<xsl:value-of select="//language" />
                      </xsl:attribute>
                      <span class="MEDIUM">
                        <xsl:value-of select="//P_INDEX" />
                      </span>
                    </a>
                    <B>&#62;</B>
                    <span class="BOLDMEDIUM">
                      <xsl:value-of select="//ds_opus" />
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
              <p />
              <form name="p_pagina" method="post" action="">
                <xsl:value-of select="//T_REGIS_WARNING" disable-output-escaping="yes" />
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
                          <!-- <xsl:value-of select="//L_PAGE" />:  -->
                          <span class="H1">
                            <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                              <xsl:attribute name="href">
                                javascript:document.frmSession.action='../admin/sa_pagina_dtl.aspx?lng=<xsl:value-of select="//language" />&#38;pagina=<xsl:value-of select="//id_pagina" />&#38;opus=<xsl:value-of select="//id_opus" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
                              </xsl:attribute>
                              <xsl:value-of select="//pag_title" />
                            </a>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <!-- <xsl:value-of select="//L_PAGE" />:  -->
                          <span class="H1">
                            <xsl:value-of select="//pag_title" />
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2" CLASS="CONTENT">
                      <!-- Begin tabulated menu -->
                      <!-- Blue line -->
                      <xsl:text disable-output-escaping="yes">
		                <![CDATA[<table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td height="1" class="TabOff" colspan="15"><img src="../images/system/px_alpha.gif" height="1" width="" /></td></tr></table>]]>
		                </xsl:text>
                      <!-- End tabulated menu -->
                      <div id="container"></div>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2">
                      <p>&#160;</p>
                    </td>
                  </tr>
                  <xsl:if test="/doc/pending/link[. != '']">
                    <tr>
                      <td align="left" CLASS="TITLE_LIGHT" colspan="2">
                        <span class="BOLDMEDIUM">
                          <xsl:value-of select="//L_LINK_PENDING" disable-output-escaping="yes" />
                        </span>
                      </td>
                    </tr>
                    <tr>
                      <td align="left"  CLASS="MEDIUM" colspan="2">
                        <xsl:for-each select="/doc/pending/link">
                          <xsl:value-of select="score" />%&#160;
                          <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                            <xsl:attribute name="href">
                              javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="id_pagina" />')
                            </xsl:attribute>
                            <xsl:value-of select="ds_title" />
                          </a>
                          <br />
                          <xsl:value-of select="ds_tag" /><br /><br />
                        </xsl:for-each>
                      </td>
                    </tr>
                  </xsl:if>
                  <xsl:if test="//cd_opus != 'LITERATRONIC'">
                    <tr>
                      <td align="left" CLASS="TITLE_LIGHT" width="50%">
                        <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                          <xsl:attribute name="href">
                            javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="//pag_prv" />')
                          </xsl:attribute>
                          <xsl:value-of select="//L_PREVIOUS" />
                        </a>
                      </td>
                      <td align="right" CLASS="TITLE_LIGHT" width="50%">
                        <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                          <xsl:attribute name="href">
                            javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="//pag_nxt" />')
                          </xsl:attribute>
                          <xsl:value-of select="//L_NEXT" />
                        </a>
                      </td>
                    </tr>
                  </xsl:if>
                </table>
              </form>
              <table border="0" cellpadding="2" align="center">
                <tr>
                </tr>

                <!--**************************************************************************************************-->
                <form id="frmUpload" runat="server">

                  <xsl:for-each select="/doc/sa_pagina_lst/pagina">

                    <tr valign="top">
                      <td CLASS="TITLE_DARK">
                        <xsl:value-of select="id" />
                        <a>
                          <xsl:attribute name="name">
                            <xsl:value-of select="id" />
                          </xsl:attribute>
                        </a>
                      </td>
                      <td CLASS="TITLE_LIGHT">
                        <b>
                          <xsl:value-of select="title" />
                        </b>
                        <br />
                        <xsl:value-of select="tag" />
                      </td>
                      <td CLASS="TITLE_LIGHT" align="right" nowrap="">

                        <xsl:choose>
                          <xsl:when test="take='0'">

                            <input type="file" id="FileUpload1" accept=".pdf,.doc,.docx,.rtf">
                              <xsl:attribute name="id">
                                <xsl:value-of select="id" />
                              </xsl:attribute>
                            </input>

                            <input type="button"  value="Upload Files">

                              <xsl:attribute name="onclick">
                                show( <xsl:value-of select="id" />,'<xsl:value-of select="//user_name" />','<xsl:value-of select="//opus_name" />', '<xsl:value-of select="title" />','<xsl:value-of select="//user_id" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="cd_new_id" />' )
                              </xsl:attribute>
                            </input>
                          </xsl:when>
                        </xsl:choose>
                        <xsl:choose>

                          <xsl:when test="//take &gt;'0'">
                            <div>
                              <a id="myLink" href="#">
                                <xsl:attribute name="onclick">
                                  produce_add( '<xsl:value-of select="link_homework" />')
                                </xsl:attribute>
                                <xsl:value-of select="//L_SEE_HM" />
                              </a>
                            </div>
                          </xsl:when>
                        </xsl:choose>

                        <br />
                      </td>
                    </tr>
                  </xsl:for-each>
                </form>
                <!--**************************************************************************************************-->
                <tr>
                  <td CLASS="TITLE_DARK" ALIGN="right" COLSPAN="6">
                  </td>
                </tr>
              </table>
              <p />
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