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

      <title>Network | Interaction events</title>

      <script type="text/javascript" src="../common/vis.js">
      </script>
      <link href="../common/vis-network.min.css" rel="stylesheet" type="text/css" />

      <style type="text/css">
        #mynetwork {
        width: 1200px;
        height: 800px;
        border: 1px solid lightgray;
        }
      </style>

      <body>

        <script   type="text/javascript">

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
          alert(p);
          var res = str.split(" ");
          alert(res[0]);

          for (i = 0; i &lt; res.length; i++) {
          var str1 = res[i].split(",");
          edges.add([
          {from: str1[0], to: str1[1]}
          ]);

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
            <td valign="top" height="350" CLASS="CONTENT">
              <!-- ************ BEGINS CONTENT ************ -->

              <!-- Breadcrumbs -->

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
              <B>&#62;</B>
              <a>
                <xsl:attribute name="href">
                  javascript:document.frmSession.action='Pagina.aspx?lng=<xsl:value-of select="//language" />&#38;pagina=<xsl:value-of select="//pagina_id" />&#38;opus=<xsl:value-of select="//opus_id" />';document.frmSession.submit();
                </xsl:attribute>
                <span class="MEDIUM">
                  <xsl:value-of select="//opus_name1" />
                </span>
              </a>
              <B>&#62;</B>

              <a>
                <xsl:attribute name="href">
                  javascript:document.frmSession.action='Tractus.aspx?lng=<xsl:value-of select="//language" />&#38;opus=<xsl:value-of select="//opus_id" />';document.frmSession.submit();
                </xsl:attribute>
                <span class="MEDIUM">
                  <xsl:value-of select="//P_TRACTUS" />
                </span>
              </a>

              <B>&#62;</B>

              <a>
                <xsl:attribute name="href">
                  javascript:document.frmSession.action='discussion.aspx?lng=<xsl:value-of select="//language" />&#38;pagina=<xsl:value-of select="//pagina_id" />&#38;opus=<xsl:value-of select="//opus_id" />';document.frmSession.submit();
                </xsl:attribute>
                <span class="MEDIUM">
                  <xsl:value-of select="//P_TRACTUS" />
                </span>
              </a>

              <B>&#62;</B>
              <span class="BOLDMEDIUM">
                <xsl:value-of select="//P_TRACTUS" />
              </span>
              <p />

              <p />
              <xsl:if test="//user_logon != 'LOGGED-OFF'">

              <!-- TABLE OF WORKS -->
              <table border="0" cellpadding="6" align="center">

                <div id="mynetwork"></div>
                <pre id="eventSpan"></pre>

                <script type="text/javascript">

                  // create an array with nodes
                  var nodes = new vis.DataSet([   ]);

                  // create an array with edges
                  var edges = new vis.DataSet([                  ]);

                  var col=0;

                  for (i = 1; i &lt; 37; i++) {
                       if(i &lt; 36)
                  {
                  col=getRandomColor();
                  nodes.add([{id: i, label:i,color:col}]);
                  }

                  }

                  var str =','+'<xsl:value-of select="//result1" />';
                  var res = str.split(" ");
                  for (i = 0; i &lt; res.length; i++) {
                  var str1 = res[i].split(",");
                  edges.add([
                  {from: str1[1], to: str1[2], arrows:'to'}
                  ]);
                  }

                  var condition1=1;

                  //*****************************************************************************************************************

                  if(condition1==1)
                  {
                  // create a network
                  var container = document.getElementById('mynetwork');
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
                 document.getElementById('eventSpan').innerHTML = '<h2>Click event:</h2>' +  params.nodes;
                  });

                  network.on("doubleClick", function (params) {
                  params.event = "[original event]";
                  document.getElementById('eventSpan').innerHTML =  '<h2>doubleClick event:</h2>' +  params.nodes;
                  var pagina_id="pagina="+params.nodes;
                  k='../src/Pagina.aspx?lng=<xsl:value-of select="//language" />&#38;opus=1&#38;'+pagina_id;

                  document.frmSession.action=k;document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();

                  });

                  }

                  //**************************************************************************************************

                  if(condition1==2)
                  {

                  var network;
                  var allNodes;
                  var highlightActive = false;

                  var nodesDataset =nodes; //new vis.DataSet(nodes); // these come from WorldCup2014.js
                  var edgesDataset =edges;// new vis.DataSet(edges); // these come from WorldCup2014.js

                  function redrawAll() {
                  var container = document.getElementById('mynetwork');
                  var options = {
                  nodes: {
                  shape: 'dot',
                  scaling: {
                  min: 10,
                  max: 30,
                  label: {
                  min: 8,
                  max: 8,
                  drawThreshold: 1,
                  maxVisible: 20
                  }
                  },
                  font: {
                  size: 12,
                  face: 'Tahoma'
                  }
                  },
                  edges: {
                  width: 0.9,
                  color: {inherit: 'from'},
                  smooth: {
                  type: 'continuous'
                  }
                  },
                  physics:  {
                  forceAtlas2Based: {
                  gravitationalConstant: -20
                  }},
                  interaction: {
                  tooltipDelay: 400,
                  hideEdgesOnDrag: true
                  }
                  };
                  var data = {nodes:nodesDataset, edges:edgesDataset} // Note: data is coming from ./datasources/WorldCup2014.js

                  network = new vis.Network(container, data, options);

                  // get a JSON object
                  allNodes = nodesDataset.get({returnType:"Object"});

                  network.on("click",neighbourhoodHighlight);
                  }

                  function neighbourhoodHighlight(params) {
                  // if something is selected:
                  if (params.nodes.length > 0) {
                  highlightActive = true;
                  var i,j;
                  var selectedNode = params.nodes[0];
                  var degrees = 2;

                  // mark all nodes as hard to read.
                  for (var nodeId in allNodes) {

                  if (allNodes[nodeId].hiddenLabel === undefined) {
                  allNodes[nodeId].hiddenLabel = allNodes[nodeId].label;
                  allNodes[nodeId].label = undefined;
                  }
                  }
                  var connectedNodes = network.getConnectedNodes(selectedNode);
                  var allConnectedNodes = [];

                  // get the second degree nodes
                  for (i = 1; i &lt; degrees; i++) {
                  for (j = 0; j &lt; connectedNodes.length; j++) {
                  allConnectedNodes = allConnectedNodes.concat(network.getConnectedNodes(connectedNodes[j]));
                  }
                  }

                  // all second degree nodes get a different color and their label back
                  for (i = 0; i &lt; allConnectedNodes.length; i++) {

                  if (allNodes[allConnectedNodes[i]].hiddenLabel !== undefined) {
                  allNodes[allConnectedNodes[i]].label = allNodes[allConnectedNodes[i]].hiddenLabel;
                  allNodes[allConnectedNodes[i]].hiddenLabel = undefined;
                  }
                  }

                  // all first degree nodes get their own color and their label back
                  for (i = 0; i &lt; connectedNodes.length; i++) {
                  allNodes[connectedNodes[i]].color = undefined;
                  if (allNodes[connectedNodes[i]].hiddenLabel !== undefined) {
                  allNodes[connectedNodes[i]].label = allNodes[connectedNodes[i]].hiddenLabel;
                  allNodes[connectedNodes[i]].hiddenLabel = undefined;
                  }
                  }

                  // the main node gets its own color and its label back.
                  allNodes[selectedNode].color = undefined;
                  if (allNodes[selectedNode].hiddenLabel !== undefined) {
                  allNodes[selectedNode].label = allNodes[selectedNode].hiddenLabel;
                  allNodes[selectedNode].hiddenLabel = undefined;
                  }
                  }
                  else if (highlightActive === true) {
                  // reset all nodes
                  for (var nodeId in allNodes) {
                  allNodes[nodeId].color = undefined;
                  if (allNodes[nodeId].hiddenLabel !== undefined) {
                  allNodes[nodeId].label = allNodes[nodeId].hiddenLabel;
                  allNodes[nodeId].hiddenLabel = undefined;
                  }
                  }
                  highlightActive = false
                  }

                  // transform the object into an array
                  var updateArray = [];
                  for (nodeId in allNodes) {
                  if (allNodes.hasOwnProperty(nodeId)) {
                  updateArray.push(allNodes[nodeId]);
                  }
                  }
                  nodesDataset.update(updateArray);
                  }

                  redrawAll()

                  network.on("click", function (params) {
                  params.event = "[original event]";
                  document.getElementById('eventSpan').innerHTML = '<h2>Click event:</h2>' +  params.nodes;
                  });

                  network.on("doubleClick", function (params) {
                  params.event = "[original event]";
                  document.getElementById('eventSpan').innerHTML =  '<h2>doubleClick event:</h2>' +  params.nodes;
                  var pagina_id="pagina="+params.nodes;
                  k='../src/Pagina.aspx?lng=<xsl:value-of select="//language" />&#38;opus=1&#38;'+pagina_id;

                  document.frmSession.action=k;document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();

                  });

                  }

                  <!--
                  var network;
                  var allNodes;
                  var highlightActive = false;

                  var nodesDataset =nodes; //new vis.DataSet(nodes); // these come from WorldCup2014.js
                  var edgesDataset =edges;// new vis.DataSet(edges); // these come from WorldCup2014.js

                  function redrawAll() {
                  var container = document.getElementById('mynetwork');
                  var options = {
                  nodes: {
                  shape: 'dot',
                  scaling: {
                  min: 10,
                  max: 30,
                  label: {
                  min: 8,
                  max: 8,
                  drawThreshold: 1,
                  maxVisible: 20
                  }
                  },
                  font: {
                  size: 12,
                  face: 'Tahoma'
                  }
                  },
                  edges: {
                  width: 0.9,
                  color: {inherit: 'from'},
                  smooth: {
                  type: 'continuous'
                  }
                  },
                  physics: false,
                  interaction: {
                  tooltipDelay: 400,
                  hideEdgesOnDrag: true
                  }
                  };
                  var data = {nodes:nodesDataset, edges:edgesDataset} // Note: data is coming from ./datasources/WorldCup2014.js

                  network = new vis.Network(container, data, options);

                  // get a JSON object
                  allNodes = nodesDataset.get({returnType:"Object"});

                  network.on("click",neighbourhoodHighlight);
                  }

                  function neighbourhoodHighlight(params) {
                  // if something is selected:
                  if (params.nodes.length > 0) {
                  highlightActive = true;
                  var i,j;
                  var selectedNode = params.nodes[0];
                  var degrees = 2;

                  // mark all nodes as hard to read.
                  for (var nodeId in allNodes) {
                  allNodes[nodeId].color = 'rgba(150,100,10,0.5)';

                  if (allNodes[nodeId].hiddenLabel === undefined) {
                  allNodes[nodeId].hiddenLabel = allNodes[nodeId].label;
                  allNodes[nodeId].label = undefined;
                  }
                  }
                  var connectedNodes = network.getConnectedNodes(selectedNode);
                  var allConnectedNodes = [];

                  // get the second degree nodes
                  for (i = 1; i &lt; degrees; i++) {
        for (j = 0; j &lt; connectedNodes.length; j++) {
          allConnectedNodes = allConnectedNodes.concat(network.getConnectedNodes(connectedNodes[j]));
        }
      }

      // all second degree nodes get a different color and their label back
      for (i = 0; i &lt; allConnectedNodes.length; i++) {
        allNodes[allConnectedNodes[i]].color = 'rgba(150,150,150,0.75)';
        if (allNodes[allConnectedNodes[i]].hiddenLabel !== undefined) {
          allNodes[allConnectedNodes[i]].label = allNodes[allConnectedNodes[i]].hiddenLabel;
          allNodes[allConnectedNodes[i]].hiddenLabel = undefined;
        }
      }

      // all first degree nodes get their own color and their label back
      for (i = 0; i &lt; connectedNodes.length; i++) {
        allNodes[connectedNodes[i]].color = undefined;
        if (allNodes[connectedNodes[i]].hiddenLabel !== undefined) {
          allNodes[connectedNodes[i]].label = allNodes[connectedNodes[i]].hiddenLabel;
          allNodes[connectedNodes[i]].hiddenLabel = undefined;
        }
      }

      // the main node gets its own color and its label back.
      allNodes[selectedNode].color = undefined;
      if (allNodes[selectedNode].hiddenLabel !== undefined) {
        allNodes[selectedNode].label = allNodes[selectedNode].hiddenLabel;
        allNodes[selectedNode].hiddenLabel = undefined;
      }
    }
    else if (highlightActive === true) {
      // reset all nodes
      for (var nodeId in allNodes) {
        allNodes[nodeId].color = undefined;
        if (allNodes[nodeId].hiddenLabel !== undefined) {
          allNodes[nodeId].label = allNodes[nodeId].hiddenLabel;
          allNodes[nodeId].hiddenLabel = undefined;
        }
      }
      highlightActive = false
    }

    // transform the object into an array
    var updateArray = [];
    for (nodeId in allNodes) {
      if (allNodes.hasOwnProperty(nodeId)) {
        updateArray.push(allNodes[nodeId]);
      }
    }
    nodesDataset.update(updateArray);
  }

  redrawAll()

-->

//*****************************************************************************************************************
                </script>
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
          $(document).ready(
          function(){

          });
        </script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>