document.addEventListener('DOMContentLoaded', function() {
	const getCellValue = (row, index) => row.children[index].textContent.trim();
    
	const comparer = (index, asc) => (a, b) => ((v1, v2) =>
	v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2) ? v1 - v2 : v1.toString().localeCompare(v2)
	)(getCellValue(asc ? a : b, index), getCellValue(asc ? b : a, index));

	const table = document.querySelector('#sortableTable');
	const headers = table.querySelectorAll('th');
	headers.forEach((header, index) => {
		if (index < 4) { // Only add sorting to the first four columns
		header.addEventListener('click', () => {
			const currentIsAscending = header.classList.contains('sorted-asc');
			table.querySelectorAll('th').forEach(th => th.classList.remove('sorted-asc', 'sorted-desc'));
			header.classList.toggle('sorted-asc', !currentIsAscending);
			header.classList.toggle('sorted-desc', currentIsAscending);
			Array.from(table.querySelector('tbody').rows)
				.sort(comparer(index, !currentIsAscending))
				.forEach(row => table.querySelector('tbody').appendChild(row));
		});
		}
	});
});
