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
        <script type="text/javascript">

          <!--******************************************************************************************************************************
          function blank() {
          var user_val = document.forms["myForm"]["username1"].value;
          if (user_val == "") {

          document.getElementById("username_alert").innerHTML = "Error: Username cannot be blank!";
          return 1;
          }

          }

          function letter_num() {
         var user = document.getElementById("username1");
         re = /^\w+$/;
         if(!re.test(user.value)) {
         document.getElementById("username_alert").innerHTML = "Error: Username must contain only letters, numbers and underscores!";
         user.focus();
         return 1;
           }
          }

          function pass_length () {
          var pass = document.forms["myForm"]["password1"];
          if(pass.value.length &lt; 6) {

          document.getElementById("password1_alert").innerHTML = "Error: Password must contain at least six characters!";
          pass.focus();
          return 1;
          }

          }

          function password_format1 () {
          var pass = document.forms["myForm"]["password1"];
          var user = document.forms["myForm"]["username1"];

          if(pass.value==user.value) {
          document.getElementById("password1_alert").innerHTML = "Error: Password must be different from Username!";
          pass.focus();
          return 1;
          }

          }

          function password_format2 () {
          var pass = document.forms["myForm"]["password1"];
          var user = document.forms["myForm"]["username1"];
          re = /[0-9]/;
          if(!re.test(pass.value)) {
          document.getElementById("password1_alert").innerHTML = "Error: password must contain at least one number (0-9)!";
          pass.focus();
          return 1;
          }

          }

          function password_format3 () {
          var pass = document.forms["myForm"]["password1"];
          var user = document.forms["myForm"]["username1"];
          re = /[a-z]/;
          if(!re.test(pass.value)) {
          document.getElementById("password1_alert").innerHTML = "Error: password must contain at least one lowercase letter (a-z)!";
          pass.focus();
          return 1;
          }

          }

          function password_format4 () {
          var pass = document.forms["myForm"]["password1"];
          var user = document.forms["myForm"]["username1"];
          re =  /[A-Z]/;
          if(!re.test(pass.value)) {
          document.getElementById("password1_alert").innerHTML = "Error: password must contain at least one uppercase letter (A-Z)!";
          pass.focus();
          return 1;
          }

          }

          function password_format5 () {
          var pass = document.forms["myForm"]["password1"];
          var pass2 = document.forms["myForm"]["password2"];
          if(pass.value!=pass2.value) {
          document.getElementById("password1_alert").innerHTML = "Error: check your password again.both passwords shuld be the same!";
          pass.focus();
          return 1;
          }

          }

          function validateForm() {
          k=blank();
          if (k=='1'){  return false;}
          k=letter_num();
          if (k=='1'){  return false;}
          k=pass_length();
          if (k=='1'){  return false;}
          k=password_format1();
          if (k=='1'){  return false;}
          k=password_format2();
          if (k=='1'){  return false;}
          k=password_format3();
          if (k=='1'){  return false;}
          k=password_format4();
          if (k=='1'){  return false;}
          k=password_format5();
          if (k=='1'){  return false;}

          }

-->
        </script>

        <!--           password2_alert
          password2
          username1
          password1
          username_alert
          password1_alert   -->

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
              <a href="initium.aspx">
                <span class="XSMALL">
                  <xsl:value-of select="//P_INITIUM" />
                </span>
              </a> &#62;
              <span class="BOLDXSMALL">
                <xsl:value-of select="//L_LOGIN" />
              </span>
              <p />

              <xsl:if test="//user_status_log = '0' ">

                <!-- ************ form ************************************************************************************************************** -->

                <form name="myForm" id="myform_id" action=""   onsubmit="return validateForm()" method="post">

                  <table border="0" cellpadding="2" width="100%"  align="left">

                    <tr>
                      <td CLASS="TITLE_DARK">
                        <xsl:value-of select="//L_LOGIN_NAME" />: &#160;
                      </td>
                      <td>
                        <input type="text" name="txtLogin" id="username1" />
                        <p id="username_alert"></p>
                      </td>
                    </tr>

                    <tr>
                      <td CLASS="TITLE_DARK">
                        <xsl:value-of select="//L_LOGIN_PWD" />: &#160;
                      </td>
                      <td>
                        <input type="password" name="txtPassword" id="password1" />
                        <p id="password1_alert"></p>
                      </td>
                    </tr>

                    <tr>
                      <td CLASS="TITLE_DARK">
                        <xsl:value-of select="//L_LOGIN_PWD_CON" />: &#160;
                      </td>
                      <td>
                        <input type="password" name="txtPassword2" id="password2" />
                        <p id="password2_alert"></p>
                      </td>
                    </tr>

                    <tr>
                      <td CLASS="TITLE_DARK">
                      </td>
                      <td>
                        <input type="hidden" name="age" id="age1" />
                      </td>
                    </tr>

                    <tr>
                      <td CLASS="TITLE_DARK">
                        <xsl:value-of select="//L_email" />: &#160;
                      </td>
                      <td>
                        <input type="text" name="email" id="email1" />
                      </td>
                    </tr>

                    <tr>
                      <td CLASS="TITLE_DARK">
                        <xsl:value-of select="//L_valid" />: &#160;
                      </td>
                      <td>
                        <input type="text" name="valid" id="valid1" />
                      </td>
                    </tr>

                    <tr>
                      <td CLASS="TITLE_DARK">
                        &#160;
                      </td>
                      <td>
                        <input type="hidden" name="hAction" value ="login" />
                        <input type="submit" name="btnSubmit" />
                      </td>
                    </tr>
                  </table>
                </form>

                <!-- ************ form ************************************************************************************************************** -->

                <!-- ************  ENDS CONTENT  ************ -->
              </xsl:if>

              <xsl:if test="//user_status_log = '1' ">
                <span class="MEDIUM">
                  <xsl:value-of select="//L_SUCC_Reg" />
                </span>
              </xsl:if>

              <xsl:if test="//user_status_log = '-1' ">
                <span class="MEDIUM">
                  <xsl:value-of select="//L_Error_Reg" />
                </span>
              </xsl:if>
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