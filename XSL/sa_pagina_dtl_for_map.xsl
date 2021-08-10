<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="l_html_header.xsl" />
  <xsl:include href="l_menu_top.xsl" />
  <xsl:include href="l_menu_left.xsl" />
  <xsl:include href="l_menu_right.xsl" />
  <xsl:include href="l_footer.xsl" />
  <xsl:template match="/">
    <html>
      <!-- Insert HTML header -->

      <script src="//code.jquery.com/jquery-1.10.2.js"></script>

      <body>

        <script>

          function insertAtCaret(areaId,text) {
          var txtarea = document.getElementById(areaId);
          var scrollPos = txtarea.scrollTop;
          var strPos = 0;
          var br = ((txtarea.selectionStart || txtarea.selectionStart == '0') ?
          "ff" : (document.selection ? "ie" : false ) );
          if (br == "ie") {
          txtarea.focus();
          var range = document.selection.createRange();
          range.moveStart ('character', -txtarea.value.length);
          strPos = range.text.length;
          }
          else if (br == "ff") strPos = txtarea.selectionStart;

          var front = (txtarea.value).substring(0,strPos);
          var back = (txtarea.value).substring(strPos,txtarea.value.length);
          txtarea.value=front+text+back;
          strPos = strPos + text.length;
          if (br == "ie") {
          txtarea.focus();
          var range = document.selection.createRange();
          range.moveStart ('character', -txtarea.value.length);
          range.moveStart ('character', strPos);
          range.moveEnd ('character', 0);
          range.select();
          }
          else if (br == "ff") {
          txtarea.selectionStart = strPos;
          txtarea.selectionEnd = strPos;
          txtarea.focus();
          }
          txtarea.scrollTop = scrollPos;
          }

          function chekbox_f() {

          if(document.getElementById("chbox").checked == true)
          {
          document.getElementById("chbox").value="true";
          }

          if(document.getElementById("chbox").checked == false)
          {
          document.getElementById("chbox").value="false";
          document.getElementById("chbox1").value="remove";

          }
          }

          function chekbox_start() {

          if(document.getElementById("chboxstart").checked == true)
          {
          document.getElementById("chboxstart").value="true";
          }

          if(document.getElementById("chboxstart").checked == false)
          {
          document.getElementById("chboxstart").value="false";
          document.getElementById("chboxstart1").value="remove";

          }
          }

          function make_check(){
          document.getElementById("chbox").checked = true;
          document.getElementById("chbox").value="true";
          }

          function make_check_start(){
          document.getElementById("chboxstart").checked = true;
          document.getElementById("chboxstart").value="true";
          }

          function setValue(type,cat) {

          var type_idx=20;
          var cat_idx=30;

          switch(cat)
          {
          case "BIOLOGY":
          cat_idx=0;
          break;
          case "PHYSICS":
          cat_idx=3;
          break;
          case "COMPUTER SCIENCE":
          cat_idx=1;
          break;
          case "MATHEMATICS":
          cat_idx=2;
          break;
          case "STATISTICS":
          cat_idx=4;
          }

          switch(type)
          {
          case "ROOT":
          type_idx=0;
          break;
          case "PRE-REQ":
          type_idx=1;
          break;
          case "EXAMPLE":
          type_idx=2;
          }

          $("#pagina_cat_id").prop("selectedIndex", cat-1);
          $("#pagina_type_id").prop("selectedIndex", type_idx);

          }

          function add_option(id,value1){

          $('#pagina_cat_id').append($(' &lt;option &gt;', {
          value: id,
          text: value1
          }))
          }
        </script>

        <table width="600" align="center" border="0" cellpadding="0" cellspacing="0">
          <tr valign="top">
            <td rowspan="3" valign="top" class='BAR_OFF'>
              <!-- Insert left menu -->
            </td>
            <td valign="top" width="100%">
              <!-- Insert header -->
            </td>
            <td rowspan="3" valign="top" class='BAR_OFF'>
              <!-- Insert right menu -->
            </td>
          </tr>
          <tr>
            <td valign="top" height="350" CLASS="CONTENT">

              <!-- TABLE WITH DATA -->
              <form name="form_id" id="form_id" method="post" action="">

                <input name="am_value" id="am_value" type="hidden" size="6" value="10"> </input>
                <input name="LinkType" id="LinkType" type="hidden" size="6" value="10"> </input>

                <table border="0" cellpadding="2" align="center"  CLASS="CONTENT">
                  <tr>
                    <td colspan="2" CLASS="TITLE_DARK">
                      <b>
                        <xsl:value-of select="//sa_pagina_dtl" />
                        -
                        <xsl:value-of select="//ds_title_bri" />
                      </b>
                      <br />
                      <xsl:value-of select="//opus_name" />
                    </td>
                    <td CLASS="TITLE_DARK" ALIGN="RIGHT">
                      <input type="button">
                        <xsl:attribute name="onclick">
                          <script>
                            alert('ali');
                          </script>

                          javascript:document.form_id.hAction.value = 'Update';document.form_id.action='sa_pagina_dtl_for_map.aspx?redirect=true&#38;lng=<xsl:value-of select="//language" />';document.form_id.submit();
                        </xsl:attribute>
                        <xsl:attribute name="value">
                          <xsl:choose>
                            <xsl:when test="//hAction = 'Borrar'">
                              <xsl:value-of select="//L_SA_DELETE" />
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="//L_SA_UPDATE" />
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:attribute>
                      </input>
                    </td>
                  </tr>
                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="//L_SA_BOOK" /> ID
                    </td>
                    <td CLASS="TITLE_LIGHT" COLSPAN="2">
                      <xsl:value-of select="//id_opus" />
                      <input type="hidden" name="id_opus" id="id_opus">
                        <xsl:attribute name="value">
                          <xsl:value-of select="//id_opus" />
                        </xsl:attribute>
                      </input>
                    </td>
                  </tr>
                  <!--check box -->
                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      <input type="checkbox" id="chbox" name="Capstone" onclick="chekbox_f()" ></input>
                      <input type="hidden" id="chbox1" name="capstone_status"> </input>
                    </td>
                    <td CLASS="TITLE_LIGHT" colspan ="2">
                      <p>Capstone Experience</p>
                    </td>
                  </tr>
                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      <input type="checkbox" id="chboxstart" name="startlesson" onclick="chekbox_start()" ></input>
                      <input type="hidden" id="chboxstart1" name="startlesson_status"> </input>
                    </td>
                    <td CLASS="TITLE_LIGHT" colspan ="2">
                      <p>As a Start Lesson</p>
                    </td>
                  </tr>

                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="//L_SA_PAGE" /> ID
                    </td>
                    <td CLASS="TITLE_LIGHT" COLSPAN="2">
                      <xsl:value-of select="//id_pagina" />
                      <input type="hidden" name="id_pagina">
                        <xsl:attribute name="value">
                          <xsl:value-of select="//id_pagina" />
                        </xsl:attribute>
                      </input>
                    </td>
                  </tr>
                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      Link
                    </td>
                    <td CLASS="TITLE_LIGHT" COLSPAN="2">
                      <input type="text" name="am_link">
                        <xsl:attribute name="value">
                          <xsl:value-of select="//am_link" />
                        </xsl:attribute>
                      </input>
                    </td>
                  </tr>
                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      Category
                    </td>

                    <!--*************************************************-->
                    <td  CLASS="TITLE_LIGHT" colspan="2">
                      <select name ="pagina_cat" id="pagina_cat_id">
                        <script>
                          <xsl:for-each select="/doc/Lables">
                            add_option( '<xsl:value-of select="id_opus_category" />','<xsl:value-of select="id_opus_Lable" />');
                          </xsl:for-each>
                        </script>
                      </select>
                    </td>
                    <!--*************************************************-->
                  </tr>
                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      Type
                    </td>
                    <td  CLASS="TITLE_LIGHT" colspan="2">
                      <select name ="pagina_type" id = "pagina_type_id">
                        <option value="ROOT">ROOT</option>
                        <option value="PRE-REQ">PRE-REQ</option>
                        <option value="EXAMPLE">EXAMPLE</option>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      &#160;
                    </td>

                    <td CLASS="TITLE_DARK" align="center">
                      <b>HISPANIA</b>
                    </td>
                    <td CLASS="TITLE_DARK" align="center">
                      <b>BRITANNIA</b>
                    </td>
                  </tr>
                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="//L_SA_TITLE" />
                    </td>
                    <td CLASS="TITLE_LIGHT" align="center">
                      <input type="text" name="ds_title_his" size="40" id="ds_title_his">
                        <xsl:attribute name="value">
                          <xsl:value-of select="//ds_title_his" />
                        </xsl:attribute>
                      </input>
                    </td>
                    <td CLASS="TITLE_LIGHT" align="center">
                      <input type="text"  id="ds_title_bri" name="ds_title_bri" size="40">
                        <xsl:attribute name="value">
                          <xsl:value-of select="//ds_title_bri" />
                        </xsl:attribute>
                      </input>
                    </td>
                  </tr>
                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="//L_SA_TAG" />
                    </td>
                    <td CLASS="TITLE_LIGHT">
                      <textarea name="ds_tag_his" cols="45" rows="5" wrap="VIRTUAL"  id="ds_tag_his">
                        <xsl:value-of select="//ds_tag_his" />
                      </textarea>
                    </td>
                    <td CLASS="TITLE_LIGHT">
                      <textarea id="ds_tag_bri" name="ds_tag_bri" cols="45" rows="5" wrap="VIRTUAL">
                        <xsl:value-of select="//ds_tag_bri" />
                      </textarea>
                    </td>
                  </tr>
                  <tr>
                    <td CLASS="TITLE_LIGHT">
                      <xsl:value-of select="//L_SA_CONTENT" />
                    </td>
                    <td CLASS="TITLE_LIGHT">
                      <textarea name="ds_content_his" cols="45" rows="25" wrap="VIRTUAL" id="ds_content_his">
                        <xsl:value-of select="//ds_content_his" />
                      </textarea>
                    </td>
                    <!--*********************************************************************************************************-->
                    <td CLASS="TITLE_LIGHT">
                      <textarea  id="ds_content_bri1" name="ds_content_bri" cols="45" rows="25" wrap="VIRTUAL">
                        <xsl:value-of select="//ds_content_bri" />
                      </textarea>
                    </td>
                  </tr>
                  <tr>
                    <td CLASS="TITLE_DARK" ALIGN="right" COLSPAN="3">
                      <input type="hidden" name="cd_lingua">
                        <xsl:attribute name="value">
                          <xsl:value-of select="//cd_lingua" />
                        </xsl:attribute>
                      </input>
                      <input type="hidden" name="hAction" id="hAction" />
                      <input type="button">
                        <xsl:attribute name="onclick">
                          javascript:document.form_id.hAction.value = 'Update';document.form_id.action='sa_pagina_dtl_for_map.aspx?redirect=true&#38;lng=<xsl:value-of select="//language" />';document.form_id.submit();
                        </xsl:attribute>
                        <xsl:attribute name="value">
                          <xsl:choose>
                            <xsl:when test="//hAction = 'Borrar'">
                              <xsl:value-of select="//L_SA_DELETE" />
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="//L_SA_UPDATE" />
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:attribute>
                      </input>
                    </td>
                  </tr>
                </table>

                <xsl:if test="//choose_capstone = 1">

                  <script>
                    make_check();
                  </script>
                </xsl:if>

                <xsl:if test="//choose_start_point = 1">

                  <script>
                    make_check_start();
                  </script>
                </xsl:if>
              </form>

              <!-- ************  ENDS CONTENT  ************ -->
            </td>
          </tr>
          <tr>
            <td align="center">
              <!-- Insert footer -->
            </td>
          </tr>
        </table>
        <script type="text/javascript">

          $( document ).ready(function() {

          setValue('<xsl:value-of select="//pagina_Type" />','<xsl:value-of select="//pagina_Cat" />');

          });
        </script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>