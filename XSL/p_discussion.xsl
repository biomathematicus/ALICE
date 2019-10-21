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

              <a href="initium.aspx">
                <span class="MEDIUM">
                  <xsl:value-of select="//P_INITIUM"/>
                </span>
              </a>
              <B>&#62;</B>
              <a href="index.aspx">
                <span class="MEDIUM">
                  <xsl:value-of select="//P_INDEX"/>
                </span>
              </a>
              <B>&#62;</B>
              <a>
                <xsl:attribute name="href">
                  javascript:document.frmSession.action='Pagina.aspx?lng=<xsl:value-of select="//language" />&#38;pagina=<xsl:value-of select="//pagina_id"/>&#38;opus=<xsl:value-of select="//opus_id" />';document.frmSession.submit();
                </xsl:attribute>
                <span class="MEDIUM">
                  <xsl:value-of select="//opus_name1"/>
                </span>
              </a>
              <B>&#62;</B>

              <a>
                <xsl:attribute name="href">
                  javascript:document.frmSession.action='Tractus.aspx?lng=<xsl:value-of select="//language" />&#38;opus=<xsl:value-of select="//opus_id" />';document.frmSession.submit();
                </xsl:attribute>
                <span class="MEDIUM">
                  <xsl:value-of select="//P_TRACTUS"/>
                </span>
              </a>

              <B>&#62;</B>

              <span class="BOLDMEDIUM">
                <xsl:value-of select="//L_Question"/>
              </span>
              <p/>
              
              
              <p/>
              <xsl:if test="//user_logon != 'LOGGED-OFF'"    >
<!--pppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp-->
              <form name="p_discussions" method="post" >

                <xsl:attribute name="action">
                  discussion.aspx?lng=<xsl:value-of select="//language" />&#38;opus=<xsl:value-of select="//opus_id"/>&#38;pagina=<xsl:value-of select="//pagina_id"/>
                </xsl:attribute>
                <textarea name="question" cols="100" rows="5" wrap="VIRTUAL">
                  <xsl:value-of select="//ds_nuntius_his" disable-output-escaping="yes" />
                </textarea>
                <input type="submit"  value="Add Question"></input>
                <input type="hidden" id="senddata" value="click" name="sendata1"></input>
              </form>
<!--pppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp-->

              <!-- TABLE OF WORKS -->
            

               
               
              <table border="0" cellpadding="6" align="center">
                <tr>
                  <td colspan="5" CLASS="TITLE_DARK">
                    <b>
                      <xsl:value-of select="//sa_opus_lst"/> -
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='sa_opus_lst.aspx?artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();

                        </xsl:attribute>
                        <xsl:value-of select="//artifex_name" />
                      </a>
                    </b>
                  </td>
                  <td align="right" colspan="2" CLASS="TITLE_DARK">
                  </td>
                </tr>         
                    <tr>                                 
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="//L_Question_user" />
                      </td>
                      <td CLASS="TITLE_LIGHT">
                        <xsl:value-of select="//respond1_title" />
                      </td>
                    </tr>
      
                <xsl:for-each select="/doc/sa_opus_lst/opus">
                  <tr>

                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="//id_user1" />
                    </td>

                    <td CLASS="TITLE_LIGHT">
                      <a>
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='question.aspx?opus=<xsl:value-of select="opus_id"/>&#38;pagina=<xsl:value-of select="pagina_id"/>&#38;comment=<xsl:value-of select="id_comment"/>&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();

                        </xsl:attribute>
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


        <script type="text/javascript">


        </script>
        
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
