<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="l_html_header.xsl" />
  <xsl:include href="l_menu_top.xsl" />
  <xsl:include href="l_menu_left.xsl" />
  <xsl:include href="l_menu_right.xsl" />
  <xsl:include href="l_footer.xsl" />
  <xsl:include href="l_counter.xsl" />
  <xsl:template match="/">
    <html lang="EN">
      <!-- Insert HTML header -->
      <xsl:apply-templates select="//html_header" />
      <script type="text/javascript" src="../common/vis.js">        </script>

      <script type="text/javascript" src="../common/tractus.js">
      </script>
      <link href="http://visjs.org/dist/vis-network.min.css" rel="stylesheet" type="text/css" />
      <style type="text/css">

        #mynetwork{
        width: $(document).width();
        height:$(document).height();
        border: 1px solid lightgray;
        }
      </style>
      <body>

        <script   type="text/javascript">

          var category_show=0;
          var id_category_interest_base='';
          var next_lesson_=0;
          var graph_json='';
          var next_lesson_str="";
          var nameOfNextLesson="";

          function init() {
          container = document.getElementById('mynetwork');
          exportArea = document.getElementById('input_output');
          importButton = document.getElementById('import_button');
          exportButton = document.getElementById('export_button');

          draw();
          }

          function addConnections(elem, index) {
          // need to replace this with a tree of the network, then get child direct children of the element
          elem.connections = network.getConnectedNodes(index);

          }

          function destroyNetwork() {
          network.destroy();
          }

          function clearOutputArea() {
          exportArea.value = "";
          }

          function draw() {
          // create a network of nodes
          var data = getScaleFreeNetwork(5);

          network = new vis.Network(container, data, {manipulation:{enabled:true}});

          clearOutputArea();
          }

          function exportNetwork() {
          clearOutputArea();

          var nodes = objectToArray(network.getPositions());

          nodes.forEach(addConnections);

          // pretty print node data
          var exportValue = JSON.stringify(nodes, undefined, 2);

          exportArea.value = exportValue;

          resizeExportArea();

          }
          //*******************************************************************

          function getNodeData(data) {
          var networkNodes = [];

          data.forEach(function(elem, index, array) {
          networkNodes.push({id: elem.id, label: elem.id, x: elem.x, y: elem.y});
          });

          return new vis.DataSet(networkNodes);
          }

          function getNodeById(data, id) {
          for (var n = 0; n &lt; data.length; n++) {
          if (data[n].id == id) {  // double equals since id can be numeric or string
          return data[n];
          }
          };

          throw 'Can not find id \'' + id + '\' in data';
          }

          function getEdgeData(data) {
          var networkEdges = [];

          data.forEach(function(node) {
          // add the connection
          node.connections.forEach(function(connId, cIndex, conns) {
          networkEdges.push({from: node.id, to: connId});
          let cNode = getNodeById(data, connId);

          var elementConnections = cNode.connections;

          // remove the connection from the other node to prevent duplicate connections
          var duplicateIndex = elementConnections.findIndex(function(connection) {
          return connection == node.id; // double equals since id can be numeric or string
          });

          if (duplicateIndex != -1) {
          elementConnections.splice(duplicateIndex, 1);
          };
          });
          });

          return new vis.DataSet(networkEdges);
          }

          function objectToArray(obj) {
          return Object.keys(obj).map(function (key) {
          obj[key].id = key;
          return obj[key];
          });
          }

          function resizeExportArea() {
          exportArea.style.height = (1 + exportArea.scrollHeight) + "px";
          }

          function exportMyNetwork(network1) {
          var nodes = objectToArray(network.getPositions());

          nodes.forEach(addConnections);
          var exportValue = JSON.stringify(nodes, undefined, 2);

          return exportValue;

          }

          //********************************************************************************************

          function add_option(id,value1){

          $('#pagina_cat_id').append($(' &lt;option &gt;', {
          value: id,
          text: value1
          }))
          }

          function update_map(){

          document.getElementById("p_pagina").submit()

          network= graph(nodes_name,nodes_id,nodes_type,nodes_cat,matrix_of_edges,LAnguage_,'mynetwork',path_b,all_position,capstone_,color_g,category_show_1);
          network.fit();

          }

          //***************************************************************************************
          var Pagina_id_=<xsl:value-of select="//pagina_id_" />
          <xsl:for-each select="/doc/pagina_name">
            collect_str('<xsl:value-of select="name" />','<xsl:value-of select="id" />','<xsl:value-of select="pagina_type" />','<xsl:value-of select="pagina_cat" />','<xsl:value-of select="capstone" />','<xsl:value-of select="color" />');
          </xsl:for-each>
          <xsl:for-each select="/doc/vertex">
            bold_path_info('<xsl:value-of select="id_vertex" />');
          </xsl:for-each>

          get_edges_info('<xsl:value-of select="//matrix_edges" />');
          get_lang(' <xsl:value-of select="//language" />');
          get_edges_personalize('<xsl:value-of select="//matrix_personalize" />' );
          recover_position('<xsl:value-of select="//positions_graph" />');
          Opus_id=<xsl:value-of select="//id_opus" />;
          id_category_interest_base=<xsl:value-of select="//id_category_interest_base" />;
        </script>

        <table width="800px" align="center" border="0" cellpadding="0" cellspacing="0" id="tblMain" name="tblMain">
          <tr valign="top">
            <td rowspan="3" valign="top">
              <!-- Insert left menu -->
              <xsl:apply-templates select="//left_menu" />
            </td>
            <td valign="top" width="100%">
              <!-- Insert header -->
              <xsl:apply-templates select="//top_menu" />
            </td>
            <td rowspan="3" valign="top">
              <!-- Insert right menu -->
              <xsl:apply-templates select="//right_menu" />
            </td>
          </tr>
          <tr>
            <td valign="top" height="350" CLASS="MEDIUM" align="left">
              <!-- ************ BEGINS CONTENT ************ -->
              <!-- Breadcrumbs Begin -->
              <table>
                <tr>
                  <td style="white-space: nowrap">
                    <a>
                      <xsl:attribute name="href">
                        initium.aspx?lng=<xsl:value-of select="//language" />
                      </xsl:attribute>
                      <span class="MEDIUM">
                        <xsl:value-of select="//P_INITIUM" />
                      </span>
                    </a>
                    <B>&#62;</B>
                    <a>
                      <xsl:attribute name="href">
                        index.aspx?lng=<xsl:value-of select="//language" />
                      </xsl:attribute>
                      <span class="MEDIUM">
                        <xsl:value-of select="//P_INDEX" />
                      </span>
                    </a>
                    <B>&#62;</B>
                    <span class="BOLDMEDIUM">
                      <xsl:value-of select="//ds_opus" />
                    </span>
                  </td>
                  <td width="80%"></td>
                  <xsl:if test="//user_id != ''">
                    <tr>
                      <td colspan="2" class="TITLE_DARK">
                        <!-- Page Status-->
                        <xsl:apply-templates select="//page_counter" />
                      </td>
                    </tr>
                  </xsl:if>
                </tr>
              </table>
              <!-- Breadcrumbs End -->
              <p />
              <form name="p_pagina" id ="p_pagina" method="post" action="">
                <xsl:variable name="id_user_login" select="//user_logon" />
                <xsl:variable name="log_off" select="iob" />
                <xsl:if test="//user_logon = 'LOGGED-OFF'">
                  <xsl:value-of select="//T_REGIS_WARNING" disable-output-escaping="yes" />
                </xsl:if>
                <table border="0" cellpadding="2" align="left"  CLASS="CONTENT" width="100%">
                  <!-- tr>
									<td colspan="2" CLASS="TITLE_DARK">
										<xsl:apply-templates select="//page_counter" />
									</td>
								</tr -->
                  <tr>
                    <td colspan="2" CLASS="TITLE_LIGHT">
                      <xsl:choose>
                        <xsl:when test="/doc/param/user_status[. = '3']">
                          <!-- <xsl:value-of select="//L_PAGE" />:  -->
                          <span class="H1">
                            <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                              <xsl:attribute name="href">
                                javascript:document.frmSession.action='../admin/sa_pagina_dtl.aspx?lng=<xsl:value-of select="//language" />&#38;pagina=<xsl:value-of select="//id_pagina" />&#38;opus=<xsl:value-of select="//id_opus" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
                              </xsl:attribute>
                              <xsl:value-of select="//pag_title" />
                            </a>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <!-- <xsl:value-of select="//L_PAGE" />:  -->
                          <span class="H1">
                            <xsl:value-of select="//pag_title" />
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2" CLASS="CONTENT">
                      <!-- Begin tabulated menu -->
                      <table border="0" cellspacing="1" cellpadding="2" id="tblTab" name="tblTab">
                        <tr>
                          <td width="74" id="tabIntro" class="TabOn" background="../images/system/bgd_tab_80x20.gif"   style=" display:initial">
                            <a href="javascript:LoadTab('Intro')">&#160;&#160;&#160;&#160;&#160;&#160;Intro&#160;&#160;&#160;&#160;&#160;</a>
                          </td>
                          <td width="74" id="tabWiki" class="TabOff" style="visibility:hidden; display:none" background="../images/system/bgd_tab_80x20.gif">
                            <a href="javascript:LoadTab('Wiki');">&#160;&#160;&#160;&#160;&#160;&#160;Wiki&#160;&#160;&#160;&#160;&#160;</a>
                          </td>
                          <td width="74" id="tabPDF" class="TabOff" style="visibility:hidden; display:none" background="../images/system/bgd_tab_80x20.gif">
                            <a href="javascript:LoadTab('PDF');">&#160;&#160;&#160;&#160;&#160;&#160;PDF&#160;&#160;&#160;&#160;&#160;&#160;</a>
                          </td>
                          <td width="74" id="tabLiveScribe" class="TabOff" style="visibility:hidden; display:none" background="../images/system/bgd_tab_80x20.gif">
                            <a href="javascript:LoadTab('LiveScribe');">&#160;Livescribe&#160;</a>
                          </td>
                          <td width="74" id="tabMedia" class="TabOff" style="visibility:hidden; display:none" background="../images/system/bgd_tab_80x20.gif">
                            <a href="javascript:LoadTab('Media');">&#160;&#160;&#160;&#160;Media&#160;&#160;&#160;&#160;</a>
                          </td>
                          <td width="74" id="tabSource" class="TabOff" style="visibility:hidden; display:none" background="../images/system/bgd_tab_80x20.gif">
                            <a href="javascript:LoadTab('Source');">&#160;&#160;&#160;&#160;&#160;&#160;Source&#160;&#160;&#160;&#160;&#160;</a>
                          </td>
                          <xsl:if test="//user_logon !='LOGGED-OFF'">
                            <td width="74" id="tabGraph" class="TabOff" background="../images/system/bgd_tab_80x20.gif">
                              <a href="javascript:LoadTab('mynetwork');">Map</a>
                            </td>
                            <td width="74" id="tabTest" class="TabOff" background="../images/system/bgd_tab_80x20.gif"  style=" display:initial">
                              <a href="javascript:LoadTab('Test');">&#160;&#160;&#160;&#160;&#160;Test&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</a>
                            </td>
                          </xsl:if>
                        </tr>
                      </table>
                      <!-- Blue line -->
                      <xsl:text disable-output-escaping="yes">
		                <![CDATA[<table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td height="1" class="TabOff" colspan="15"><img src="../images/system/px_alpha.gif" height="1" width="" /></td></tr></table>]]>
		                </xsl:text>
                      <!-- End tabulated menu -->
                      <div id="material">
                        <div id="container"></div>
                        <div id="Wiki" style="visibility:hidden; display:none"></div>
                        <div id="PDF" style="visibility:hidden; display:none"></div>
                        <div id="LiveScribe" style="visibility:hidden; display:none"></div>
                        <div id="Media" style="visibility:hidden; display:none"></div>
                        <div id="Source" style="visibility:hidden; display:none"></div>
                        <div id="PDF1"></div>

                        <div id="Intro"  style="visibility:hidden; display:none">
                          <br />The next lesson is :

                          <a id="herf_next_lesson">

                            <xsl:attribute name="href">
                              javascript:redirect_pagina('<xsl:value-of select="//language" />', '<xsl:value-of select="//id_opus" />',next_lesson_)
                            </xsl:attribute>

                            <xsl:value-of select="//next_lesson" />
                          </a>

                          <br />
                          <xsl:for-each select="/doc/syllabus/prereq">
                            <xsl:choose>
                              <xsl:when test="(am_grade &gt; 79)">
                                <img src="../images/system/ico_visited_grad.gif"  width="16">
                                  <xsl:attribute name="alt">
                                    <xsl:value-of select="//L_VISITED" />
                                  </xsl:attribute>
                                </img>
                              </xsl:when>
                              <xsl:when test="(am_grade &gt; 0) and (am_grade &lt; 80)">
                                <img src="../images/system/ico_visited.gif" width="16">
                                  <xsl:attribute name="alt">
                                    <xsl:value-of select="//L_VISITED" />
                                  </xsl:attribute>
                                </img>
                              </xsl:when>
                              <xsl:otherwise>
                                <img src="../images/system/ico_visited_not.gif"  width="14">
                                  <xsl:attribute name="alt">
                                    <xsl:value-of select="//L_VISITED_NOT" />
                                  </xsl:attribute>
                                </img>
                              </xsl:otherwise>
                            </xsl:choose>
                            &#160;&#160; <xsl:value-of select="id_prereq" /> -
                            <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                              <xsl:attribute name="href">
                                javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="id_prereq" />')
                              </xsl:attribute>
                              <xsl:value-of select="ds_prereq" />
                            </a>
                            <br />
                          </xsl:for-each>
                          <xsl:value-of select="//pag_content"  disable-output-escaping="yes" />
                        </div>
                        <script>LoadTab("Intro"); </script>

                        <xsl:if test="//user_logon !='LOGGED-OFF'">
                          <div id="Test" style="visibility:visible; display:none">
                            <form id="frmUpload" runat="server">
                              <input id="state" type="hidden">
                                <xsl:attribute name="value">
                                  <xsl:value-of select="//language" />
                                </xsl:attribute>
                              </input>
                              <h1>Homework Assignment for this Lesson</h1>
                              <script>
                                document.write('<p>' + sHW + '</p>');
                              </script>
                              <!--                     <xsl:choose>
                                <xsl:when test="//take='0'">  -->
                              <div>
                                <input type="file" accept=".pdf,.doc,.docx,.rtf">
                                  <xsl:attribute name="id">
                                    <xsl:value-of select="/doc/id_pagina" />
                                  </xsl:attribute>
                                </input>
                                <input type="button" id="btnUpload" value="Upload Files">
                                  <xsl:attribute name="onclick">
                                    show(<xsl:value-of select="/doc/id_pagina" />,'<xsl:value-of select="//user_name" />',' ', '  ','<xsl:value-of select="//user_id" />','<xsl:value-of select="//id_opus" />' ,'<xsl:value-of select="/doc/cd_new_id" />' )
                                  </xsl:attribute>
                                </input>
                              </div>
                              <!--                             </xsl:when>
                              </xsl:choose>   -->
                              <xsl:choose>
                                <xsl:when test="//take &gt;'0'">
                                  <div>
                                    <a id="myLink" href="#">
                                      <xsl:attribute name="onclick">
                                        produce_add( '<xsl:value-of select="//link_homework" />')
                                      </xsl:attribute>
                                      <xsl:value-of select="//L_SEE_HM" />
                                    </a>
                                    <p>
                                      <xsl:value-of select="//L_UPLOADED_HM" />
                                    </p>
                                  </div>
                                </xsl:when>
                              </xsl:choose>

                              <xsl:choose>
                                <xsl:when test="//Grade_ &gt;'0'">
                                  <div>

                                    <p>
                                      Grade :  <xsl:value-of select="//Grade_" />
                                    </p>
                                  </div>
                                </xsl:when>
                              </xsl:choose>

                              <xsl:choose>
                                <xsl:when test="//Comments_ !='false'">

                                  <div>

                                    <p>
                                      Feedback : <xsl:value-of select="//Comments_" />
                                    </p>
                                  </div>
                                </xsl:when>
                              </xsl:choose>

                              <!--upload home work-->
                              <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                                <xsl:attribute name="href">
                                  javascript:document.frmSession.action='../src/upload.aspx?lng=<xsl:value-of select="//language" />&#38;pagina=<xsl:value-of select="//id_pagina" />&#38;opus=<xsl:value-of select="//id_opus" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
                                </xsl:attribute>
                                <xsl:value-of select="//L_SEE_SB_HM" />
                              </a>
                              <!--upload home work-->
                            </form>
                          </div>
                        </xsl:if>
                      </div>
                    </td>
                  </tr>
                </table>
                <div id="adaptive">
                  <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td colspan="2">
                        <p>&#160;</p>
                      </td>
                    </tr>
                    <xsl:if test="//pending_prereq = '0'">
                      <xsl:if test="/doc/pending/link[. != '']">
                        <tr>
                          <td align="left" CLASS="TITLE_LIGHT" colspan="2">
                            <span class="BOLDMEDIUM">
                              <xsl:value-of select="//L_LINK_PENDING" disable-output-escaping="yes" />
                            </span>
                          </td>
                        </tr>
                        <tr>
                          <td align="left"  CLASS="MEDIUM" colspan="2">
                            <xsl:for-each select="/doc/pending/link">
                              <xsl:value-of select="score" />%&#160;
                              <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                                <xsl:attribute name="href">
                                  javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="id_pagina" />')
                                </xsl:attribute>
                                <xsl:value-of select="ds_title" />
                              </a>
                              <br />
                              <xsl:value-of select="ds_tag" /><br /><br />
                            </xsl:for-each>
                          </td>
                        </tr>
                      </xsl:if>
                    </xsl:if>

                    <xsl:if test="//cd_opus != 'LITERATRONIC'">
                      <tr>
                        <td align="left" CLASS="TITLE_LIGHT" width="50%">
                          <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                            <xsl:attribute name="href">
                              javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="//pag_prv" />')
                            </xsl:attribute>
                            <xsl:value-of select="//L_PREVIOUS" />
                          </a>
                        </td>

                        <td align="right" CLASS="TITLE_LIGHT" width="50%">
                          <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                            <xsl:attribute name="href">
                              javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="//pag_nxt" />')
                            </xsl:attribute>
                            <xsl:value-of select="//L_NEXT" />
                          </a>
                        </td>
                      </tr>
                    </xsl:if>
                  </table>
                </div>
                <div id="choose_category">
                  <p>Please Choose Your Interest</p>
                  <select name ="pagina_cat" id="pagina_cat_id" onchange="update_map()">

                    <script>
                      add_option(0,"Please Select your Interest")

                      <xsl:for-each select="/doc/Lables">
                        add_option( '<xsl:value-of select="id_opus_category" />','<xsl:value-of select="id_opus_Lable" />');
                      </xsl:for-each>
                    </script>

                    <xsl:attribute name="onclick">
                    </xsl:attribute>
                  </select>
                </div>

                <div id="mynetwork"></div>
              </form>
              <div id="captions1">
                <xsl:for-each select="/doc/pagina_sec">
                  <input type="hidden">
                    <xsl:attribute name="value">
                      <xsl:value-of select="pagina_title" />
                    </xsl:attribute>
                    <xsl:attribute name="name">
                      <xsl:value-of select="id" />
                    </xsl:attribute>
                    <xsl:attribute name="id">
                      <xsl:value-of select="id_cap" />
                    </xsl:attribute>
                  </input>
                </xsl:for-each>
              </div>
              <p />
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

      <script type="text/javascript">
        $( document ).ready(function() {

        document.getElementById('mynetwork').style.width = "800px";
        document.getElementById('mynetwork').style.height = "800px";

        network= graph(nodes_name,nodes_id,nodes_type,nodes_cat,matrix_of_edges,LAnguage_,'mynetwork',path_b,all_position,capstone_,color_g,category_show);

        network.fit();
        document.getElementById("mynetwork").style.display = "none";
        document.getElementById("choose_category").style.display = "none";
        $("#pagina_cat_id").prop("selectedIndex", id_category_interest_base);
        var node_list_b = path_b.split(",");
        var next_l=0;
        for (i = 0; i &#60; node_list_b.length - 1 ; i++) 
        {
          if ( node_list_b[i]==Pagina_id_)
          {
            next_lesson_=node_list_b[i+1];
            next_l=parseInt(node_list_b[i+1]);
          }
        }
        next_lesson_str=next_lesson_.toString();
        if (next_l > 0) 
        {
          var searchEles = document.getElementById("captions1").children;
          nameOfNextLesson=document.getElementById(searchEles[next_l-1].id).value;
          $("#herf_next_lesson").text(nameOfNextLesson);
        }
        else
        {
          $("#herf_next_lesson").text("there is no next course for this lesson");
        }

        /*
        if(Opus_id=33)
        {
          var mediatab=document.getElementById("tabMedia");
          document.getElementById("tabWiki").style.display = "";
          document.getElementById("tabWiki").style.visibility = "visible";
        }
        */
        });
      </script>
    </html>
  </xsl:template>
</xsl:stylesheet>