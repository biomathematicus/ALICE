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
						<td valign="top" height="350">						
							<!-- ************ BEGINS CONTENT ************ -->
              <!-- Breadcrumbs -->
              <a>
                <xsl:attribute name="href">
                  sa_menu.aspx?lng=<xsl:value-of select="//language" />
                </xsl:attribute>
                <xsl:value-of select="//sa_menu"/>
              </a> &#62;
              <b>
                <xsl:value-of select="//sa_reading_lst"/>
              </b>
              <p/>
              <!-- Reading Group List -->
              <table border="0" cellpadding="6" align="center">
                <tr>
                  <td CLASS="TITLE_DARK" colspan="3">
                    <b>
                      <xsl:value-of select="//sa_reading_rpt"/>: <xsl:value-of select ="//ds_classis"/>
                    </b>
                  </td>
                </tr>
                <!--tr>
                  <td>Nautas:</td>
                  <td colspan="2">
                    <xsl:value-of select ="//user_count"/>
                  </td>
                </tr>
                <tr>
                  <td>Paginas:</td>
                  <td colspan="2">
                    <xsl:value-of select ="//page_count"/>
                  </td>
                </tr-->
                <tr>
                  <td CLASS="TITLE_LIGHT">
                    <b>Nauta</b>
                  </td>
                  <td CLASS="TITLE_LIGHT">
                    <b>Email</b>
                  </td>
                  <td CLASS="TITLE_LIGHT">
                    <b>Paginas</b>
                  </td>
                </tr>
                <xsl:for-each select="/doc/readers/reader">
                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      <a>
                        <xsl:attribute name="href">
                          ../admin/sa_reading_rpt.aspx?lng=<xsl:value-of select="//language" />&#38;nauta=<xsl:value-of select="user_code" />&#38;group=<xsl:value-of select="//cd_classis"/>
                        </xsl:attribute>
                        <span class='SMALL'>
                          <xsl:value-of select="username" />
                        </span>
                      </a>
                      <br/>
                      <span class='XSMALL'>
                        <xsl:value-of select="join_date" />
                      </span>
                    </td>
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="email"/>
                    </td>
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="page_count"/>
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
