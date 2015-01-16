$(document).on('ready page:load', function() {

  if (navigator.userAgent.toLowerCase().indexOf('chrome') >= 0) {
    setTimeout(function () {
        document.getElementById('search').autocomplete = 'off';
    }, 1);
  }
});