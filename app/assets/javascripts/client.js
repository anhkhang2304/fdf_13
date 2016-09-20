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

$(function(){
  $('.comment-button').click(function(event){
    $(this).hide();
    $('.comment-button').show();
  });

  $('.comment-button').click(function (e){
    e.preventDefault();
    var theCom = $('.comment-box');
    var rate = $('.rating .star').attr('data-rating');
    if( !theCom.val() ){
      alert(I18n.t('error_comment'));
    } else {
      $.ajax({
        method: 'POST',
        url: $('#comment_dataurl').val(),
        data: $('#new_comment').serialize(),
        success: function(data){
          $('#list-comment').prepend(data);
          $('.comment-box').val('');
        }
      });
    }
  });
});
