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
                    <td CLASS="TITLE_DARK" colspan="4">
                      <b>
                        <xsl:value-of select="//sa_pagina_lst" />
                        -
                        <xsl:value-of select="//opus_name" />
                      </b><br />
                      <xsl:value-of select="//sa_artifex_dtl" />:
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='../BBS_<xsl:value-of select="//language" />/admin/select_forum_members.asp';document.frmSession.submit();
                        </xsl:attribute>
                        <xsl:value-of select="//artifex_name" />
                      </a>
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
                        <b>
                          <xsl:value-of select="title" />
                        </b>
                        <br />
                        <xsl:value-of select="tag" />
                      </td>
                      <td CLASS="TITLE_LIGHT">

                        <br />
                        <a>
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='sa_nauta_lst.aspx?pagina=<xsl:value-of select="id" />&#38;opus=<xsl:value-of select="//id_opus" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_agregar';document.frmSession.submit();
                          </xsl:attribute>
                          <xsl:value-of select="//sa_nauta_lst" />
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
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>