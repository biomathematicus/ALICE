var nodes_name = "";
var nodes_id = "";
var matrix_of_edges = "";
var matrix_per = "";
var counter_1 = 0;
var LAnguage_ = "";
var nodes_type = "";
var nodes_cat = "";
var path_b = "";
var matrix_of_weight = "";
var all_position = "";
var capstone_ = "";
var color_g = "";

var nodes = "";
var edges = "";
var node_number = 0;
var id_opus = '';
var str_edge_double = 0;
var node_identification = 0;
var edge_identification = 0;
var network = "";
var scale__ = "";
var position_x = "";
var position_y = "";
//***************************************************************************************
function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

//***************************************************************************************
function recover_position(list_position) {
    all_position = list_position;
}

//***************************************************************************************

function sleep(milliseconds) {
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) {
        if ((new Date().getTime() - start) > milliseconds) {
            break;
        }
    }
}
//***************************************************************************************

function myFunction(p, nodes, edges) {
    var str = p;
    var res = str.split(" ");
    for (i = 0; i < res.length; i++) {
        var str1 = res[i].split(",");
        edges.add([
        { from: str1[0], to: str1[1] }
        ]);
    }
}

//***************************************************************************************
function collect_str(name, id, type, cat, caps, col_1) {
    nodes_name = nodes_name + name + "*$#";
    nodes_id = nodes_id + id + "*$#";
    nodes_type = nodes_type + type + "*$#";
    nodes_cat = nodes_cat + cat + "*$#";
    capstone_ = capstone_ + caps + "*$#";
    color_g = color_g + col_1 + "*$#";
    counter_1 = counter_1 + 1;
}
//***************************************************************************************

function get_edges_info(matrix_edge) {
    matrix_of_edges = "," + matrix_edge;
}

//***************************************************************************************

function get_edges_personalize(matrix_edge_per) {
    matrix_per = "," + matrix_edge_per;
}

//***************************************************************************************

function get_lang(lan) {
    LAnguage_ = lan;
}

//***************************************************************************************

function find_elemnt_in(arr, element_1) {
    var a = arr.indexOf(element_1);
    return a;
}

//***************************************************************************************

function bold_path_info(new_node) {
    path_b = new_node;
}

//***************************************************************************************

