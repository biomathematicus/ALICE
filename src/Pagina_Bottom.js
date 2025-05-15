/*********************************************************
Function	: Upload()
Purpose		: Uploads student homework
Parameters	: idChorus, idOpus, idPagina, idUser, action
Returns		: 
JBG - 05/2025
*********************************************************/
window.addEventListener("load", function () {
	console.log("Window loaded");

	// Attach click event to upload button to prevent form submission
	/*
	const uploadBtn = document.getElementById("btnUpload");
	if (uploadBtn) {
		uploadBtn.addEventListener("click", function (e) {
			e.preventDefault();

			const idChorus = this.getAttribute("id_chorus");
			const idOpus = this.getAttribute("id_opus");
			const idPagina = this.getAttribute("id_pagina");
			const idUser = this.getAttribute("id_nauta");
			const action = this.getAttribute("actionAJAX"); // || "UPLOAD";

			Upload(idChorus, idOpus, idPagina, idUser, action, e);
		});
	}
	*/

	// Handle delete via event delegation (works for existing and future buttons)
	document.getElementById("UploadMessage")?.addEventListener("click", function (e) {
		if (e.target.tagName === "BUTTON") {
			e.preventDefault();
			console.log("Delete button clicked");

			const container = e.target.closest(".uploaded-file-entry");
			const fileUrl = container.getAttribute("data-url");
			const idChorus = container.getAttribute("data-chorus");
			const idOpus = container.getAttribute("data-opus");
			const idPagina = container.getAttribute("data-pagina");
			const idUser = container.getAttribute("data-user");

			if (confirm("Are you sure you want to delete this file?")) {
				const fileName = fileUrl.split("/").pop();
				e.target.disabled = true;

				$.ajax({
					type: "POST",
					url: "Pagina.ashx",
					data: {
						actionAJAX: "DELETE_FILE",
						file: fileUrl,
						file_name: fileName,
						id_chorus: idChorus,
						id_opus: idOpus,
						id_pagina: idPagina,
						id_nauta: idUser
					},
					success: function () {
						alert("File deleted.");
						container.remove();
					},
					error: function () {
						alert("Failed to delete file.");
						e.target.disabled = false;
					}
				});
			}
		}
	});
});

function renderUploadedFile(fileUrl, idChorus, idOpus, idPagina, idUser) {
	const messageDiv = document.getElementById("UploadMessage");
	const entry = document.createElement("div");
	entry.className = "uploaded-file-entry";
	entry.setAttribute("data-url", fileUrl);
	entry.setAttribute("data-chorus", idChorus);
	entry.setAttribute("data-opus", idOpus);
	entry.setAttribute("data-pagina", idPagina);
	entry.setAttribute("data-user", idUser);

	const link = document.createElement("a");
	link.href = fileUrl;
	link.textContent = "There is a document uploaded for this lesson";
	link.target = "_blank";

	const deleteBtn = document.createElement("button");
	deleteBtn.textContent = "Delete";
	deleteBtn.style.marginLeft = "10px";
	deleteBtn.type = "button";

	entry.appendChild(link);
	entry.appendChild(deleteBtn);
	messageDiv.appendChild(entry);

	console.log("Rendered Link: ", fileUrl);
}

function Upload(idChorus, idOpus, idPagina, idUser, action, e) {
	if (e) e.preventDefault();

	const fileInput = document.getElementById("fileUploadButton");
	if (fileInput.files.length === 0) {
		alert("Please select a file.");
		return false;
	}

	const file = fileInput.files[0];
	const maxSize = 10 * 1024 * 1024; // 10 MB
	if (file.size > maxSize) {
		alert("File size exceeds the 10 MB limit.");
		return false;
	}

	const formData = new FormData();
	formData.append("id_chorus", idChorus);
	formData.append("id_opus", idOpus);
	formData.append("id_pagina", idPagina);
	formData.append("id_nauta", idUser);
	formData.append("actionAJAX", action);
	formData.append("uploadFile", file);

	$.ajax({
		type: "POST",
		url: "Pagina.ashx",
		data: formData,
		processData: false,
		contentType: false,
		success: function (response) {
			//alert("Upload successful: " + response);
			console.log("Sending to render: ", file);
			renderUploadedFile(response, idChorus, idOpus, idPagina, idUser);
			console.log("Returning from render: ", file);
			fileInput.value = ""; // Clear file input
		},
		error: function () {
			alert("Error during upload");
		}
	});

	return false;
}

