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

        <script type="text/javascript">

          <xsl:text>

        function getComboA(sel) {
                       var val = sel.value; 

                         document.getElementById("myForm").myText.value =sel.value ;

                     document.getElementById("myForm").submit();


                                }
</xsl:text>

        </script>
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
              <!-- Breadcrumbs -->
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
                  <xsl:attribute name="href">
                    sa_opus_lst.aspx?artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />
                  </xsl:attribute>
                <xsl:value-of select="//sa_opus_lst"/>  <!--   sa_opus_lst.aspx?artifex=1&lng=BRITANNIA-->
                </a>&#62;
                <!--  /sa_nauta_lst_1.aspx?opus=1&artifex=3993&lng=BRITANNIA    -->
              <b> <xsl:value-of select="//sa_nauta_lst"/>
              </b>
              <p/>
              <!-- TABLE OF WORKS -->
              <table border="0" cellpadding="6" align="center">
                <tr>
                  <td colspan="5" CLASS="TITLE_DARK">
                    <b>
                      <xsl:value-of select="//sa_opus_lst"/> -
                      <a>

                        <xsl:value-of select="//Chorus" /> 
                      </a>
                    </b>
                  </td>

                  <!--*****************************************************************
                  <a>
                    <xsl:attribute name="href">
                      sa_menu.aspx?lng=<xsl:value-of select="//language" />
                    </xsl:attribute>
                    <xsl:value-of select="//sa_menu"/>
                  </a> &#62;
                  
                                    *****************************************************************-->


                  <!--********************************************************************************-->
                  <form id="myForm" action=""   method="post">


                    <input type="hidden" name="myText" value="testValue"/>

                    <select CLASS="TITLE_LIGHT"   onchange="getComboA(this)">
                      <xsl:for-each select="/doc/sa_opus_lst/opus_2">

                        <option >
                          <xsl:attribute name="value">
                            <xsl:value-of select="title_opus" />
                          </xsl:attribute>

                          <xsl:value-of select="title_opus" />

                        </option>
                      </xsl:for-each>
                    </select>


                  </form>

                  <!--*********************************************************************************-->


                </tr>
                <xsl:for-each select="/doc/sa_opus_lst/opus">
                  <tr>

                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="id" />
                    </td>

                    <td CLASS="TITLE_LIGHT">
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_nautaLaborio_lst.aspx?id=<xsl:value-of select="nauta_id"/>&#38;opus=<xsl:value-of select="//opus_id"/>&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
                        </xsl:attribute>
                        <xsl:value-of select="/doc/admin_tags/sa_nautaLaborio_lst" />
                      </a>
                    </td>
                    <td CLASS="TITLE_LIGHT">
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_nautaVia_lst.aspx?opus=<xsl:value-of select="//opus_id"/>&#38;artifex=<xsl:value-of select="//artifex_id"/>&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
                        </xsl:attribute>
                        <xsl:value-of select="/doc/admin_tags/sa_nautaVia_lst" />
                      </a>
                    </td>
                    <td CLASS="TITLE_LIGHT">
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_nautaCommunicatio_lst.aspx?id=<xsl:value-of select="nauta_id"/>&#38;opus=<xsl:value-of select="//opus_id" />&#38;artifex=<xsl:value-of select="//artifex_id"/>&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_borrar';document.frmSession.submit();
                        </xsl:attribute>
                        <xsl:value-of select="//sa_nautaCommunicatio_lst" />
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
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
