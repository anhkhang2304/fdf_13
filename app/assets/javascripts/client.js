//= require jquery
//= require bootstrap
//= require twitter/bootstrap
//= require turbolinks
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require bootstrap-datepicker

$(document).on('ready page:load', function(){
  $('.btn-add-cart').click(function(){
    var dataurl = $(this).data('url');
    var product_id = $(this).data('id');
    console.log($(this).data('url'));
    $.ajax({
        url: dataurl,
        data: {"detail_order[quantity]": 1, "detail_order[product_id]": product_id},
        method: "POST"
      }).done(function(data) {
        $(this).addClass( "done" );
      });
  });
});
