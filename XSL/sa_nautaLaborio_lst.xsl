<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="l_html_header.xsl" />
  <xsl:include href="l_menu_top.xsl" />
  <xsl:include href="l_menu_left.xsl" />
  <xsl:include href="l_menu_right.xsl" />
  <xsl:include href="l_footer.xsl" />
  <xsl:template match="/">
    <xsl:variable name="ActionFlagName" select="'1'" />
    <html>
      <!-- Insert HTML header -->
      <xsl:apply-templates select="//html_header" />
      <body>
        <xsl:if test="//user_status = 3">
          <script   type="text/javascript">
          </script>
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

                <a>
                  <xsl:attribute name="href">
                    sa_opus_lst.aspx?pagina=<xsl:value-of select="//pagina_id" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />
                  </xsl:attribute>
                  <xsl:value-of select="//sa_opus_lst" />
                  <!--   sa_opus_lst.aspx?artifex=1&lng=BRITANNIA-->
                </a> &#62;    <!--&#62;  <xsl:value-of select="//sa_nauta_lst" /> -->
				  <a>
					  <xsl:attribute name="href">
						  javascript:document.frmSession.action='sa_opus_optum.aspx?opus=<xsl:value-of select="//opus_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
					  </xsl:attribute>
					  <xsl:value-of select="//ds_opus" />
				  </a> &#62;
                <a>
                  <xsl:attribute name="href">
                    <!-- home work  sa_nautaLaborio_lst.aspx?opus=1&artifex=3993&lng=BRITANNIA -->
                    sa_nauta_lst.aspx?pagina=<xsl:value-of select="//pagina_id" />&#38;opus=<xsl:value-of select="//opus_id" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />
                  </xsl:attribute>
                  <xsl:value-of select="//sa_nauta_lst" />
                  <!--   sa_nauta_lst.aspx?opus=1&artifex=3993&lng=BRITANNIA-->
                </a> &#62;
                <b>
                  <xsl:value-of select="//sa_nautaLaborio_lst" />
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
                          <xsl:value-of select="//OpusName1" />
                        </a>
                        <a>
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='sa_opus_lst.aspx?artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
                          </xsl:attribute>
                          - <xsl:value-of select="//DsChrs" />
                        </a>
                        <a>
                          - <xsl:value-of select="//StdName1" />
                        </a>
                        <!--<a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_opus_lst.aspx?artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
                        </xsl:attribute>
                        - <xsl:value-of select="//StdName1" />
                      </a>-->
                      </b>
                    </td>
                  </tr>
                  <tr>
                    <!--<td CLASS="TITLE_DARK">
                    <b>
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_nautaLaborio_lst.aspx?id=<xsl:value-of select="//user_id_" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;opus=<xsl:value-of select="//opus_id" />&#38;lng=<xsl:value-of select="//language" />&#38;action=ids';document.frmSession.submit();
                        </xsl:attribute>
                        <xsl:value-of select="//Sort_by_ID" />
                      </a>
                    </b>
                  </td>-->

                    <!--<td CLASS="TITLE_DARK">
                    <b>
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_nautaLaborio_lst.aspx?id=<xsl:value-of select="//user_id_" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;opus=<xsl:value-of select="//opus_id" />&#38;lng=<xsl:value-of select="//language" />&#38;action=name';document.frmSession.submit();
                        </xsl:attribute>
                        <xsl:value-of select="//HomeWork_Sort_name" />
                      </a>
                    </b>
                  </td>-->

                    <!--<td  CLASS="TITLE_DARK">
                    <b>
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_nautaLaborio_lst.aspx?id=<xsl:value-of select="//user_id_" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;opus=<xsl:value-of select="//opus_id" />&#38;lng=<xsl:value-of select="//language" />&#38;action=date';document.frmSession.submit();
                        </xsl:attribute>
                        <xsl:value-of select="//HomeWork_Sort_date" />
                      </a>
                    </b>
                  </td>-->
                  </tr>

                  <td CLASS="TITLE_LIGHT">
                    <b>
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_nautaLaborio_lst.aspx?id=<xsl:value-of select="//user_id_" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;opus=<xsl:value-of select="//opus_id" />&#38;lng=<xsl:value-of select="//language" />&#38;action=ids';document.frmSession.submit();
                        </xsl:attribute>
                        Id
                      </a>
                    </b>
                  </td>

                  <td CLASS="TITLE_LIGHT">
                    <b>
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_nautaLaborio_lst.aspx?id=<xsl:value-of select="//user_id_" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;opus=<xsl:value-of select="//opus_id" />&#38;lng=<xsl:value-of select="//language" />&#38;action=name';document.frmSession.submit();
                        </xsl:attribute>
                        Name
                      </a>
                    </b>
                  </td>
                  <td CLASS="TITLE_LIGHT">
                    <b>
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_nautaLaborio_lst.aspx?id=<xsl:value-of select="//user_id_" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;opus=<xsl:value-of select="//opus_id" />&#38;lng=<xsl:value-of select="//language" />&#38;action=date';document.frmSession.submit();
                        </xsl:attribute>
                        Date
                      </a>
                    </b>
                  </td>
                  <td CLASS="TITLE_LIGHT">
                    Grades
                  </td>
                  <td CLASS="TITLE_LIGHT">
                    <xsl:value-of select="//L_COMMENTS" />
                  </td>
                  <td CLASS="TITLE_LIGHT">
                    <xsl:value-of select="//L_Action" />
                  </td>

                  <xsl:for-each select="/doc/sa_opus_lst/opus">
                    <tr>
                      <!-- <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="id" />
                    </td>   -->

                      <td CLASS="TITLE_LIGHT">
                        <xsl:value-of select="pagina_id_" />
                      </td>

                      <td CLASS="TITLE_LIGHT">
                        <xsl:value-of select="title" />
                      </td>

                      <!--
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="ds_content" />
                    </td>
                      -->
                      <td CLASS="TITLE_LIGHT">
                        <xsl:if test="ds_file != ''">
                          <a id="myLink" href="#">
                            <xsl:attribute name="onclick">
                              produce_add( '<xsl:value-of select="ds_file" />')
                            </xsl:attribute>
                            <xsl:value-of select="dt_upload" />
                          </a>
                        </xsl:if>
                        <xsl:if test="ds_file = ''">
                          <p>  Not Submitted </p>
                        </xsl:if>
                      </td>

                      <td CLASS="TITLE_LIGHT">
                        <input type="text" name="fname" maxlength="3" size="3">
                          <xsl:attribute name="id">
                            <xsl:value-of select="pagina_id_" />
                          </xsl:attribute>

                          <xsl:attribute name="value">
                            <xsl:value-of select="grade_con" />
                          </xsl:attribute>
                        </input>
                      </td>

                      <td CLASS="TITLE_LIGHT">

                        <textarea rows="4" cols="50" name="txt_area">
                          <xsl:attribute name="id">
                            <xsl:value-of select="pagina_id_txt" />
                          </xsl:attribute>

                          <xsl:value-of select="comment_con" />
                        </textarea>
                      </td>

                      <td CLASS="TITLE_LIGHT">
                        <input type="button"  value="Update">

                          <xsl:attribute name="onclick">
                            send_comments( <xsl:value-of select="user_id_" />,<xsl:value-of select="opus_id_" />,<xsl:value-of select="pagina_id_" />  )
                          </xsl:attribute>
                        </input>
                      </td>
                      <script>
                        change_color(<xsl:value-of select="update_status_" />,<xsl:value-of select="pagina_id_" />);
                      </script>
                    </tr>
                  </xsl:for-each>
                  <tr>
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