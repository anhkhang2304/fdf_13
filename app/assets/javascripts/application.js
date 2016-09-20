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
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require bootstrap
//= require bootstrap-datepicker

$(document).on('ready page:load', function(){
  var $tagNav = $('#nav-sider-left');
  $tagNav.navsider({ linkclick: true, cssClass: 'menu-bar', minHeight: 41 });

  $('button.act-add').click(function (event) {
    $this = $(this);
    var $box = $this.closest('.box.manager');
    var $table = $box.find('.portlet-body').first().find('.grid-data').first().find('table').first();
    openDialog($this.data('title'), $this.data('url'), $this.data('parameters'), $this.data('size'), '');
    console.log($this.data('url'));
    event.stopPropagation();
  });
  $('.alert').fadeOut(4000);
});
