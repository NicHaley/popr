$(document).on('ready page:load', function() {
		
		//Insert no data message for empty charts

		if($('#chart4').is(':empty')) { 
			$("#chart4").append("<h4>No data available</h4>");
		}
		if($('#chart').is(':empty')) { 
			$("#chart").append("<h4>No data available</h4>");
		}
		if($('#chart2').is(':empty')) { 
			$("#chart2").append("<h4>No data available</h4>");
		}
		if($('#chart3').is(':empty')) { 
			$("#chart3").append("<h4>No data available</h4>");
		}

  $('#right-tab').on('click', function (event, tab) {
    $(document).foundation('orbit', 'reflow');
  });

});

