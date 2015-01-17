$(document).on('ready', function(){

	$('#footer-button').on("click", function(e){
		e.stopPropagation();
		$('#footer-button').toggleClass("active");
		$('#info-box').toggleClass("active");
	});

	$('body').on("click", function(){
		$('#footer-button').removeClass("active");
		$('#info-box').removeClass("active");
	});
});