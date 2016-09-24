//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require twitter/bootstrap
//= require turbolinks
//= require i18n
//= require i18n.js
//= require i18n/en
//= require bootstrap-datepicker
//= require jquery.raty
//= require ratyrate
//= require common.js
//= require admin/bootstrap-dialog.js

$(document).on('ready page:load', function(){
  $('.btn-add-cart').click(function(){
    var dataurl = $(this).data('url');
    var product_id = $(this).data('id');
    $.ajax({
      url: dataurl,
      data: {"detail_order[quantity]": 1, "detail_order[product_id]": product_id},
      method: "POST"
    }).done(function(data) {
      if(data.msg == "login"){
        openDialogMsg("warning!","Please login! <a href="+data.url+">Login?</a>");
      }
    });
  });

  $('.btn-add-product').click(function(){
    var dataurl = $(this).data('url');
    var product_id = $(this).data('id');
    var order = $(this).data('order');
    var quantity = parseInt($('#quantity-'+product_id).text());
    $.ajax({
      url: dataurl,
      data: {
        "detail_order[quantity]": 1,
        "product_id": product_id,
        "order_id": order,
        "type_edit_product": "add"
      },
      method: "PUT"
    }).done(function(data) {
      if(data.msg == "add"){
        $('#quantity-'+product_id).text(quantity+1);
        $('.total-'+product_id).text(parseFloat(data.price)*(quantity+1));
      }
    });
  });

  $('.btn-sub-product').click(function(){
    var dataurl = $(this).data('url');
    var product_id = $(this).data('id');
    var order = $(this).data('order');
    var quantity = parseInt($('#quantity-'+product_id).text());
    $.ajax({
      url: dataurl,
      data: {
        "detail_order[quantity]": 1,
        "product_id": product_id,
        "order_id": order,
        "type_edit_product": "sub"
      },
      method: "PUT"
    }).done(function(data) {
      if(data.msg == "sub"){
        $('#quantity-'+product_id).text(quantity-1);
        $('.total-'+product_id).text(parseFloat(data.price)*(quantity-1));
      }
    });
  });

  $('.del-product-order').click(function(){
    var product_id = $(this).data('product');
    var order_id = $(this).data('order');
    var url_del = $(this).data('url');
    var answer = confirm ("You are sure?")
    if (answer){
      $.ajax({
        url: url_del,
        data: {product_id: product_id, order_id: order_id},
        method: "DELETE"
      }).done(function(data) {
        $('.tr-'+product_id).remove();
      });
    }
  });

  $('.alert-client').fadeOut(4000);

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

function openDialogMsg(stitle, sMsg) {
  BootstrapDialog.show({
    title: stitle,
    message: sMsg,
    closable: true,
    draggable: true,
    buttons: [
    {
      label: I18n.t("exit"),
      action: function (dialogRef) {
        dialogRef.close();
      }
    }]
  });
}
