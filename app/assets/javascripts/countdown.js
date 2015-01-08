$(document).ready(function($) {
	$('.countdown').text('150 characters remaining.')
	$('.message').change(updateCountdown);
	$('.message').keyup(updateCountdown);
});

function updateCountdown() {
  // 140 is the max message length
  var remaining = 150 - $('.message').val().length;
  $('.countdown').text(remaining + ' characters remaining.');
}