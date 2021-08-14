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
        
        <xsl:if test="//user_status = 3 or //user_status = 2">
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
                  <xsl:value-of select="//sa_menu" />
                </a> &#62;
                <b>
                  <xsl:value-of select="//sa_artifex_lst" />
                </b>
                <!-- TABLE OF AUTHORS -->
                <xsl:if test="//user_status = 3 or //user_status = 2">
                  <table border="0" cellpadding="6" align="center">
                    <tr>
                      <td colspan="2" CLASS="TITLE_DARK">
                        <b>
                          <xsl:value-of select="doc/admin_tags/sa_artifex_lst" />
                        </b>
                      </td>
                    </tr>
                    <xsl:for-each select="/doc/sa_artifex_lst/artifex">
                      <tr>
                        <td CLASS="TITLE_LIGHT">
                          <xsl:value-of select="name" />
                        </td>
                        <td CLASS="TITLE_LIGHT">
                          <a>
                            <xsl:attribute name="href">
                              javascript:document.frmSession.action='sa_opus_lst.aspx?artifex=<xsl:value-of select="id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
                            </xsl:attribute>
                            <xsl:value-of select="/doc/admin_tags/sa_opus_lst" />
                          </a>
                        </td>
                      </tr>
                    </xsl:for-each>
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