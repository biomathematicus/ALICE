function insertAtCaret(areaId, text) {
	var txtarea = document.getElementById(areaId);
	var scrollPos = txtarea.scrollTop;
	var strPos = 0;
	var br = ((txtarea.selectionStart || txtarea.selectionStart == '0') ?
		"ff" : (document.selection ? "ie" : false));
	if (br == "ie") {
		txtarea.focus();
		var range = document.selection.createRange();
		range.moveStart('character', -txtarea.value.length);
		strPos = range.text.length;
	}
	else if (br == "ff") strPos = txtarea.selectionStart;

	var front = (txtarea.value).substring(0, strPos);
	var back = (txtarea.value).substring(strPos, txtarea.value.length);
	txtarea.value = front + text + back;
	strPos = strPos + text.length;
	if (br == "ie") {
		txtarea.focus();
		var range = document.selection.createRange();
		range.moveStart('character', -txtarea.value.length);
		range.moveStart('character', strPos);
		range.moveEnd('character', 0);
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

	if (document.getElementById("chbox").checked == true) {
		document.getElementById("chbox").value = "true";
	}

	if (document.getElementById("chbox").checked == false) {
		document.getElementById("chbox").value = "false";
		document.getElementById("chbox1").value = "remove";

	}
}

function chekbox_start() {

	if (document.getElementById("chboxstart").checked == true) {
		document.getElementById("chboxstart").value = "true";
	}

	if (document.getElementById("chboxstart").checked == false) {
		document.getElementById("chboxstart").value = "false";
		document.getElementById("chboxstart1").value = "remove";

	}
}

function make_check() {
	document.getElementById("chbox").checked = true;
	document.getElementById("chbox").value = "true";
}

function make_check_start() {
	document.getElementById("chboxstart").checked = true;
	document.getElementById("chboxstart").value = "true";
}

function setValue(type, cat) {

	var type_idx = 20;
	var cat_idx = 30;

	switch (cat) {
		case "BIOLOGY":
			cat_idx = 0;
			break;
		case "PHYSICS":
			cat_idx = 3;
			break;
		case "COMPUTER SCIENCE":
			cat_idx = 1;
			break;
		case "MATHEMATICS":
			cat_idx = 2;
			break;
		case "STATISTICS":
			cat_idx = 4;
	}

	switch (type) {
		case "ROOT":
			type_idx = 0;
			break;
		case "PRE-REQ":
			type_idx = 1;
			break;
		case "EXAMPLE":
			type_idx = 2;
	}

	$("#pagina_cat_id").prop("selectedIndex", cat - 1);
	$("#pagina_type_id").prop("selectedIndex", type_idx);

}

function add_option(id, value1) {
	//  &lt;option &gt;
	$('#pagina_cat_id').append($(' <option >', {
		value: id,
		text: value1
	}))
}
