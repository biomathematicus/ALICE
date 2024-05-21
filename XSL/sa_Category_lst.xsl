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
        <xsl:if test="//user_status = 3 or //Validation=1">
		<script   type="text/javascript">
		var text_box='';
		function get_text_box_value(id)  {
		    text_box= document.getElementById(id).value;
		    alert(text_box);
		}
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
				  <!--xsl:if test="//user_status = 3">
                  <a>
                    <xsl:attribute name="href">
                      sa_artifex_lst.aspx?lng=<xsl:value-of select="//language" />
                    </xsl:attribute>
                    <xsl:value-of select="//sa_artifex_lst" />
                  </a> &#62;
                </xsl:if -->

                <a>
                  <xsl:attribute name="href">
                    sa_opus_lst.aspx?artifex=1&#38;lng=<xsl:value-of select="//language" />
                  </xsl:attribute>
                  <xsl:value-of select="//sa_opus_lst" />
                </a> &#62; 

				  <a>
					  <xsl:attribute name="href">
						  javascript:document.frmSession.action='sa_opus_optum.aspx?opus=<xsl:value-of select="//opus_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();
					  </xsl:attribute>
					  <xsl:value-of select="//ds_opus" />
				  </a> &#62;
				  <b>
					  <xsl:value-of select="//sa_category_lst" />
				  </b>

                <p />
                <!-- TABLE OF WORKS -->
                <table border="0" cellpadding="6" align="center">

                  <xsl:for-each select="/doc/sa_opus_lst/opus">
                    <tr>
                      <!-- <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="id" />
                    </td>   -->
                      <td CLASS="TITLE_LIGHT">
                        <xsl:value-of select="category_id" />
                      </td>
                      <td CLASS="TITLE_LIGHT">
                        <input type="text" name="fname" maxlength="30" size="30">
                          <xsl:attribute name="id">
                            <xsl:value-of select="category_id" />
                          </xsl:attribute>
                          <xsl:attribute name="value">
                            <xsl:value-of select="category_lable" />
                          </xsl:attribute>
                        </input>
                      </td>
                      <td CLASS="TITLE_LIGHT">
                        <input type="button"  value="Update">

                          <xsl:attribute name="onclick">
                            var tt= document.getElementById( <xsl:value-of select="category_id" />).value;
                            var ss="../admin/sa_Category_lst.aspx?opus=<xsl:value-of select="//opus_id" />&#38;lng=<xsl:value-of select="//language" />&#38;Action=Update&#38;id=<xsl:value-of select="category_id" />&#38;value=";
                            window.location.href =ss+tt;
                          </xsl:attribute>
                        </input>
                      </td>
                    </tr>
                  </xsl:for-each>
                  <td CLASS="TITLE_LIGHT">
                    <xsl:value-of select="//category_id_last_one" />
                  </td>

                  <td CLASS="TITLE_LIGHT">
                    <input type="text" name="fname" maxlength="30" size="30">
                      <xsl:attribute name="id">
                        <xsl:value-of select="//category_id_last_one" />
                      </xsl:attribute>
                      <xsl:attribute name="value">
                        <xsl:value-of select="category_lable" />
                      </xsl:attribute>
                    </input>
                  </td>
                  <td CLASS="TITLE_LIGHT">
                    <input type="button"  value="Add">
                      <xsl:attribute name="onclick">

                        var tt= document.getElementById( <xsl:value-of select="//category_id_last_one" />).value;
                        var ss="../admin/sa_Category_lst.aspx?opus=<xsl:value-of select="//opus_id" />&#38;lng=<xsl:value-of select="//language" />&#38;Action=Add&#38;id=<xsl:value-of select="//category_id_last_one" />&#38;value=";
                        window.location.href =ss+tt;
                      </xsl:attribute>
                    </input>
                  </td>
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