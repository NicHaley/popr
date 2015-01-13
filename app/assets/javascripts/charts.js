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

	//Fix Wishlist loading

  $('#right-tab').on('click', function (event, tab) {
    $(document).foundation('orbit', 'reflow');
  });
  //Chart toggle
  (function($){
  	$(document).ready(function(){
	  	$('#graph-toggle').on('click', function(eventObject){
	  		eventObject.preventDefault();
	  		$(this).toggleClass('active');
	  		$('.chart').removeClass('active');
	  		$('.graph-btn').toggleClass('active');
	  	});
	  	$('.graph-btn').hover(function(eventObject){
	  		$(this).toggleClass('hover');
	  	});
	  	$('.btn1').on('click', function(eventObject){
	  		$('.chart').removeClass('active');
	  		$('#chart1-box').toggleClass('active');
	  	});
	  	$('.btn2').on('click', function(eventObject){
	  		$('.chart').removeClass('active');
	  		$('#chart2-box').toggleClass('active');
	  	});
	  	$('.btn3').on('click', function(eventObject){
	  		$('.chart').removeClass('active');
	  		$('#chart3-box').toggleClass('active');
	  	});
	  	$('.btn4').on('click', function(eventObject){
	  		$('.chart').removeClass('active');
	  		$('#chart4-box').toggleClass('active');
	  	});
	  	$('.btn1').hover(function(eventObject){
	  		$('.graph-label1').toggleClass('active');
	  	});
	  	$('.btn2').hover(function(eventObject){
	  		$('.graph-label2').toggleClass('active');
	  	});
	  	$('.btn3').hover(function(eventObject){
	  		$('.graph-label3').toggleClass('active');
	  	});
	  	$('.btn4').hover(function(eventObject){
	  		$('.graph-label4').toggleClass('active');
	  	});
  	});
  })(jQuery);

});

