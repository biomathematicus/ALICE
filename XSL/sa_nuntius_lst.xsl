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
          <table width="600px" align="center" border="0" cellpadding="0" cellspacing="0">
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
                <!-- Breadcrumbs -->
                <a>
                  <xsl:attribute name="href">
                    sa_menu.aspx?lng=<xsl:value-of select="//language" />
                  </xsl:attribute>
                  <xsl:value-of select="//sa_menu" />
                </a> &#62;
                <b>
                  <xsl:value-of select="//sa_nuntius_lst" />
                </b>
                <p />
                <!-- TABLE OF MESSAGES -->
                <xsl:if test="//user_status = 3">
                  <table border="0" cellpadding="2" align="center">
                    <tr>
                      <td CLASS="TITLE_DARK" colspan="2">
                        <b>
                          <xsl:value-of select="//sa_nuntius_lst" />
                        </b>
                      </td>
                      <td CLASS="TITLE_DARK" align="right" colspan="2">
                        <input type="button">
                          <xsl:attribute name="onclick">javascript:document.frmSession.action='sa_nuntius_dtl.aspx?nuntius=0';document.frmSession.hAction.value = 'ir_agregar';document.frmSession.submit();</xsl:attribute>
                          <xsl:attribute name="value">
                            <xsl:value-of select="//L_NEW" />
                          </xsl:attribute>
                        </input>
                      </td>
                    </tr>
                    <xsl:for-each select="/doc/sa_nuntius_lst/nuntius">
                      <tr>
                        <td CLASS="TITLE_LIGHT">
                          <xsl:value-of select="cd_nuntius" />
                        </td>
                        <td CLASS="TITLE_LIGHT">
                          <a>
                            <xsl:attribute name="href">
                              javascript:document.frmSession.action='sa_nuntius_dtl.aspx?nuntius=<xsl:value-of select="cd_nuntius" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
                            </xsl:attribute>
                            <xsl:value-of select="/doc/admin_tags/sa_nuntius_dtl" />
                          </a>
                        </td>
                        <td CLASS="TITLE_LIGHT">
                          <a>
                            <xsl:attribute name="href">
                              javascript:document.frmSession.action='sa_nuntius_dtl.aspx?nuntius=<xsl:value-of select="cd_nuntius" />';document.frmSession.hAction.value = 'ir_borrar';document.frmSession.submit();
                            </xsl:attribute>
                            <xsl:value-of select="//L_DELETE" />
                          </a>
                        </td>
                      </tr>
                    </xsl:for-each>
                    <tr>
                      <td CLASS="TITLE_LIGHT" ALIGN="right" COLSPAN="6">
                        <input type="button">
                          <xsl:attribute name="onclick">javascript:document.frmSession.action='sa_nuntius_dtl.aspx?nuntius=0';document.frmSession.hAction.value = 'ir_agregar';document.frmSession.submit();</xsl:attribute>
                          <xsl:attribute name="value">
                            <xsl:value-of select="//L_NEW" />
                          </xsl:attribute>
                        </input>
                      </td>
                    </tr>
                  </table>
                </xsl:if>
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