function graph(nodes_name_1, nodes_id_1, nodes_type_1, nodes_cat_1, matrix_of_edges_1, LAnguage_1, net_1, path_bold, all_position, capstone_, color_g) {
	conlose.log('graph()');
	console.log('nodes_name_1 = ' + nodes_name_1 + '\n' +
		'nodes_id_1 = ' + nodes_id_1 + '\n' +
		'nodes_type_1 = ' + nodes_type_1 + '\n' +
		'nodes_cat_1 = ' + nodes_cat_1 + '\n' +
		'matrix_of_edges_1 = ' + matrix_of_edges_1 + '\n' +
		'LAnguage_1 = ' + LAnguage_1 + '\n' +
		'net_1 = ' + net_1 + '\n' +
		'path_bold = ' + path_bold + '\n' +
		'all_position = ' + all_position + '\n' +
		'capstone_ = ' + capstone_ + '\n' +
		'color_g = ' + color_g
	);
	try {
        //  alert(all_position);
        var position1 = all_position.indexOf("$$");
        var position2 = all_position.indexOf("%%");
        var bbc = all_position.substring(position1 + 2, position2);
        var bbc1 = all_position.substring(0, position1 - 1);
        all_position = bbc1;

        var positions__ = bbc.split(",");

        scale__ = positions__[1];
        position_x = positions__[2];
        position_y = positions__[3];
    } catch (err) {
    }

    nodes = new vis.DataSet([]);
    edges = new vis.DataSet([]);

    if (path_bold == 'empty') {
        path_bold = '';
    }

    var res = '';
    var col = 0;
    var cap = '';
    var name_n = nodes_name_1.split("*$#");
    var id_n = nodes_id_1.split("*$#");
    var type_n = nodes_type_1.split("*$#");
    var cat_n = nodes_cat_1.split("*$#");
    var shape_node = '';
    var size_n = '';
    var group_n = '';
    var each_pos = all_position.split("#");
    var str_p = each_pos[0].split(",");
    var sCapstone = capstone_.split("*$#");

    var color_arr = color_g.split("*$#");
    var node_list_bold = path_bold.split(",");
    for (var i = 0; i < node_list_bold.length; i++) { node_list_bold[i] = parseInt(node_list_bold[i], 10); }

    for (i = 0; i < name_n.length - 1 ; i++) {
        var part1 = "", part2 = "", part3 = "0";
        if (i < each_pos.length) {
            var str_p = each_pos[i].split(",");
        }
        col = getRandomColor();
        size_n = 30;

        if (i < type_n.length) {
            switch (type_n[i]) {
                case 'ROOT':
                    shape_node = 'square';
                    part1 = '1';
                    break;
                case 'EXAMPLE':
                    shape_node = 'dot';
                    part1 = '3';
                    break;
                case 'PRE-REQ':
                    shape_node = 'triangle';
                    part1 = '2';
                    break;
            }
        }

        if (path_bold != '') {
            switch (color_arr[i]) {
                case 'red':
                    part3 = '0';
                    break;
                case 'yellow':
                    part3 = '1';
                    break;
                case 'green':
                    part3 = '2';
                    break;
            }

            if (sCapstone[i] == 'true') {
                shape_node = 'star';
                part1 = '0';
                size_n = 50;
            }
            if (sCapstone[i] == 'true' && type_n[i] == 'PRE-REQ') {
                //      shape_node = 'star';
                //      size_n = 80;
                //      part1 = '0';
            }
        }
        if (sCapstone[i] == 'true') {
            shape_node = 'star';
            part1 = '0';
            size_n = 50;
        }

        if (i < cat_n.length) {
            switch (cat_n[i]) {
                case '1':
                    col = '#7FFF00';
                    group_n = 1;
                    part2 = '4';
                    break;
                case '2':
                    col = '	#DC143C';
                    group_n = 2;
                    part2 = '3';
                    break;
                case '3':
                    col = '#1E90FF';
                    group_n = 3;
                    part2 = '1';
                    break;
                case '4':
                    col = '#FFFF00';
                    group_n = 4;
                    part2 = '5';
                    break;
                case '5':
                    col = '#FF7F50';
                    group_n = 5;
                    part2 = '2';
                    break;
            }
        }

        var blod_node = node_list_bold.indexOf(parseInt(id_n[i]));
        if (blod_node > -1) {
            var address = '../images/system/images/' + part1 + part2 + part3 + '.png';

            nodes.add([{ id: id_n[i], label: id_n[i] + ':' + name_n[i], shape: 'image', image: address, size: size_n, x: str_p[2], y: str_p[3] }]);
        }
        else {
            if (path_bold != '' & all_position != '') {
                nodes.add([{ id: id_n[i], label: id_n[i] + ':' + name_n[i], shape: shape_node, color: '#D3D3D3', size: size_n, x: str_p[2], y: str_p[3] }]);
            }
            else {
                if (all_position != '') {
                    nodes.add([{ id: id_n[i], label: id_n[i] + ':' + name_n[i], shape: shape_node, color: col, size: size_n, x: str_p[2], y: str_p[3] }]);
                } else {
                    nodes.add([{ id: id_n[i], label: id_n[i] + ':' + name_n[i], shape: shape_node, color: col, size: size_n }]);
                }
            }
        }
    }

    var str = matrix_of_edges_1;   //parameter
    res = str.split(" ");

    for (i = 0; i < res.length; i++) {
        var str1 = res[i].split(",");

        edges.add([
        { id: i, from: str1[1], to: str1[2], label: str1[3], arrows: 'to' }
        ]);
    }

    if (path_bold != '') {
        for (i = 0; i < node_list_bold.length - 2; i++) {
            edges.add([
            { id: i, from: parseInt(node_list_bold[i]), to: parseInt(node_list_bold[i + 1]), value: 3, arrows: 'to' }
            ]);
        }
    }

    var condition1 = 1;

    if (condition1 == 1) {
        var container = document.getElementById(net_1);

        var x1 = -container.clientWidth / 2 + 50;
        var y1 = -container.clientHeight / 2 + 50;
        var step = 70;

        //  nodes.add([{ id: 1000, label: 'Math', color: '#FFFF00', size: 30, shape: 'dot', x: x1 - 2300, y: y1 - 1300 }]);
        //   nodes.add([{ id: 1001, label: 'PHYSICS', color: '#FF7F50', size: 30, shape: 'dot', x: x1 - 2300, y: y1 - 1100 }]);
        //    nodes.add([{ id: 1002, label: 'STATISTICS', color: '#1E90FF', size: 30, shape: 'dot', x: x1 - 2300, y: y1 - 900 }]);
        //    nodes.add([{ id: 1003, label: 'BIOLOGY', color: '	#DC143C', size: 30, shape: 'dot', x: x1 - 2300, y: y1 - 700 }]);

        var data = {
            nodes: nodes,
            edges: edges
        };
        var options = {
            nodes: {
                shape: 'dot',
                size: 20
            },

            animation: {
                duration: 50,
                easingFunction: "easeInOutQuad"
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
                stabilization: { iterations: 20 }
            },

            //     manipulation: { enabled:true }

            manipulation: {
                //*************************************************************************************
                addNode: function (data, callback) {
                    var d = nodes.get();
                    var len = Object.keys(d).length;
                    data.id = len + 1;
                    var len2 = len + 1;
                    var len3 = len2 + "";
                    data.label = "lesson" + len3;
                    var emptytext = '';
                    var id_opus = document.getElementById('iframe_id').contentWindow.document.getElementById('id_opus').value
                    document.getElementById('iframe_id').contentWindow.document.getElementById('form_id').action = 'sa_pagina_dtl_for_map.aspx?pagina=0&amp;opus=' + id_opus + '&amp;lng=BRITANNIA';
                    document.getElementById('iframe_id').contentWindow.document.getElementById('ds_title_bri').value = data.label;
                    document.getElementById('iframe_id').contentWindow.document.getElementById('ds_tag_bri').value = emptytext;
                    document.getElementById('iframe_id').contentWindow.document.getElementById('ds_content_bri1').value = emptytext;
                    document.getElementById('iframe_id').contentWindow.document.getElementById('ds_title_his').value = data.label;
                    document.getElementById('iframe_id').contentWindow.document.getElementById('ds_tag_his').value = emptytext;
                    document.getElementById('iframe_id').contentWindow.document.getElementById('ds_content_his').value = emptytext;
                    document.getElementById('iframe_id').contentWindow.document.getElementById('hAction').value = 'Agregar';
                    var id_n = nodes_id.split("*$#");
                    nodes_id = nodes_id + "*$#" + id_n.length + "*$#";
                    document.getElementById('iframe_id').contentWindow.document.getElementById('form_id').submit();

                    callback(data);
                    saveposition(network, nodes);
                }

                ,
                //***********************************************************************************
                addEdge: function (edgeData, callback) {
                    var id_opus = document.getElementById('iframe_id').contentWindow.document.getElementById('id_opus').value
                    document.getElementById('iframe_id').contentWindow.document.getElementById('form_id').action = 'sa_reticulum_dtl.aspx?node=' + edgeData.to + '&pagina=' + edgeData.from + '&opus=' + id_opus + '&lng=BRITANNIA';
                    var edge_weight = prompt("Please enter your the wegith of edge");
                    if (edge_weight <= 0) {
                        edge_weight = 1;
                    }
                    edgeData.label = edge_weight;
                    document.getElementById('iframe_id').contentWindow.document.getElementById('am_value').value = edge_weight;
                    document.getElementById('iframe_id').contentWindow.document.getElementById('hAction').value = 'agregar';
                    document.getElementById('iframe_id').contentWindow.document.getElementById('LinkType').value = 'NEXT';
                    document.getElementById('iframe_id').contentWindow.document.getElementById('form_id').submit();
                    var delayMillis = 100; //1 second
                    setTimeout(function () {
                        var address = '../admin/sa_pagina_dtl_for_map.aspx?lng=BRITANNIA' + '&opus=' + id_opus + '&pagina=' + edgeData.from;
                        document.getElementById('iframe_id').src = address;
                        edgeData.arrows = 'to';
                        callback(edgeData);
                        edges.add({
                            from: edgeData.from,
                            to: edgeData.to,
                            label: edge_weight,
                            arrows: 'to'
                        });
                    }, delayMillis);

                    callback(edgeData);
                    saveposition(network, nodes);
                } // end of add edge

                //*************************************************************************************

               , editEdge: function (edgeData, callback) {

                   alert('Sorry, we do not currently have that functionality. ');
                   callback(edgeData);
                  
               }

                //*************************************************************************************
               , deleteEdge: function (edgeData, callback) {
                   var sou_des_node = res[edge_identification].split(",");

                   var id_opus = document.getElementById('iframe_id').contentWindow.document.getElementById('id_opus').value

                   document.getElementById('iframe_id').contentWindow.document.getElementById('am_value').value = 0;
                   document.getElementById('iframe_id').contentWindow.document.getElementById('form_id').action = 'sa_reticulum_dtl.aspx?node=' + sou_des_node[2] + '&pagina=' + sou_des_node[1] + '&opus=' + id_opus + '&lng=BRITANNIA';
                   document.getElementById('iframe_id').contentWindow.document.getElementById('hAction').value = 'Borrar';
                   document.getElementById('iframe_id').contentWindow.document.getElementById('LinkType').value = 'NEXT';
                   //     alert('sa_reticulum_dtl.aspx?node=' + sou_des_node[2] + '&pagina=' + sou_des_node[1] + '&opus=' + id_opus + '&lng=BRITANNIA');
                   //     alert(sou_des_node[2]);

                   document.getElementById('iframe_id').contentWindow.document.getElementById('form_id').submit();
                   //**************************************************************************************************************
                   delayMillis = 1000; //1 second
                   setTimeout(function () {
                       var address = '../admin/sa_pagina_dtl_for_map.aspx?lng=BRITANNIA' + '&opus=' + id_opus + '&pagina=' + sou_des_node[2];
                       document.getElementById('iframe_id').src = address;
                   }, delayMillis);
                   callback(edgeData);
                   saveposition(network, nodes);
               }
                //*************************************************************************************

                //*************************************************************************************
               , deleteNode: function (data, callback) {
                   var id_opus = document.getElementById('iframe_id').contentWindow.document.getElementById('id_opus').value
                   document.getElementById('iframe_id').contentWindow.document.getElementById('form_id').action = 'sa_pagina_dtl_for_map.aspx?pagina=' + node_identification + '&opus=' + id_opus + '&lng=BRITANNIA';
                   document.getElementById('iframe_id').contentWindow.document.getElementById('hAction').value = 'Borrar';
                   document.getElementById('iframe_id').contentWindow.document.getElementById('form_id').submit();
                   var delayMillis = 1000; //1 second
                   setTimeout(function () {
                       var address = '../admin/sa_pagina_dtl_for_map.aspx?lng=BRITANNIA' + '&opus=' + id_opus + '&pagina=' + '1';
                       document.getElementById('iframe_id').src = address;
                   }, delayMillis);
                   callback(data);
                   //alert('sa_pagina_dtl_for_map.aspx?pagina=' + node_identification + '&opus=' + id_opus + '&lng=BRITANNIA');
                   saveposition(network, nodes);
               }
                //*************************************************************************************
            }, interaction: {
                navigationButtons: true,
                keyboard: true
            }
        };
        network = new vis.Network(container, data, options);

        network.once("beforeDrawing", function () {
            network.fit();

            try {
                var options1 = {
                    position: { x: position_x, y: position_y },
                    scale: scale__,
                    offset: { x: 0, y: 0 },
                    animation: {
                        duration: 50,
                        easingFunction: "easeInOutQuad"
                    }
                };

                network.moveTo(options1);
            }
            catch (err) {
            }
        });

        //***********************************************************************************
        function addEdge(edge_id, value, sou, des) {
            try {
                edges.add({
                    id: edge_id,
                    from: sou,
                    to: des,
                    label: value,
                    arrows: 'to'
                });
            }
            catch (err) {
                alert(err);
            }
        }
        function removeEdge(edge_id) {
            try {
                edges.remove({ id: edge_id });
            }
            catch (err) {
                alert(err);
            }
        }
        //******************************************************************************************

        network.on("click", function (params) {
            params.event = "[original event]";
            node_number = params.nodes;
            node_identification = params.nodes;
            edge_identification = params.edges;
            call(node_number);
            for (i = 0; i < name_n.length; i++) {
                var num = id_n[i];
                var n = num.toString();
                var pp = network.getPositions(n);
                var startNode = JSON.stringify(pp);
                var json = JSON.parse(startNode);
            }
        });

        network.on("doubleClick", function (params) {
            params.event = "[original event]";
            var pagina_id = "pagina=" + params.nodes;
            var value1 = parseInt(params.nodes);
            var delayMillis = 10000; //1 second
            if (params.nodes == '') {
                var edge_id = parseInt(params.edges);
                str_edge_double = res[edge_id].split(",");
                var edge_weight = prompt("Please enter your the wegith of edge");
                if (edge_weight > 1000) {
                    edge_weight = 1000;
                }
                if (edge_weight > 0) {
                    removeEdge(edge_id);
                    addEdge(edge_id, edge_weight, str_edge_double[1], str_edge_double[2]);
                    var id_opus = document.getElementById('iframe_id').contentWindow.document.getElementById('id_opus').value
                    document.getElementById('iframe_id').contentWindow.document.getElementById('am_value').value = edge_weight;
                    document.getElementById('iframe_id').contentWindow.document.getElementById('form_id').action = 'sa_reticulum_dtl.aspx?node=' + str_edge_double[1] + '&pagina=' + str_edge_double[2] + '&opus=' + id_opus + '&lng=BRITANNIA';
                    document.getElementById('iframe_id').contentWindow.document.getElementById('hAction').value = 'Edit';
                    document.getElementById('iframe_id').contentWindow.document.getElementById('LinkType').value = 'NEXT';
                    document.getElementById('iframe_id').contentWindow.document.getElementById('form_id').submit();
                    //**************************************************************************************************************
                    delayMillis = 1000; //1 second
                    setTimeout(function () {
                        var address = '../admin/sa_pagina_dtl_for_map.aspx?lng=BRITANNIA' + '&opus=' + id_opus + '&pagina=' + str_edge_double[2];
                        document.getElementById('iframe_id').src = address;
                    }, delayMillis);
                }
            }
            if (value1 < 1000) {
                k = '../src/Pagina.aspx?lng=' + LAnguage_1 + '&opus=' + id_opus + '&' + pagina_id;
                document.getElementById('frmSession').action = k;
                document.getElementById('hAction').value = 'ir_actualizar';
                document.getElementById('frmSession').submit();
            }
        });
    }
    return network;
}

function escapeXml(unsafe) {
    return unsafe.replace(/[<>&'"]/g, function (c) {
        switch (c) {
            case '<': return '&lt;';
            case '>': return '&gt;';
            case '&': return '&amp;';
            case '\'': return '&apos;';
            case '"': return '&quot;';
        }
    });
}

function call(node_num) {
    if (node_num > 0) {
        // document.getElementById('iframe_id').src = '../admin/sa_pagina_dtl_for_map.aspx?pagina=10&#38;opus=28&#38;lng=BRITANNIA';

        var address = '../admin/sa_pagina_dtl_for_map.aspx?lng=BRITANNIA' + '&opus=' + id_opus + '&pagina=' + node_num;
        //  alert(address);

        document.getElementById('iframe_id').src = address;
        //  alert(address);
    }
}