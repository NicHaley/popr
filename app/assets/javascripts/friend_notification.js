(function($){
  	$(document).ready(function(){
	  	$('#friend-container, .notification-tab').hover(function(eventObject){
	  		eventObject.preventDefault();
	  		$('.notification-tab').toggleClass('active');
	  	});
  	});
  })(jQuery);