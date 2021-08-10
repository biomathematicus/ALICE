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
      <script type="text/javascript" src="../common/map.js">  </script>
      <script type="text/javascript" src="../common/vis.js">
      </script>
      <link href="http://visjs.org/dist/vis-network.min.css" rel="stylesheet" type="text/css" />
      <style type="text/css">
        #mynetwork{
        var w= $(document).width()/2;
        var h=height:$(document).height()/2;
        w=window.innerWidth-200;
        h = window.innerHeight-2;

        width:700;
        height:h;
        border: 1px solid lightgray;
        }

        #personalize_net{
        width: $(document).width();
        height:$(document).height();
        border: 1px solid lightgray;
        }

        #operation {
        font-size:28px;
        }
        #node-popUp {
        display:none;
        position:absolute;
        top:350px;
        left:170px;
        z-index:299;
        width:250px;
        height:120px;
        background-color: #f9f9f9;
        border-style:solid;
        border-width:3px;
        border-color: #5394ed;
        padding:10px;
        text-align: center;
        }
        #edge-popUp {
        display:none;
        position:absolute;
        top:350px;
        left:170px;
        z-index:299;
        width:250px;
        height:90px;
        background-color: #f9f9f9;
        border-style:solid;
        border-width:3px;
        border-color: #5394ed;
        padding:10px;
        text-align: center;
        }
      </style>

      <body>

        <xsl:if test="//user_status = 3 or //Validation=1">
          <script   type="text/javascript">

            var arry_ds_title = [];
            var arry_ds_tag_bri = [];
            var arry_ds_content_bri = [];

            //*****************************************************************************************
            function saveposition(network,nodes) {

            var d=nodes.get();

            var positions="";
            for (i = 0; i &lt; d.length; i++)
            {

            try {

            pp= JSON.stringify(nodes.get(), null, 4);

            obj = JSON.parse(pp);
            var pp1= network.getPositions(obj[i].id);
            var new_id=obj[i].id;
            var startNode = JSON.stringify(pp1);
            var json = JSON.parse(startNode);
            var X=json[new_id].x;
            var Y=json[new_id].y;

            positions=positions+","+new_id+"," +X+","+Y+"#";

            }
            catch (err) {

            }

            }

            var locx=network.getViewPosition().x;
            var locy=network.getViewPosition().y;

            positions=positions+"#$$,"+network.getScale()+"," +locx+","+locy+"%%";

            var options = {
            position: {x:159.524,y:-142.316},
            scale: 1,
            offset: {x:0,y:0},
            animation: true
            };
            network.moveTo(options);

            document.getElementById("nodes11").value=JSON.stringify(nodes.get(), null, 4);

            document.getElementById("send_info").value=positions;
            document.getElementById("check1").value='true';
            document.getElementById("form_sa_map").submit();

            }

            //***************************************************************************************
            function recover_position(list_position) {

            all_position=list_position;
            }

            //***************************************************************************************

            <xsl:for-each select="/doc/tractus/pagina_name">
              collect_str('<xsl:value-of select="name" />','<xsl:value-of select="id" />','<xsl:value-of select="pagina_type" />','<xsl:value-of select="pagina_cat" />','<xsl:value-of select="capstone" />','<xsl:value-of select="color" />');
            </xsl:for-each>

            id_opus='<xsl:value-of select="//id_opus" />';

            bold_path_info('<xsl:value-of select="//id_vertex" />');

            get_edges_info('<xsl:value-of select="//matrix_edges" />');
            get_lang(' <xsl:value-of select="//language" />');
            get_edges_personalize('<xsl:value-of select="//matrix_personalize" />' );
            recover_position('<xsl:value-of select="//positions_graph" />');
          </script>

          <form id="frmSession1" method="post" name="frmSession1" action="">

            <input type="hidden" id="hAction" name="hAction"></input>
          </form>

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
                    sa_opus_lst.aspx?artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />
                  </xsl:attribute>
                  <xsl:value-of select="//sa_opus_lst" />
                </a> &#62;
                <b>
                  <xsl:value-of select="//L_MAP" />
                </b>

                <!-- Breadcrumbs end -->
                <!-- Begin tabulated menu -->
                <!-- Blue line -->
                <xsl:text disable-output-escaping="yes">
		                <![CDATA[<table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td height="1" class="TabOff" colspan="15"><img src="../images/system/px_alpha.gif" height="1" width="" /></td></tr></table>]]>
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
                  </table>
                </div>

                <!-- ************  ENDS CONTENT  ************ -->
              </td>
            </tr>
          </table>

          <form name="sa_map" method="post" id="form_sa_map">

            <input type="hidden" id="send_info"  name="sendata"></input>
            <input type="hidden" id="check1"  name="check_name"></input>
            <input type="hidden" id="nodes11"  name="nodes_name"></input>
            <input type="hidden" id="edges11"  name="edges_name"></input>
            <input type="button"  id="update_bu" value="Update" name="sub1" onclick="saveposition(network,nodes)"></input>
          </form>

          <div id="node-popUp">
            <span id="node-operation">node</span>

            <table style="margin:auto;">
              <tr>
                <td>id</td>
                <td>
                  <input id="node-id" value="new value" />
                </td>
              </tr>
              <tr>
                <td>label</td>
                <td>
                  <input id="node-label" value="new value" />
                </td>
              </tr>
            </table>
            <input type="button" value="save" id="node-saveButton" />
            <input type="button" value="cancel" id="node-cancelButton" />
          </div>

          <div id="edge-popUp">
            <span id="edge-operation">edge</span>

            <table style="margin:auto;">
              <tr>
                <td>label</td>
                <td>
                  <input id="edge-label" value="new value" />
                </td>
              </tr>
            </table>
            <input type="button" value="save" id="edge-saveButton" />
            <input type="button" value="cancel" id="edge-cancelButton" />
          </div>

          <div id="divOutputWindow">

            <table style="width:100%">
              <tr>
                <td>

                  <div id="mynetwork" ></div>
                </td>
                <td    CLASS="TITLE_LIGHT" align="center">

                  <iframe id="iframe_id" src="" width="800" height="800">
                    <p>Your browser does not support iframes.</p>
                  </iframe>
                </td>
              </tr>
            </table>
          </div>

          <xsl:apply-templates select="//footer" />

          <script type="text/javascript">
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
            $('div#divOutputWindow table tr td').eq(0).css('height','1000px');
            network=graph(nodes_name,nodes_id,nodes_type,nodes_cat,matrix_of_edges,LAnguage_,'mynetwork','',all_position,capstone_,'');

            call(1);

            });
          </script>
        </xsl:if>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>