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
        <xsl:if test="//user_status = 3">
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
              <td valign="top" height="350"  CLASS="CONTENT">
                <!-- ************ BEGINS CONTENT ************ -->
                <!-- BREADCRUMBS -->
                <a>
                  <xsl:attribute name="href">
                    sa_menu.aspx?lng=<xsl:value-of select="//language" />
                  </xsl:attribute>
                  <xsl:value-of select="//sa_menu" />
                </a> &#62;
				<!-- xsl:if test="//user_status = 3">
                  <a>
                    <xsl:attribute name="href">
                      sa_artifex_lst.aspx?lng=<xsl:value-of select="//language" />
                    </xsl:attribute>
                    <xsl:value-of select="//sa_artifex_lst" />
                  </a> &#62;
                </xsl:if -->
				  <a>
                  <xsl:attribute name="href">
                    javascript:document.sa_reticulum_dtl.action='sa_opus_lst.aspx?artifex=<xsl:value-of select="//id_artifex" />&#38;lng=<xsl:value-of select="//language" />';document.sa_reticulum_dtl.submit();
                  </xsl:attribute>
                  <xsl:value-of select="//sa_opus_lst" />
                </a> &#62;
				  <a>
					  <xsl:attribute name="href">
						  javascript:document.frmSession.action='sa_opus_optum.aspx?opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
					  </xsl:attribute>
					  <xsl:value-of select="//opus_name" />&#160;
				  </a> &#62;
				  <a>
                  <xsl:attribute name="href">
                    javascript:document.sa_reticulum_dtl.action='sa_pagina_lst.aspx?opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.sa_reticulum_dtl.submit();
                  </xsl:attribute>
                  <xsl:value-of select="//sa_pagina_lst" />
                </a> &#62;
                <b>
                  <xsl:value-of select="//sa_reticulum_dtl" />
                </b>
                <p />
                <form name="sa_reticulum_dtl" id="sa_reticulum_dtl" method="post">
                  <input type="hidden" name="hAction" />
                  <!-- LIST OF PAGES -->
                  <table border="0" cellpadding="3" align="center">
                    <tr>
                      <td CLASS="TITLE_DARK" colspan="4">
                        <b>
                          <xsl:value-of select="//sa_pagina_lst" />
                          -
                          <xsl:value-of select="//opus_name" />
                        </b>
                      </td>
                    </tr>
                    <tr>
                      <td  CLASS="TITLE_DARK">
                        <xsl:value-of select="/doc/sa_reticulum_dtl/current/id" />
                      </td>
                      <td CLASS="TITLE_LIGHT" colspan="4">
                        <a>
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='sa_pagina_dtl.aspx?pagina=<xsl:value-of select="/doc/sa_reticulum_dtl/current/id" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
                          </xsl:attribute>
                          <xsl:value-of select="/doc/sa_reticulum_dtl/current/title" />
                        </a>
                        <br />
                        <xsl:value-of select="/doc/sa_reticulum_dtl/current/tag" />
                      </td>
                    </tr>
                    <tr>
                      <td colspan="2" CLASS="TITLE_DARK">
                        <strong>
                          <xsl:value-of select="//L_LINKED" />
                        </strong>
                      </td>
                      <td CLASS="TITLE_DARK">
                        <strong>
                          <xsl:value-of select="//L_DISTANCE" />
                        </strong>
                      </td>
                      <td CLASS="TITLE_DARK">
                        &#160;
                      </td>
                    </tr>
                    <xsl:for-each select="/doc/sa_reticulum_dtl/linked/node">
                      <tr valign="top">
                        <td CLASS="TITLE_DARK">
                          <xsl:value-of select="id" />
                        </td>
                        <td CLASS="TITLE_LIGHT">
                          <a>
                            <xsl:attribute name="href">
                              javascript:document.sa_reticulum_dtl.action='sa_reticulum_dtl.aspx?pagina=<xsl:value-of select="id" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.sa_reticulum_dtl.hAction.value = '';document.sa_reticulum_dtl.submit();
                            </xsl:attribute>
                            <xsl:value-of select="title" />
                          </a>
                          <br />
                          <xsl:value-of select="tag" />
                        </td>
                        <td CLASS="TITLE_LIGHT" nowrap="">
                          <strong>
                            <xsl:value-of select="value" />
                          </strong>
                          <br />
                          <xsl:value-of select="link_type" />
                        </td>
                        <td width="20px">&#160;</td>
                        <td CLASS="TITLE_WARNING">
                          <a>
                            <xsl:attribute name="href">
                              javascript:document.sa_reticulum_dtl.action='sa_reticulum_dtl.aspx?node=<xsl:value-of select="id" />&#38;LinkType=<xsl:value-of select="link_type" />&#38;pagina=<xsl:value-of select="//id_pagina" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.sa_reticulum_dtl.hAction.value = 'borrar';document.sa_reticulum_dtl.submit();
                            </xsl:attribute>
                            <xsl:value-of select="//L_DELETE" />
                          </a>
                        </td>
                      </tr>
                    </xsl:for-each>
                    <tr>
                      <td CLASS="TITLE_DARK" colspan="4">
                        <strong>
                          <xsl:value-of select="//L_NON_LINKED" />
                        </strong><br />
                        <xsl:value-of select="//L_DISTANCE" />: <input name="am_value" id="am_value" type="text" size="6" value="10" />
                        <select name="LinkType" id="LinkType">
                          <option value="PRE-REQ">PRE-REQ</option>
                          <option selected="" value="NEXT">NEXT</option>
                        </select>
                      </td>
                    </tr>
                    <xsl:for-each select="/doc/sa_reticulum_dtl/non_linked/node">
                      <tr valign="top">
                        <td CLASS="TITLE_DARK">
                          <xsl:value-of select="id" />
                        </td>
                        <td CLASS="TITLE_LIGHT">
                          <a>
                            <xsl:attribute name="href">
                              javascript:document.sa_reticulum_dtl.action='sa_reticulum_dtl.aspx?pagina=<xsl:value-of select="id" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.sa_reticulum_dtl.hAction.value = '';document.sa_reticulum_dtl.submit();
                            </xsl:attribute>
                            <xsl:value-of select="title" />
                          </a>
                          <br />
                          <xsl:value-of select="tag" />
                        </td>
                        <td CLASS="TITLE_LIGHT">
                          --
                        </td>
                        <td width="20px">&#160;</td>
                        <td CLASS="TITLE_WARNING">
                          <a>
                            <xsl:attribute name="href">
                              javascript:document.sa_reticulum_dtl.action='sa_reticulum_dtl.aspx?node=<xsl:value-of select="id" />&#38;pagina=<xsl:value-of select="//id_pagina" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.sa_reticulum_dtl.hAction.value = 'agregar';document.sa_reticulum_dtl.submit();
                            </xsl:attribute>
                            <xsl:value-of select="//L_NEW" />
                          </a>
                        </td>
                      </tr>
                    </xsl:for-each>
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
        </xsl:if>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>