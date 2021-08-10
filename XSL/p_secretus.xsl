<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="l_html_header.xsl" />
	<xsl:include href="l_menu_top.xsl" />
	<xsl:include href="l_menu_left.xsl" />
	<xsl:include href="l_menu_right.xsl" />
	<xsl:include href="l_footer.xsl" />
	<xsl:template match="/">
		<html lang="EN">
			<!-- Insert HTML header -->
			<xsl:apply-templates select="//html_header" />
      <xsl:apply-templates select="//html_header" />
			<body>

        <script   type="text/javascript">

          window.onload = function f(){
          show(<xsl:value-of select="//successful_login" />);
          }

          function show (e)
          {
          document.getElementById("demo").innerHTML = "";
          if(e==0) //alert('Please enter a valid username or password!');
          document.getElementById("demo").innerHTML = "Please enter a valid username or password!";
          }

          function frmLogin_submit()
          {
          var pas =$("#password1").val();
          var usr =$("#username1").val();
          //alert('Username : ' + usr + ' password : ' + pas);
          if (usr ==''){
          //  alert('plase enter a user name!');

          document.getElementById("demo").innerHTML = "plase enter a user name!";
          }else if (pas == ''){
          //     alert('plase enter a password!');
          document.getElementById("demo").innerHTML = "plase enter a password!";
          }
          else {
          document.getElementById('frmLogin').submit();
          }

          }
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
						<td valign="top" height="350" align="left" class="XSMALL">
							<!-- ************ BEGINS CONTENT ************ -->
							<!-- Breadcrumbs -->
							<a href="initium.aspx"><span class="XSMALL"><xsl:value-of select="//P_INITIUM" /></span></a> &#62;
							<span class="BOLDXSMALL"><xsl:value-of select="//L_LOGIN" /></span>
							<p />
              <form id="frmLogin"  method="post" action="">
                <xsl:choose>

                  <xsl:when test="//successful_login &lt; '1'">
                    <xsl:if test="//user_status =  '0'">
                      <span class="box"><xsl:value-of select="//L_LOGIN_ERROR" /></span>
                    </xsl:if>
                    <table border="0" cellpadding="2" width="100%"  align="left">
                      <tr>
                        <td CLASS="TITLE_DARK">
                          <xsl:value-of select="//L_LOGIN_NAME" />: &#160;
                        </td>
                        <!-- ************ BEGINS CONTENT ************ -->
                        <td>
                          <input type="text" name="txtLogin" id="username1" />
                        </td>
                      </tr>
                      <tr>
                        <td CLASS="TITLE_DARK">
                          <xsl:value-of select="//L_LOGIN_PWD" />: &#160;
                        </td>
                        <td>
                          <input type="password" name="txtPassword" id="password1" />

                          <xsl:element name="paragraph">
                            <xsl:attribute name="id">demo</xsl:attribute>
                          </xsl:element>
                        </td>
                      </tr>
                      <tr>
                        <td CLASS="TITLE_DARK">
                          &#160;
                        </td>
                        <td>
                          <input type="hidden" name="hAction" value ="login" />
                          <input type="button" value ="login" onclick="frmLogin_submit()" />
                        </td>
                      </tr>
                    </table>
                    <!-- ************ BEGINS CONTENT ************ -->
                  </xsl:when>

                  <xsl:otherwise>
                    <table border="0" cellpadding="2" width="100%"  align="left">
                      <tr>
                        <td CLASS="TITLE_DARK">
                          <xsl:value-of select="//L_LOGIN_NAME" />: &#160;
                        </td>
                        <td>
                          <xsl:value-of select="//user_name" />
                        </td>
                      </tr>
                      <tr>
                        <td CLASS="TITLE_DARK">
                          &#160;
                        </td>
                        <td>
                          <p> Salam</p>
                          <input type="submit" name="hAction" value ="logout" />
                        </td>
                      </tr>
                    </table>
                  </xsl:otherwise>
                </xsl:choose>
              </form>
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