var nodes_name="";
var nodes_id="";
var matrix_of_edges="";
var matrix_per="";
var counter_1=0;
var LAnguage_="";
var nodes_type="";
var nodes_cat="";
var path_b="";
var matrix_of_weight="";
var all_position="";
var capstone_="";

//***************************************************************************************
function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}
//***************************************************************************************
function recover_position(list_position) {
    all_position=list_position;
}

//****************************************************************************************

function sleep(milliseconds) {
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) {
        if ((new Date().getTime() - start) > milliseconds){
            break;
        }
    }
}
//***************************************************************************************

function myFunction(p,nodes,edges) {
    var str =p;
    var res = str.split(" ");
    for (i = 0; i < res.length; i++) {
        var str1 = res[i].split(",");
        edges.add([
        {from: str1[0], to: str1[1]}
        ]);
    }
}

//***************************************************************************************
function collect_str(name,id,type,cat,caps) {
    nodes_name=nodes_name+name+"*$#";
    nodes_id=nodes_id+id+"*$#";
    nodes_type=nodes_type+type+"*$#";
    nodes_cat=nodes_cat+cat+"*$#";
    capstone_=capstone_+caps+"*$#";
    counter_1=counter_1+1;
}
//***************************************************************************************

function get_edges_info(matrix_edge) {
    matrix_of_edges=","+matrix_edge;
}

//***************************************************************************************

function get_edges_personalize(matrix_edge_per) {
    matrix_per=","+matrix_edge_per;
}

//***************************************************************************************

function get_lang(lan) {
    LAnguage_=lan;
}

//***************************************************************************************

function find_elemnt_in(arr,element_1) {
    var a = arr.indexOf(element_1);
    return a;
}

//***************************************************************************************

function bold_path_info(new_node) {
    path_b=path_b+new_node+"*$#";
}

//***************************************************************************************

function graph(nodes_name_1,nodes_id_1,nodes_type_1,nodes_cat_1,matrix_of_edges_1,LAnguage_1,net_1,path_bold,all_position,capstone_) {
    var nodes = new vis.DataSet([   ]);
    // create an array with edges
    var edges = new vis.DataSet([                  ]);
    var col=0;
    var cap='';

    var name_n = nodes_name_1.split("*$#");
    var id_n = nodes_id_1.split("*$#");
    var type_n = nodes_type_1.split("*$#");
    var cat_n = nodes_cat_1.split("*$#");
    var node_list_bold = path_bold.split("*$#");
    var sCapstone=capstone_.split("*$#");

    var shape_node='';
    var size_n='';
    var group_n='';
    var each_pos=all_position.split("#");
    var str_p=each_pos[0].split(",");
    for (i = 0; i < name_n.length-1; i++)
    {
        var str_p=each_pos[i].split(",");

        col=getRandomColor();
        size_n=30;

        switch (type_n[i]) {
            case 'ROOT':
                shape_node='square';
                break;
            case 'PRE-REQ':
                shape_node='dot';
                break;
        }
        if (sCapstone[i]=='true')
        {
            shape_node='triangle';
        }
        if (sCapstone[i]=='true' &&	type_n[i]=='PRE-REQ')
        {
            shape_node='star';
            size_n=80;
        }

        switch (cat_n[i]) {
            case 'COMPUTER SCIENCE':
                col='#7FFF00';
                group_n=1;
                break;
            case 'BIOLOGY':
                col='	#DC143C';
                group_n=2;
                break;
            case 'STATISTICS':
                col='#1E90FF';
                group_n=3;
                break;
            case 'MATHEMATICS':
                col='#FFFF00';
                group_n=4;
                break;
            case 'PHYSICS':
                col='#FF7F50';
                group_n=5;
                break;
        }

        nodes.add([{id: id_n[i], label:name_n[i]+"_"+id_n[i],shape:shape_node,color:col ,size:size_n,x:str_p[2],y:str_p[3]}]);
    }

    var str =matrix_of_edges_1;   //parameter
    var res = str.split(" ");
    for (i = 0; i < res.length; i++) {
        var str1 = res[i].split(",");
        edges.add([
        {from: str1[1], to: str1[2], label:str1[3] , arrows:'to'}
        ]);
    }

    for (i = 0; i < node_list_bold.length-2; i++) {
        var val=3;

        edges.add([
        {from:node_list_bold[i] , to: node_list_bold[i+1],value:val, label:str1[3] , arrows:'to'}
        ]);
    }

    var condition1=1;

    if(condition1==1)
    {
        var container = document.getElementById(net_1);

        var x1 = - container.clientWidth / 2 + 50;
        var y1 = - container.clientHeight / 2 + 50;
        var step = 70;

        nodes.add([{id: 1000, label:'Math' ,color:'#FFFF00' ,size:30,shape:'dot',shapeProperties:{borderDashes:[50,50]},x:x1-2300,y:y1-1300}]);
        nodes.add([{id: 1001, label:'PHYSICS'  ,color:'#FF7F50' ,size:30,shape:'dot',x:x1-2300,y:y1-1100}]);
        nodes.add([{id: 1002, label:'STATISTICS'  ,color:'#1E90FF' ,size:30,shape:'dot',x:x1-2300,y:y1-900}]);
        nodes.add([{id: 1003, label:'BIOLOGY'  ,color:'	#DC143C' ,size:30,shape:'dot',x:x1-2300,y:y1-700}]);
        nodes.add([{id: 1004, label:'COMPUTER SCIENCE'  ,color:'#7FFF00' ,size:80,shape: 'image', image: 'star.jpg',x:x1-2300,y:y1-500}]);

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

            for (i = 0; i < name_n.length; i++)
            {
                var num = id_n[i];
                var n = num.toString();
                var pp= network.getPositions(n);
                var startNode = JSON.stringify(pp);
                var json = JSON.parse(startNode);
            }
        });

        network.on("doubleClick", function (params) {
            params.event = "[original event]";
            var pagina_id="pagina="+params.nodes;
            var value1=parseInt(params.nodes);
            if( value1 < 1000)
            {
                k='../src/Pagina.aspx?lng='+ LAnguage_1+'&opus=28&'+pagina_id;
                document.frmSession.action=k;document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
            }
        });

        network.on("beforeDrawing", function (ctx) {
            var nodeId = 1000;
            var nodePosition = network.getPositions([nodeId]);
            ctx.strokeStyle = '#FFFFFF';
            ctx.fillStyle = '#294475';
            //   ctx.circle(nodePosition[nodeId].x, nodePosition[nodeId].y,50);
            ctx.fill();
            ctx.stroke();
        });
        network.on("afterDrawing", function (ctx) {
            var nodeId = 1000;
            var nodePosition = network.getPositions([nodeId]);
            ctx.strokeStyle = '#294475';
            ctx.lineWidth = 4;
            ctx.fillStyle = '#FFFFFF';
            ctx.circle(nodePosition[nodeId].x, nodePosition[nodeId].y,20);
            ctx.fill();
            ctx.stroke();
        });
    }
}