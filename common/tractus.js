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

var Opus_id = "";
var node_images = "";

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

function graph(nodes_name_1, nodes_id_1, nodes_type_1, nodes_cat_1, matrix_of_edges_1, LAnguage_1, net_1, path_bold, all_position, capstone_, color_g, category_show) {
    if (path_bold == 'empty') {
        path_bold = '';
    }
    var one_gol_course = [-100];
    var source_set = [-100];
    var destination_set = [-100];

    var nodes = new vis.DataSet([]);
    var edges = new vis.DataSet([]);
    var col = 0;
    var cap = '';
    var name_n = nodes_name_1.split("*$#");
    node_images = nodes_name_1.split("*$#");;
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
        node_images[i] = "";
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

            if (category_show > 0) {
                if (cat_n[i] != category_show && type_n[i] == 'PRE-REQ') {
                    col = '#D3D3D3';
                }
                else {
                    one_gol_course.push(id_n[i]);
                }
            }
        }

        var blod_node = node_list_bold.indexOf(parseInt(id_n[i]));
        if (blod_node > -1) {
            var address = '../images/system/images/' + part1 + part2 + part3 + '.png';
            nodes.add([{ id: id_n[i], label: name_n[i], shape: 'image', image: address, size: size_n, x: str_p[2], y: str_p[3] }]);
            node_images[i] = address;
        }
        else {
            if (path_bold != '' & all_position != '') {
                nodes.add([{ id: id_n[i], label: name_n[i], shape: shape_node, color: '#D3D3D3', size: size_n, x: str_p[2], y: str_p[3] }]);
            }
            else {
                if (all_position != '') {
                    nodes.add([{ id: id_n[i], label: name_n[i], shape: shape_node, color: col, size: size_n, x: str_p[2], y: str_p[3] }]);
                } else {
                    nodes.add([{ id: id_n[i], label: name_n[i], shape: shape_node, color: col, size: size_n }]);
                }
            }
        }
    }

    var str = matrix_of_edges_1;   //parameter
    var res = str.split(" ");

    for (i = 0; i < res.length; i++) {
        var str1 = res[i].split(",");

        var edge_size = 1;
        var edge_color = "";

        if (category_show > 0 && source_one_goal > -1 && des_one_goal > -1) {
            edge_size = 2;
            edge_color = "#0000FF";
            source_set.push(str1[1]);
            destination_set.push(str1[2]);
        }
        else {
            edge_color = "#D3D3D3";
        }
        edges.add([
        { // from: str1[1], to: str1[2], label: str1[3], arrows: 'to', value: edge_size, color: edge_color }
            from: str1[1], to: str1[2], arrows: 'to', value: edge_size, color: edge_color
        }
        ]);
    }

    if (path_bold != '') {
        for (i = 0; i < node_list_bold.length - 2; i++) {
            edges.add([
            { from: parseInt(node_list_bold[i]), to: parseInt(node_list_bold[i + 1]), value: 3, arrows: 'to' }
            ]);
        }
    }

    var condition1 = 1;

    if (condition1 == 1) {
        var container = document.getElementById(net_1);

        var x1 = -container.clientWidth / 2 + 50;
        var y1 = -container.clientHeight / 2 + 50;
        var step = 70;

        //   nodes.add([{id: 1000, label:'Math' ,color:'#FFFF00' ,size:30,shape:'dot',x:x1-2300,y:y1-1300}]);
        //   nodes.add([{id: 1001, label:'PHYSICS'  ,color:'#FF7F50' ,size:30,shape:'dot',x:x1-2300,y:y1-1100}]);
        //    nodes.add([{id: 1002, label:'STATISTICS'  ,color:'#1E90FF' ,size:30,shape:'dot',x:x1-2300,y:y1-900}]);
        //    nodes.add([{id: 1003, label:'BIOLOGY'  ,color:'	#DC143C' ,size:30,shape:'dot',x:x1-2300,y:y1-700}]);
        //     alert(destination_set);
        //  alert(source_set);

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
                stabilization: { iterations: 20 }
            }, interaction: {
                navigationButtons: true,
                keyboard: true
            }
        };
        var network = new vis.Network(container, data, options);

        network.once("beforeDrawing", function () {
            network.fit();
        });

        network.on("click", function (params) {
            params.event = "[original event]";

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
            if (value1 < 1000) {
                k = '../src/Pagina.aspx?lng=' + LAnguage_1 + '&opus=' + Opus_id + '&' + pagina_id;
                document.frmSession.action = k; document.frmSession.hAction.value = 'ir_actualizar'; document.frmSession.submit();
            }
        });
    }
    return network;
}

//***************************************************************************