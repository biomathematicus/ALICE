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
                <!-- Breadcrumbs -->
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
                <b>
                  <a>
                    <xsl:attribute name="href">
                      sa_opus_lst.aspx?artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />
                    </xsl:attribute>
                    <xsl:value-of select="//sa_opus_lst" />
                    <!--   sa_opus_lst.aspx?artifex=1&lng=BRITANNIA-->
                  </a> &#62;
                </b>
                <b>
                  <a>
                    <xsl:attribute name="href">
                      sa_nauta_lst.aspx?pagina=<xsl:value-of select="//pagina_id" />&#38;opus=<xsl:value-of select="//opus_id" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />
                    </xsl:attribute>
                    <xsl:value-of select="//sa_nauta_lst" />
                    <!--   sa_nauta_lst.aspx?opus=1&artifex=3993&lng=BRITANNIA-->
                  </a> &#62;  <xsl:value-of select="//sa_nautaCommunicatio_lst" />
                </b>
                <p />
                <!-- TABLE OF WORKS -->
                <table border="0" cellpadding="6" align="center">
                  <tr>
                    <td colspan="5" CLASS="TITLE_DARK">
                      <b>
                        <xsl:value-of select="//sa_opus_lst" /> -
                        <a>
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='sa_opus_lst.aspx?artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
                          </xsl:attribute>
                          <xsl:value-of select="//artifex_name" />
                        </a>
                      </b>
                    </td>

                    <!--*****************************************************************
                  <a>
                    <xsl:attribute name="href">
                      sa_menu.aspx?lng=<xsl:value-of select="//language" />
                    </xsl:attribute>
                    <xsl:value-of select="//sa_menu" />
                  </a> &#62;

                  *****************************************************************-->
                    <td align="right" colspan="2" CLASS="TITLE_DARK">
                    </td>
                  </tr>

                  <tr>

                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="//opus_title" />
                    </td>
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="//pagina_title" />
                    </td>
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="//comment_title" />
                    </td>
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="//respond1_title" />
                    </td>
                  </tr>

                  <xsl:for-each select="/doc/sa_opus_lst/opus">
                    <tr>

                      <td CLASS="TITLE_LIGHT">
                        <xsl:value-of select="opus_name" />
                      </td>

                      <td CLASS="TITLE_LIGHT">
                        <a>
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='/src/Pagina.aspx?opus=<xsl:value-of select="opus_id" />&#38;pagina=<xsl:value-of select="pagina_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
                          </xsl:attribute>
                          <xsl:value-of select="id" />
                        </a>
                      </td>
                      <td CLASS="TITLE_LIGHT">
                        <xsl:value-of select="comment" />
                      </td>

                      <td CLASS="TITLE_LIGHT">
                        <a>
                          <xsl:value-of select="comment_p" />
                        </a>
                      </td>
                    </tr>
                  </xsl:for-each>
                  <tr>
                    <td CLASS="TITLE_DARK" ALIGN="right" COLSPAN="7">
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