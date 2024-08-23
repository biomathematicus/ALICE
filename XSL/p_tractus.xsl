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
		<script type="text/javascript" src="../common/tractus.js" />
		<script type="text/javascript" src="../common/vis.js" />
		<link href="../common/vis-network.min.css" rel="stylesheet" type="text/css" />   <!-- http://visjs.org/dist/vis-network.min.css -->
      <style type="text/css">
		  .center {
		  border: 5px solid #FFFF00;
		  text-align: center;
		  }

		  #mynetwork{
		  width:  800px; /* $(document).width(); */
		  height: 500px; /* $(document).height(); */
		  border: 1px solid lightgray;
		  }

		  #personalize_net{
		  width: $(document).width();
		  height:500px; /* $(document).height(); */
		  border: 1px solid lightgray;
		  }

		  .container {
		  display: flex;
		  align-items: flex-end; /* Ensures vertical alignment at the bottom */
		  justify-content: space-between; /* Adjusts spacing between the two elements */
		  width: 100%;
		  }

		  /*.table-wrapper,
		  .counter {
		  display: inline-block; /* Ensures elements are displayed inline and are block-level */
		  }*/

		  .counter {
		  display: flex;
		  flex-direction: column;
		  align-items: flex-end; /* Right aligns all children within the div */
		  padding: 20px; /* Adds padding around the content, adjust as needed */
		  }

	  </style>

      <body>
		<xsl:if test="//user_logon !='LOGGED-OFF'">

			  <script   type="text/javascript">
          //**********************************************************************************************
          var graph_json='';
          var id_category_interest_base='';

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
          function importNetwork(graph_info) {

          var container = document.getElementById('mynetwork');

          var inputValue =graph_info ;
          var inputData = JSON.parse(inputValue);
          var data = {
          nodes: getNodeData(inputData),
          edges: getEdgeData(inputData)
          }

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
          network = new vis.Network(container, data, options);

          }

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

          document.getElementById("p_tractus").submit()

          network= graph(nodes_name,nodes_id,nodes_type,nodes_cat,matrix_of_edges,LAnguage_,'mynetwork',path_b,all_position,capstone_,color_g,category_show_1);
          network.fit();

          }
          //***************************************************************************************
          function SingleCapstone(single_capstone_val)
          {
          LoadTab_v('mynet',single_capstone_val);

          }
          //***************************************************************************************
          <xsl:for-each select="/doc/tractus/pagina_name">
            collect_str("<xsl:value-of select="name" />",'<xsl:value-of select="id" />','<xsl:value-of select="pagina_type" />','<xsl:value-of select="pagina_cat" />','<xsl:value-of select="capstone" />','<xsl:value-of select="color" />');
          </xsl:for-each>
          <xsl:for-each select="/doc/tractus/trail/vertex">
          </xsl:for-each>
          Opus_id=<xsl:value-of select="//id_opus" />;
          bold_path_info('<xsl:value-of select="//id_vertex" />');

          get_edges_info('<xsl:value-of select="//matrix_edges" />');
          get_lang(' <xsl:value-of select="//language" />');
          get_edges_personalize('<xsl:value-of select="//matrix_personalize" />' );
          recover_position('<xsl:value-of select="//positions_graph" />');
          id_category_interest_base=<xsl:value-of select="//id_category_interest_base" />;
        </script>


		  <table width="800px" align="center" border="0" cellpadding="0" cellspacing="0" id="tblMain" name="tblMain">
			  <tr valign="top">
				  <td rowspan="4" valign="top">
					  <!-- Insert left menu -->
					  <xsl:apply-templates select="//left_menu" />
				  </td>
				  <td valign="top" width="100%">
					  <!-- Insert header -->
					  <xsl:apply-templates select="//top_menu" />
				  </td>
				  <td rowspan="4" valign="top">
					  <!-- Insert right menu -->
					  <xsl:apply-templates select="//right_menu" />
				  </td>
			  </tr>
			  <tr>
				  <td valign="top" align="left" class="MEDIUM">
					  <!-- ************  CONTENT BEGINS HERE ************ -->
					  <!-- Breadcrumbs begin -->
					  <a href="initium.aspx">
						  <span class="MEDIUM">
							  <xsl:value-of select="//P_INITIUM" />
						  </span>
					  </a>
					  <B>&#62;</B>
					  <a href="index.aspx">
						  <span class="MEDIUM">
							  <xsl:value-of select="//P_INDEX" />
						  </span>
					  </a>
					  <!-- B>&#62;</B> 
					  <a>
						  <xsl:attribute name="href">javascript:Map('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />')</xsl:attribute>
						  <span class="MEDIUM">
							  <xsl:value-of select="//opus_name" />
						  </span>
					  </a -->
					  <B>&#62;</B> 
					  <span class="BOLDMEDIUM">
						  <xsl:value-of select="//opus_name" />
						  <!-- xsl:value-of select="//P_TRACTUS" / -->
					  </span>
					  <!-- p / -->

					  <!-- Breadcrumbs end  javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="//pag_nxt" />')</xsl:attribute>   -->
					  <!-- Begin tabulated menu -->
					  <div class="container">
						  <div class="table-wrapper">
							  <table border="0" cellspacing="2" cellpadding="2" id="tblTab" name="tblTab">
								  <tr>
									  <td width="74" id="tabIntro" class="TabOn" background="../images/system/bgd_tab_80x20.gif">
										  <a href="javascript:LoadTab_v('Intro',0)">Capstones</a>
									  </td>
									  <td width="74" id="tabmynet" class="TabOff" background="../images/system/bgd_tab_80x20.gif">
										  <a href="javascript:LoadTab_v('mynet',0);">Map</a>
									  </td>
									  <td width="74" id="tabSyllabus" class="TabOff" background="../images/system/bgd_tab_80x20.gif">
										  <a href="javascript:LoadTab_v('Syllabus',0);">Syllabus</a>
									  </td>
								  </tr>
							  </table>
						  </div>
						  <div class="counter">
							  <xsl:apply-templates select="//page_counter" >
								  <xsl:with-param name="ShowTitle" select="'NO'" />
							  </xsl:apply-templates>
							  <br />
						  </div>
					  </div>
					  <div class="line" />
					  <!-- End tabulated menu -->

					  <!-- DIV element for capstones begins here -->
					  <div id="Intro">
						  <table border="0" cellpadding="2" width="100%"  align="left">
							  <xsl:for-each select="/doc/tractus/pagina">
								  <xsl:if test="capstone='1'">
									  <tr valign="top">
										  <td CLASS="TITLE_DARK">
											  <xsl:value-of select="id" />
											  <br />
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
																  <xsl:attribute name="href">javascript:Capstone('<xsl:value-of select="//language" />', '<xsl:value-of select="//id_opus" />', '<xsl:value-of select="id" />');</xsl:attribute>
																  <img src="../images/unselect.ico" border="0">
																	  <xsl:attribute name="alt">
																		  <xsl:value-of select="//L_CHAPTER_DEL" />
																	  </xsl:attribute>
																  </img>&#160;
															  </a>&#160;
														  </xsl:if>
														  <xsl:if test="choose_capstone != 'false'">
															  <img src="../images/select.ico" border="0">
																  <xsl:attribute name="alt">
																	  <xsl:value-of select="//L_CHAPTER_DEL" />
																  </xsl:attribute>
															  </img>&#160;
														  </xsl:if>
													  </xsl:when>
												  </xsl:choose>
											  </xsl:if>
										  </td>
										  <td CLASS="CONTENT">
											  <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
												  <xsl:attribute name="href">
													  javascript:Capstone('<xsl:value-of select="//language" />', '<xsl:value-of select="//id_opus" />', '<xsl:value-of select="id" />');
												  </xsl:attribute>
												  <B>
													  <xsl:value-of select="title" />
												  </B>
											  </a>
											  <br />
											  <!-- span class="XSMALL">
												  <xsl:if test="visited[. = 'true'] and //user_id != ''">
													  (
													  <xsl:value-of select="//L_VISITED" />
													  )<br />
													  <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
														  <xsl:attribute name="href">
															  javascript:document.frmSession.action='../src/Tractus.aspx?lng=
															  <xsl:value-of select="//language" />
															  &#38;action=del&#38;opus=
															  <xsl:value-of select="//id_opus" />
															  &#38;pagina=
															  <xsl:value-of select="id" />
															  ';document.frmSession.submit();
														  </xsl:attribute>
														  <img src="../images/system/ico_delete.gif" border="0">
															  <xsl:attribute name="alt">
																  <xsl:value-of select="//L_CHAPTER_DEL" />
															  </xsl:attribute>
														  </img>&#160; <span class="XSMALL">
															  <xsl:value-of select="//L_CHAPTER_DEL" />
														  </span>
													  </a>&#160; <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
														  <xsl:attribute name="href">
															  javascript:document.frmSession.action='../src/Tractus.aspx?lng=
															  <xsl:value-of select="//language" />
															  &#38;action=delall&#38;opus=
															  <xsl:value-of select="//id_opus" />
															  &#38;pagina=
															  <xsl:value-of select="id" />
															  ';document.frmSession.submit();
														  </xsl:attribute>
														  <img src="../images/system/ico_delete_all.gif" border="0">
															  <xsl:attribute name="alt">
																  <xsl:value-of select="//L_CHAPTER_DEL_ALL" />
															  </xsl:attribute>
														  </img>&#160; <span class="XSMALL">
															  <xsl:value-of select="//L_CHAPTER_DEL_ALL" />
														  </span>
													  </a>
												  </xsl:if>
												  <xsl:if test="visited[. = 'false'] and //user_id != ''">
													  (
													  <xsl:value-of select="//L_VISITED_NOT" />
													  )
												  </xsl:if>
												  <br />
												  <xsl:if test="visited[. = 'false'] and //user_id != ''">
													  <input type="checkbox"  name="chbox">
														  <xsl:attribute name="value">
															  <xsl:value-of select="id" />
														  </xsl:attribute>
														  <xsl:attribute name="id">
															  chk
															  <xsl:value-of select="id" />
														  </xsl:attribute>
													  </input>
												  </xsl:if>
											  </span -->
											  <xsl:value-of select="tag" disable-output-escaping="yes" />
										  </td>
									  </tr>
								  </xsl:if>
							  </xsl:for-each>
						  </table>
					  </div>
					  <!-- DIV element for capstones ends  here -->

					  <!-- DIV element for map begins here -->
					  <form name="p_tractus" id="p_tractus" method="post">
						  <xsl:attribute name="action">
							  Tractus.aspx?lng=<xsl:value-of select="//language" />&#38;opus=<xsl:value-of select="//id_opus" />
						  </xsl:attribute>
						  <input  onclick="categoryOnClick()"  type="hidden">
							  <xsl:attribute name="value">
								  <xsl:value-of select="//L_set_known" />
							  </xsl:attribute>
						  </input>
						  <input type="hidden" id="senddata" value="click" name="sendata1">
						  </input>
						  <input type="hidden" id="send_interest"  name="send_interest">
						  </input>
						  <input type="hidden" id="pagina_cat_status" value="click" name="pagina_cat_status">
						  </input>
						  <div id="choose_category">
							  <p>Select your area of emphasis: 
							  <select name ="pagina_cat" id="pagina_cat_id" onchange="update_map()">
								  <script>
									  add_option(0,"Please Select your Interest")
									  <xsl:for-each select="/doc/Lables">
										  add_option( '<xsl:value-of select="id_opus_category" />','<xsl:value-of select="id_opus_Lable" />');
									  </xsl:for-each>
								  </script>
								  <xsl:attribute name="onclick"> </xsl:attribute>
							  </select>
							  </p>
						  </div>
					  </form>
					  <div id="mynetwork" class ="center"> </div>
					  <!-- DIV element for map ends here -->

					<!-- DIV element for syllabus begins here -->
					<div id="personalize_net" style="visibility:hidden;display:none;border:none;">						
						<xsl:for-each select="/doc/tractus/pagina">
							<div>
								<xsl:attribute name="name">
									<xsl:value-of select="id" />
								</xsl:attribute>
								<xsl:attribute name="id">
									course
									<xsl:value-of select="id" />
								</xsl:attribute>
								<br />
								<xsl:if test="//user_id != ''">
									<xsl:choose>
										<xsl:when test="visited[. = 'true']">
											<img src="../images/system/ico_visited.gif" style="width:20px;height:20px;align:left;vertical-align:middle;" >
												<xsl:attribute name="alt">
													<xsl:value-of select="//L_VISITED" />
												</xsl:attribute>
												<xsl:attribute name="id">
													<xsl:value-of select="id_img" />
												</xsl:attribute>
											</img>
										</xsl:when>
										<xsl:otherwise>
											<img src="../images/system/ico_visited_not.gif"   style="width:20px;height:20px;align:left;vertical-align:middle;">
												<xsl:attribute name="alt">
													<xsl:value-of select="//L_VISITED_NOT" />
												</xsl:attribute>
												<xsl:attribute name="id">
													<xsl:value-of select="id_img" />
												</xsl:attribute>
											</img>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
								<!-- br / -->&#32;&#32;
								<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
									<xsl:attribute name="href">
										javascript:document.frmSession.action='../src/Pagina.aspx?lng=
										<xsl:value-of select="//language" />
										&#38;opus=
										<xsl:value-of select="//id_opus" />
										&#38;pagina=
										<xsl:value-of select="id" />
										';document.frmSession.submit();
									</xsl:attribute>
									<B>
										<xsl:value-of select="title" />
									</B>
								</a>
								<span class="XSMALL">
									<xsl:if test="visited[. = 'true'] and //user_id != ''">
										(
										<xsl:value-of select="//L_VISITED" />
										)
									</xsl:if>
									<xsl:if test="visited[. = 'false'] and //user_id != ''">
										(
										<xsl:value-of select="//L_VISITED_NOT" />
										)
									</xsl:if>
								</span>
								<br />
								<xsl:value-of select="tag" disable-output-escaping="yes" />
							</div>
						</xsl:for-each>
					</div>
					<!-- DIV element for syllabus ends here -->


					<!-- ************  ENDS CONTENT  ************ -->
				</td>
			</tr>

		</table>

		<pre id="eventSpan"></pre>

		<xsl:apply-templates select="//footer" />

        <script type="text/javascript">
        </script>
        <script type="text/javascript">
          var category_show=0;
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
			network= graph(nodes_name,nodes_id,nodes_type,nodes_cat,matrix_of_edges,LAnguage_,'mynetwork',path_b,all_position,capstone_,color_g,category_show);
			network.fit();

			document.getElementById("mynetwork").style.display = "none";
			document.getElementById("personalize_net").style.display = "none";
			graph_json=exportMyNetwork(network);
			document.getElementById("choose_category").style.display = "none";

			$("#pagina_cat_id").prop("selectedIndex", id_category_interest_base);

			SingleCapstone( '<xsl:value-of select="//single_capstone" />');
			//if (path_b==''){alert('Select a Capstone')}
			var node_list_b = path_b.split(",");

			var searchEles = document.getElementById("personalize_net").children;
			var list_number_=node_list_b.map(Number);

			for(var i = 0; i &#60; searchEles.length; i++) {
          if(searchEles[i].id.indexOf('course') >-1) {

          if(list_number_.indexOf(i+1)>-1){
          var element=document.getElementById(searchEles[i].id);
          var n="img"+element.getAttribute("name")+"";
          document.getElementById(n).src=node_images[i];
          document.getElementById(searchEles[i].id).id = list_number_.indexOf(i+1);

          }
          else{
          document.getElementById(searchEles[i].id).id = 'should_delete';
          document.getElementById(searchEles[i].id).style.visibility = "hidden";

          }

          }
          }
          var contentToRemove = document.querySelectorAll("#should_delete");
          $(contentToRemove).remove();

          var main = document.getElementById( 'personalize_net' );

          [].map.call( main.children, Object ).sort( function ( a, b ) {
          return +a.id.match( /\d+/ ) - +b.id.match( /\d+/ );
          }).forEach( function ( elem ) {
          main.appendChild( elem );
          });

          });
        </script>
		</xsl:if>
		<xsl:if test="//user_logon ='LOGGED-OFF'">
			<script>
				window.location.href = 'Nuntius.aspx?lng=<xsl:value-of select="//language" />&#38;nuntius=T_UNAUTHORIZED'
			</script>
		</xsl:if>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>