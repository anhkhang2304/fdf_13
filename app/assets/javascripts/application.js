// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require twitter/bootstrap
//= require turbolinks
//= require i18n
//= require i18n.js
//= require i18n/en
//= require_tree .
//= require bootstrap-datepicker
//= require jquery.raty
//= require ratyrate
//= require jquery.form-validator

$(document).on('ready page:load', function(){
  $.validate();

  var $tagNav = $('#nav-sider-left');
  $tagNav.navsider({ linkclick: true, cssClass: 'menu-bar', minHeight: 41 });

  $('button.act-add').click(function (event) {
    $this = $(this);
    var $box = $this.closest('.box.manager');
    var $table = $box.find('.portlet-body').first().find('.grid-data').first().find('table').first();
    openDialog($this.data('title'), $this.data('url'), $this.data('parameters'), $this.data('size'), '');
    event.stopPropagation();
  });
  $('.alert').fadeOut(4000);

  $('a.act-edit').click(function (event) {
    var $grid = $(this).closest("div.grid-data");
    var datapost = $grid.data("parameters");
    if (datapost == 'undefined') {
        datapost = {}
    }
    var title = (typeof ($grid.data("edit-title")) == 'undefined') ? $grid.data("edit-title") : I18n.t('update');
    var size = (typeof ($grid.data("edit-size")) == 'undefined') ? $grid.data("size") : $grid.data("edit-size");
    var dataFinish = { Id: $(this).data("id") };
    $.extend(dataFinish, datapost);
    openDialog($grid.data("title"), $(this).data("url"), "", size, title);
  });

  $('a.act-view').click(function (event) {
    var $grid = $(this).closest("div.grid-data");
    var datapost = $grid.data("parameters");
    var size = $(this).data("size");
    if (datapost == 'undefined') {
      datapost = {}
    }
    var dataFinish = {};
    $.extend(dataFinish, datapost);
    openDialogView(I18n.t('detail'), $(this).data('view'), datapost, size);
    event.stopPropagation();
  })

  $('#msg').fadeOut(8000);
});
