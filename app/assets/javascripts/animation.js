
//Search button

(function($){

	$(document).ready(function (){
	
		$('#search-field').click(function() {
			$(this).addClass("active");
       		$(this).attr('placeholder','Search by location...');
			$('#submit-button').addClass("show");
		});
	
	});

})(window.jQuery);


