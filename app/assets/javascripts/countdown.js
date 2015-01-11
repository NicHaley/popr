$(document).ready(function() {
	$('.countdown').text('140 characters remaining.');
	$('.message').change(updateCountdown);
	$('.message').keyup(updateCountdown);

	$('.countdown-description').text('140 characters remaining.');
	$('.message-description').change(updateCountdownDesc);
	$('.message-description').keyup(updateCountdownDesc);

	$('.countdown-title').text('40 characters remaining.');
	$('.message-title').change(updateCountdownTitle);
	$('.message-title').keyup(updateCountdownTitle);
});

function updateCountdown() {
  // 140 is the max message length
  var remaining = 140 - $('.message').val().length;
  $('.countdown').text(remaining + ' characters remaining.');
}

function updateCountdownDesc() {
  // 140 is the max message length
  var remaining = 140 - $('.message-description').val().length;
  $('.countdown-description').text(remaining + ' characters remaining.');
}

function updateCountdownTitle() {
  // 140 is the max message length
  var remaining = 40 - $('.message-title').val().length;
  $('.countdown-title').text(remaining + ' characters remaining.');
}