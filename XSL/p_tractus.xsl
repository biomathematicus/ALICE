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
      <script type="text/javascript" src="../common/vis.js">
      </script>
      <link href="../common/vis-network.min.css" rel="stylesheet" type="text/css"/>
      <style type="text/css">
        #mynetwork{
        width: $(document).width();
        height:$(document).height();
        border: 1px solid lightgray;
        }

        #personalize_net{
        width: $(document).width();
        height:$(document).height();
        border: 1px solid lightgray;
        }
      </style>

      <body>
        <script   type="text/javascript"    >

          var nodes_name="";
          var nodes_id="";
          var matrix_of_edges="";
          var matrix_per="";
          var counter_1=0;
          var LAnguage_="";
          function getRandomColor() {
          var letters = '0123456789ABCDEF';
          var color = '#';
          for (var i = 0; i &lt; 6; i++ ) {
          color += letters[Math.floor(Math.random() * 16)];
          }
          return color;
          }

          function sleep(milliseconds) {
          var start = new Date().getTime();
          for (var i = 0; i &lt; 1e7; i++) {
          if ((new Date().getTime() - start) > milliseconds){
          break;
          }
          }
          }

          function myFunction(p,nodes,edges) {
          var str =p;
          var res = str.split(" ");
          for (i = 0; i &lt; res.length; i++) {
          var str1 = res[i].split(",");
          edges.add([
          {from: str1[0], to: str1[1]}
          ]);
          }
          }

          function collect_str(name,id) {

          nodes_name=nodes_name+name+"*$#";
          nodes_id=nodes_id+id+"*$#";

          counter_1=counter_1+1;
          }

          function get_edges_info(matrix_edge) {

          matrix_of_edges=","+matrix_edge;
          }


          function get_edges_personalize(matrix_edge_per) {

          matrix_per=","+matrix_edge_per;
          }




          function get_lang(lan) {

          LAnguage_=lan;
          }



          function graph(nodes_name_1,nodes_id_1,matrix_of_edges_1,LAnguage_1,net_1) {



          // create an array with nodes
          var nodes = new vis.DataSet([   ]);
          // create an array with edges
          var edges = new vis.DataSet([                  ]);
          var col=0;
          var cap='';


          var name_n = nodes_name_1.split("*$#");
          var id_n = nodes_id_1.split("*$#");
          for (i = 0; i &lt; name_n.length; i++)
          {
          col=getRandomColor();

          nodes.add([{id: id_n[i], label:name_n[i],color:col}]);

          }



          var str =matrix_of_edges_1;   //parameter
          var res = str.split(" ");
          for (i = 0; i &lt; res.length; i++) {
          var str1 = res[i].split(",");
          edges.add([
          {from: str1[1], to: str1[2], arrows:'to'}
          ]);
          }

          var condition1=1;


          if(condition1==1)
          {
          // create a network
          var container = document.getElementById(net_1);
          var data = {
          nodes: nodes,
          edges: edges
          };
          var options = {
          nodes: {
          shape: 'dot',
          size: 20
          },
          physics: {
          forceAtlas2Based: {
          gravitationalConstant: 0,
          centralGravity: 0.00,
          springLength: 230,
          springConstant: 0.0
          },
          maxVelocity: 10,
          solver: 'forceAtlas2Based',
          timestep: 0.05,
          stabilization: {iterations: 20}
          }
          };
          var network = new vis.Network(container, data, options);

          network.on("click", function (params) {
          params.event = "[original event]";
          document.getElementById('eventSpan').innerHTML = '';
          });


          network.on("doubleClick", function (params) {
          params.event = "[original event]";
          document.getElementById('eventSpan').innerHTML =  '<h2>doubleClick event:</h2>' +  params.nodes;
          var pagina_id="pagina="+params.nodes;
          k='../src/Pagina.aspx?lng='+ LAnguage_1+'&#38;opus=28&#38;'+pagina_id;
          document.frmSession.action=k;document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
          });

          }





















          }






          <xsl:for-each select="/doc/tractus/pagina_name">
            collect_str('<xsl:value-of select="name"/>','<xsl:value-of select="id"/>');

          </xsl:for-each>
          get_edges_info('<xsl:value-of select="//matrix_edges"/>');
          get_lang(' <xsl:value-of select="//language" />');
          get_edges_personalize('<xsl:value-of select="//matrix_personalize"/>' );
        </script>



        <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
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
            <td valign="top" align="left" class="MEDIUM">
              <!-- ************ BEGINS CONTENT ************ -->
              <!-- Breadcrumbs begin -->
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
                  javascript:document.frmSession.action='Pagina.aspx?lng=<xsl:value-of select="//language" />&#38;pagina=<xsl:value-of select="//pag_nxt"/>&#38;opus=<xsl:value-of select="//id_opus" />';document.frmSession.submit();
                </xsl:attribute>
                <span class="MEDIUM">
                  <xsl:value-of select="//opus_name"/>
                </span>
              </a>
              <B>&#62;</B>
              <span class="BOLDMEDIUM">
                <xsl:value-of select="//P_TRACTUS"/>
              </span>
              <p/>
              <!-- Breadcrumbs end -->
              <!-- Begin tabulated menu -->
              <table border="0" cellspacing="1" cellpadding="2" id="tblTab" name="tblTab" >
                <tr>
                  <td width="74" id="tabIntro" class="TabOn" background="../images/system/bgd_tab_80x20.gif">
                    <a href="javascript:LoadTab_v('Intro')">Lessons</a>
                  </td>
                  <td width="74" id="tabmynet" class="TabOff" background="../images/system/bgd_tab_80x20.gif">
                    <a href="javascript:LoadTab_v('mynet');">Map</a>
                  </td>
                  <td width="74" id="tabSyllabus" class="TabOff" background="../images/system/bgd_tab_80x20.gif">
                    <a href="javascript:LoadTab_v('Syllabus');">Syllabus</a>
                  </td>
                </tr>
              </table>
              <!-- Blue line -->
              <xsl:text disable-output-escaping="yes">
		                <![CDATA[<table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td height="1" class="TabOff" colspan="15"><img src="../images/system/px_alpha.gif" height="1" width=""/></td></tr></table>]]>
		                </xsl:text>
              <!-- End tabulated menu -->
              <xsl:value-of select="//T_REGIS_WARNING" disable-output-escaping="yes" />
              <div id="Intro">
                <table border="0" cellpadding="2" width="100%"  align="left">
                  <tr>
                    <td colspan="2" class="TITLE_DARK">
                      <!-- Page Status-->
                      <xsl:apply-templates select="//page_counter" />
                    </td>
                  </tr>
                  <xsl:for-each select="/doc/tractus/pagina">
                    <tr valign="top">
                      <td CLASS="TITLE_DARK">
                        <xsl:value-of select="id"/>
                        <br/>
                        <xsl:if test="//user_id != ''">
                          <xsl:choose>
                            <xsl:when test="visited[. = 'true']">
                              <xsl:if test="home_work != 'false'">
                                <xsl:if test="visited_grad != 'true'">
                                  <img src="../images/system/ico_visited.gif" width="16">
                                    <xsl:attribute name="alt">
                                      <xsl:value-of select="//L_VISITED" />
                                    </xsl:attribute>
                                  </img>
                                </xsl:if>
                                <xsl:if test="visited_grad != 'false'">
                                  <img src="../images/system/ico_visited_grad.gif"  width="16">
                                    <xsl:attribute name="alt">
                                      <xsl:value-of select="//L_VISITED" />
                                    </xsl:attribute>
                                  </img>
                                </xsl:if>
                              </xsl:if>
                              <xsl:if test="home_work != 'true'">
                                <img src="../images/system/ico_visited_not.gif"  width="14">
                                  <xsl:attribute name="alt">
                                    <xsl:value-of select="//L_VISITED" />
                                  </xsl:attribute>
                                </img>
                              </xsl:if>
                            </xsl:when>

                            <xsl:otherwise>
                              <img src="../images/system/ico_visited_not.gif"  width="14">
                                <xsl:attribute name="alt">
                                  <xsl:value-of select="//L_VISITED_NOT" />
                                </xsl:attribute>
                              </img>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:if>
                        <xsl:if test="//user_id != ''">
                          <xsl:choose>
                            <xsl:when test="capstone=1">
                              <xsl:if test="choose_capstone != 'true'">
                                <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                                  <xsl:attribute name="href">
                                    javascript:document.frmSession.action='../src/Tractus.aspx?lng=<xsl:value-of select="//language" />&#38;action=cap&#38;opus=<xsl:value-of select="//id_opus"/>&#38;pagina=<xsl:value-of select="id"/>';document.frmSession.submit();
                                  </xsl:attribute>
                                  <img src="../images/unselect.ico" border="0">
                                    <xsl:attribute name="alt">
                                      <xsl:value-of select="//L_CHAPTER_DEL" />
                                    </xsl:attribute>
                                  </img>&#160;
                                  <span class="XSMALL">
                                  </span>
                                </a>&#160;
                              </xsl:if>

                              <xsl:if test="choose_capstone != 'false'">
                                <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                                  <xsl:attribute name="href">
                                    javascript:document.frmSession.action='../src/Tractus.aspx?lng=<xsl:value-of select="//language" />&#38;action=cap_r&#38;opus=<xsl:value-of select="//id_opus"/>&#38;pagina=<xsl:value-of select="id"/>';document.frmSession.submit();
                                  </xsl:attribute>
                                  <img src="../images/select.ico" border="0">
                                    <xsl:attribute name="alt">
                                      <xsl:value-of select="//L_CHAPTER_DEL" />
                                    </xsl:attribute>
                                  </img>&#160;
                                  <span class="XSMALL">
                                  </span>
                                </a>&#160;
                              </xsl:if>

                            </xsl:when>
                          </xsl:choose>
                        </xsl:if>
                      </td>
                      <td CLASS="CONTENT">
                        <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                          <xsl:attribute name="href">
                            javascript:document.frmSession.action='../src/Pagina.aspx?lng=<xsl:value-of select="//language" />&#38;opus=<xsl:value-of select="//id_opus"/>&#38;pagina=<xsl:value-of select="id"/>';document.frmSession.submit();
                          </xsl:attribute>
                          <b>
                            <xsl:value-of select="title" />
                          </b>
                        </a>
                        <xsl:if test="//user_logon != 'LOGGED-OFF'"    >
                          <!--          
                        <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                        <xsl:attribute name="href">
                          javascript:document.frmSession.action='../src/discussion.aspx?lng=<xsl:value-of select="//language" />&#38;opus=<xsl:value-of select="//id_opus"/>&#38;pagina=<xsl:value-of select="id"/>';document.frmSession.submit();
                        </xsl:attribute>
                          <b>
                            &#160;
                            &#160;
                            &#160;
                            &#160;
                            <b>
                              <xsl:value-of select="//L_DISCUSSION" />
                            </b>
                          </b>
                        </a>    
                        -->
                        </xsl:if>
                        <span class="XSMALL">
                          <xsl:if test="visited[. = 'true'] and //user_id != ''">
                            (<xsl:value-of select="//L_VISITED" />)<br/>
                            <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                              <xsl:attribute name="href">
                                javascript:document.frmSession.action='../src/Tractus.aspx?lng=<xsl:value-of select="//language" />&#38;action=del&#38;opus=<xsl:value-of select="//id_opus"/>&#38;pagina=<xsl:value-of select="id"/>';document.frmSession.submit();
                              </xsl:attribute>
                              <img src="../images/system/ico_delete.gif" border="0">
                                <xsl:attribute name="alt">
                                  <xsl:value-of select="//L_CHAPTER_DEL" />
                                </xsl:attribute>
                              </img>&#160;
                              <span class="XSMALL">
                                <xsl:value-of select="//L_CHAPTER_DEL" />
                              </span>
                            </a>&#160;
                            <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
                              <xsl:attribute name="href">
                                javascript:document.frmSession.action='../src/Tractus.aspx?lng=<xsl:value-of select="//language" />&#38;action=delall&#38;opus=<xsl:value-of select="//id_opus"/>&#38;pagina=<xsl:value-of select="id"/>';document.frmSession.submit();
                              </xsl:attribute>
                              <img src="../images/system/ico_delete_all.gif" border="0">
                                <xsl:attribute name="alt">
                                  <xsl:value-of select="//L_CHAPTER_DEL_ALL" />
                                </xsl:attribute>
                              </img>&#160;
                              <span class="XSMALL">
                                <xsl:value-of select="//L_CHAPTER_DEL_ALL" />
                              </span>
                            </a>
                          </xsl:if>
                          <xsl:if test="visited[. = 'false'] and //user_id != ''">
                            (<xsl:value-of select="//L_VISITED_NOT" />)
                          </xsl:if>
                        </span>
                        <br/>
                        <xsl:if test="visited[. = 'false'] and //user_id != ''">
                          <!-- Checkbox is present if the lexia has not been accessed -->
                          <input type="checkbox"  name="chbox">
                            <xsl:attribute name="value">
                              <xsl:value-of select="id"/>
                            </xsl:attribute>
                            <xsl:attribute name="id">
                              chk<xsl:value-of select="id"/>
                            </xsl:attribute>
                          </input>
                        </xsl:if>
                        <xsl:value-of select="tag" disable-output-escaping="yes"/>
                      </td>
                    </tr>
                  </xsl:for-each>

                </table>
              </div>

              <!-- ************  ENDS CONTENT  ************ -->
            </td>
          </tr>

          <!--tr>
						<td align="center">
							< Insert footer >
							<xsl:apply-templates select="//footer" />
						</td>
					</tr-->
        </table>

        <form name="p_tractus" method="post" >

          <xsl:attribute name="action">
            Tractus.aspx?lng=<xsl:value-of select="//language" />&#38;opus=<xsl:value-of select="//id_opus"/>
          </xsl:attribute>
          <input  onclick="categoryOnClick()"  type="hidden">
            <!--   type="submit"-->

            <xsl:attribute name="value">
              <xsl:value-of select="//L_set_known" />
            </xsl:attribute>
          </input>
          <input type="hidden" id="senddata" value="click" name="sendata1"></input>
        </form>

        <div id="mynetwork" ></div>
        <div id="personalize_net" ></div>

        <pre id="eventSpan"></pre>

        <xsl:apply-templates select="//footer" />

        <script type="text/javascript">

        /*
        Produce an approximated Eulerian path
        var str ='<xsl:value-of select="//graded_list"/>';
        var res = str.split(" ");
        for (i = 0; i &lt; MNI.length; i++) {
            for (j = 0; j &lt; MNI.length; j++) {
                for (j = 0; j &lt; MNI.length; j++) {
                  // First step: Replace graded vertices
                  if (MNI[i,j]==res[j]) MNI[i,j] = MNI[i,res[j]];
                  // Second step: Correction needed when destination vertex has been graded, i.e. no movement
                  if (MNI[i,j]==res[j]) MNI[i,j] = i;
              }
            }
          }
          =======
          >>>>>>> 1.20
          */

        </script>
        <script type="text/javascript">
          function categoryOnClick() {
          var rows = document.getElementsByName('chbox');
          var selectedRows = [];
          for (var i = 0, l = rows.length; i  &lt; l; i++) {
          if (rows[i].checked) {
          selectedRows.push(rows[i].value);
          }
          }
          $("#senddata").val(selectedRows);
          var kk=$("#senddata").val();
          }

          $( document ).ready(function() {
          graph(nodes_name,nodes_id,matrix_of_edges,LAnguage_,'mynetwork')

          graph(nodes_name,nodes_id,matrix_per,LAnguage_,'personalize_net')

          document.getElementById("mynetwork").style.display = "none";
          document.getElementById("personalize_net").style.display = "none";

          });


        </script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
