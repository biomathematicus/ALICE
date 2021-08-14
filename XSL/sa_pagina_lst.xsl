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
              <td valign="top" height="350" CLASS="CONTENT">
                <!-- ************ BEGINS CONTENT ************ -->
                <!-- BREADCRUMBS -->
                <a>
                  <xsl:attribute name="href">
                    sa_menu.aspx?lng=<xsl:value-of select="//language" />
                  </xsl:attribute>
                  <xsl:value-of select="//sa_menu" />
                </a> &#62;
                <xsl:if test="//user_status = 3">
                  <a>
                    <xsl:attribute name="href">
                      sa_artifex_lst.aspx?lng=<xsl:value-of select="//language" />
                    </xsl:attribute>
                    <xsl:value-of select="//sa_artifex_lst" />
                  </a> &#62;
                </xsl:if>
                <a>
                  <xsl:attribute name="href">
                    javascript:document.frmSession.action='sa_opus_lst.aspx?artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
                  </xsl:attribute>
                  <xsl:value-of select="//sa_opus_lst" />
                </a> &#62;
                <b>
                  <xsl:value-of select="//sa_pagina_lst" />
                </b>
                <p />
                <!-- LIST OF PAGES -->
                <table border="0" cellpadding="2" align="center">
                  <tr>
                    <td CLASS="TITLE_DARK" colspan="5">
                      <b>
                        <xsl:value-of select="//sa_pagina_lst" />
                        -
                        <xsl:value-of select="//opus_name" />
                      </b>
                    </td>
                    <td CLASS="TITLE_DARK" align="right" colspan="2">
                      <input type="button">
                        <xsl:attribute name="onclick">
                          javascript:document.frmSession.action='sa_pagina_dtl.aspx?pagina=0&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_agregar';document.frmSession.submit();
                        </xsl:attribute>
                        <xsl:attribute name="value">
                          <xsl:value-of select="//L_NEW" />
                        </xsl:attribute>
                      </input>
                    </td>
                  </tr>
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
                        <a>
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='../src/Pagina.aspx?pagina=<xsl:value-of select="id" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = '';document.frmSession.submit();
                          </xsl:attribute>
                          <xsl:value-of select="title" />
                        </a>
                        <br />
                        <xsl:value-of select="tag" />
                      </td>
                      <td CLASS="TITLE_LIGHT" align="right" nowrap="">
                        <a>
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='sa_pagina_dtl.aspx?pagina=<xsl:value-of select="id" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
                          </xsl:attribute>
                          <xsl:value-of select="/doc/admin_tags/sa_pagina_dtl" />
                        </a><br />
                        Links: <b>
                          <xsl:value-of select="am_link" />
                        </b>
                      </td>
                      <td CLASS="TITLE_LIGHT" nowrap="true" align="right">
                        <a>
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='sa_reticulum_dtl.aspx?pagina=<xsl:value-of select="id" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
                          </xsl:attribute>
                          <xsl:value-of select="/doc/admin_tags/sa_reticulum_dtl" />
                        </a>
                        <br />
                        Next:
                        <b>
                          <xsl:choose>
                            <xsl:when test ="connections = 0">
                              <font color="red">
                                <xsl:value-of select="connections_next" />
                              </font>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="connections_next" />
                            </xsl:otherwise>
                          </xsl:choose>
                        </b><br />
                        Pre-Req:
                        <b>
                          <xsl:choose>
                            <xsl:when test ="connections = 0">
                              <font color="red">
                                <xsl:value-of select="connections_pre-req" />
                              </font>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="connections_pre-req" />
                            </xsl:otherwise>
                          </xsl:choose>
                        </b>
                      </td>
                      <td CLASS="TITLE_LIGHT" nowrap="true" align="right">
                        <a>
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='sa_doctrina_lst.aspx?pagina=<xsl:value-of select="id" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
                          </xsl:attribute>
                          SLOs<!-- <xsl:value-of select="/doc/admin_tags/sa_doctrina_lst" /> -->
                        </a>
                        <br />
                        <xsl:value-of select="/doc/admin/L_COUNT" />:
                        <b>
                          <xsl:choose>
                            <xsl:when test ="SLOs = 0">
                              <font color="red">
                                <xsl:value-of select="SLOs" />
                              </font>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="SLOs" />
                            </xsl:otherwise>
                          </xsl:choose>
                        </b>
                      </td>
                      <td width="20px">&#160;</td>
                      <td CLASS="TITLE_WARNING">
                        <a>
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='sa_pagina_dtl.aspx?pagina=<xsl:value-of select="id" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_agregar';document.frmSession.submit();
                          </xsl:attribute>
                          <xsl:value-of select="//L_NEW" />
                        </a>
                        <br />
                        <br />
                        <a>
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='sa_pagina_dtl.aspx?pagina=<xsl:value-of select="id" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_borrar';document.frmSession.submit();
                          </xsl:attribute>
                          <xsl:value-of select="//L_DELETE" />
                        </a>
                      </td>
                    </tr>
                  </xsl:for-each>
                  <tr>
                    <td CLASS="TITLE_DARK" ALIGN="right" COLSPAN="6">
                      <input type="button">
                        <xsl:attribute name="onclick">
                          javascript:document.frmSession.action='sa_pagina_dtl.aspx?pagina=0&#38;opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_agregar';document.frmSession.submit();
                        </xsl:attribute>
                        <xsl:attribute name="value">
                          <xsl:value-of select="//L_NEW" />
                        </xsl:attribute>
                      </input>
                    </td>
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
        </xsl:if>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>