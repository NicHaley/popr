$(document).on('ready page:load', function() {

	var chart = c3.generate({
		data: {
			columns: [
			['Action & Adventure', 3],
			['Animation', 5],
			['Art House & International', 2],
			['Classics', 1],
			['Comedy', 13],
			['Drama'],
			['Horror'],
			['Kids & Family'],
			['Mystery & Suspense'],
			['Romance'],
			['Science Fiction & Fantasy'],
			['Documentary'],
			['Musical & Performing Arts'],
			['Special Interest'],
			['Sports & Fitness'],
			['Television'],
			['Western']

			],
			type: 'pie'
		},
	});

});