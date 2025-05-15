/*********************************************************
Function	: Labor()
Purpose		: Saves student homework
Parameters	: idOpus, idPagina, idUser, action
Returns		: 
JBG - 05/2024
*********************************************************/
function Labor(idOpus, idPagina, idUser, action) {
	// Prevent the default form submission if this is part of a form
	event.preventDefault();

	// Collect the textarea content
	var assessmentText = $('textarea[name="txtSTUDENT"]').val();

	// Setup the data object to send
	var data = {
		'id_opus': idOpus,
		'id_pagina': idPagina,
		'id_nauta': idUser,
		'txtSTUDENT': assessmentText,
		'actionAJAX': action
	};

	// Make the AJAX call
	$.ajax({
		type: "POST",
		url: "Pagina.ashx",
		data: data,
		success: function (response) {
			alert('Data submitted: ' + response);
		},
		error: function () {
			alert('Error submitting data');
		}
	});
}

/*********************************************************
Function	: SLO()
Purpose		: Saves SLOs on a page
Parameters	: idOpus, idPagina, cdLingua, action
Returns		: 
JBG - 05/2024
*********************************************************/
function SLO(idOpus, idPagina, cdLingua, action) {
	// Prevent the default form submission if this is part of a form
	event.preventDefault();

	// Collect the textarea content
	var SLOText = $('textarea[name="txtSLO"]').val();

	// Setup the data object to send
	var data = {
		'id_opus': idOpus,
		'id_pagina': idPagina,
		'cd_lingua': cdLingua,
		'txtSLO': SLOText,
		'actionAJAX': action
	};

	// Make the AJAX call
	$.ajax({
		type: "POST",
		url: "Pagina.ashx",
		data: data,
		success: function (response) {
			alert('Data submitted: ' + response);
		},
		error: function () {
			alert('Error submitting data');
		}
	});
}

/*********************************************************
Function	: ASSESS()
Purpose		: Saves asessment on a page
Parameters	: idOpus, idPagina, cdLingua, action
Returns		: 
JBG - 05/2024
*********************************************************/
function ASSESS(idOpus, idPagina, cdLingua, action) {
	// Prevent the default form submission if this is part of a form
	event.preventDefault();

	// Collect the textarea content
	var ASSESSText = $('textarea[name="txtASSESS"]').val();

	// Setup the data object to send
	var data = {
		'id_opus': idOpus,
		'id_pagina': idPagina,
		'cd_lingua': cdLingua,
		'txtASSESS': ASSESSText,
		'actionAJAX': action
	};

	// Make the AJAX call
	$.ajax({
		type: "POST",
		url: "Pagina.ashx",
		data: data,
		success: function (response) {
			alert('Data submitted: ' + response);
		},
		error: function () {
			alert('Error submitting data');
		}
	});
}

/*********************************************************
Function	: LESSON()
Purpose		: Saves lesson content on a page
Parameters	: idOpus, idPagina, cdLingua, action
Returns		: 
JBG - 05/2024
*********************************************************/
function LESSON(idOpus, idPagina, cdLingua, action) {
	// Prevent the default form submission if this is part of a form
	event.preventDefault();

	// Collect the textarea content
	var LESSONText = $('textarea[name="txtLESSON"]').val();

	// Setup the data object to send
	var data = {
		'id_opus': idOpus,
		'id_pagina': idPagina,
		'cd_lingua': cdLingua,
		'txtLESSON': LESSONText,
		'actionAJAX': action
	};

	// Make the AJAX call
	$.ajax({
		type: "POST",
		url: "Pagina.ashx",
		data: data,
		success: function (response) {
			alert('Data submitted: ' + response);
		},
		error: function () {
			alert('Error submitting data');
		}
	});
}

function renderMarkdown(oTextArea, oFormattedDiv, renderBtn, editBtn) {
	var textArea = document.getElementsByName(oTextArea)[0];
	var formattedDiv = document.getElementById(oFormattedDiv);
	formattedDiv.innerHTML = textArea.value;
	MarkdownToHtml(oFormattedDiv);
	textArea.style.display = 'none';
	formattedDiv.style.display = 'block';
	document.getElementById(renderBtn).style.display = 'none';
	document.getElementById(editBtn).style.display = 'inline';
}

function editMarkdown(oTextArea, oFormattedDiv, renderBtn, editBtn) {
	var textArea = document.getElementsByName(oTextArea)[0];
	var formattedDiv = document.getElementById(oFormattedDiv);
	textArea.style.display = 'block';
	formattedDiv.style.display = 'none';
	document.getElementById(renderBtn).style.display = 'inline';
	document.getElementById(editBtn).style.display = 'none';
}

function showButton(btn) {
	document.getElementById(btn).style.display = 'inline';
}

function hideButton(btn) {
	document.getElementById(btn).style.display = 'none';
}

function setAJAXAction(s) {
	document.getElementById('actionAJAX').value = s;
}
