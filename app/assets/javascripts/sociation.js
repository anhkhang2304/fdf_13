//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require twitter/bootstrap
//= require turbolinks
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require bootstrap-datepicker
//= require jquery.raty
//= require ratyrate


(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.7";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

$(document).ready(function() {
  $('.go-top').click(function(event) {
    event.preventDefault();
    $('html, body').animate({scrollTop: 0}, '600');
  })
});
