/*! Copyright (c) 2015 Ngo Anh Khang
 * Version: 1.0
 */
(function ($) {
  $.fn.extend({
    navsider: function (options) {
      var defaults = {
        expand: false,
        cssClass: '',
        minHeight:0,
        expandClass: 'fa-angle-down',
        collapseClass: 'fa-angle-right',
        overwrite: true,
        linkclick:false
      }
      var o = $.extend(defaults, options);
      this.each(function () {
        var $meTag = $(this);
        $meTag.addClass('csnav-side')
        $meTag.addClass(o.cssClass);
        $meTag.find('li > a').click(function (event) {
          if ($(this).data('url') != "#" && $(this).data('url') != '')
          {
            $('.nav-active').removeClass('nav-active');
            $(this).addClass('nav-active');
          }
          if(o.linkclick)
          {
            var $tagI = $(this).next('i');
            if ($tagI.length > 0) {
              $tagI.trigger('click');
            }
          }
        });
        if (o.overwrite == true) {
          $meTag.find('i.' + o.collapseClass).remove();
        }
        $meTag.parent().addClass('removecollapse');
        appendExpand($meTag);
        $meTag.parent().removeClass('removecollapse');
        if (o.expand == false)
          $meTag.find('ul').hide();
      });
      function appendExpand($meTag) {
        var $taglis = $meTag.find('> li');
        $taglis.each(function () {
          var $liTag = $(this);
          var $ulTag = $liTag.find('> ul');
          if ($ulTag.length > 0) {
            if ($liTag.find('> .' + o.collapseClass).length == 0) {
              var $spanTag = $("<i class='arrow fa'></i>");
              if (o.expand == true)
                $spanTag.addClass(o.expandClass);
              else
                $spanTag.addClass(o.collapseClass);
              var $aTag = $liTag.find('> a');
              $spanTag.css('line-height', ($aTag.outerHeight() == 0 ? o.minHeight : $aTag.outerHeight()) + 'px');
              $aTag.after($spanTag);
            }
            appendExpand($ulTag);
          }
        });
      }

      $(document).on('click', '.' + o.collapseClass, function (event) {
        $(this).closest('li').find('> ul').slideDown(150);
        $(this).attr('class', 'arrow-open fa ' + o.expandClass);
      });
      $(document).on('click', '.' + o.expandClass, function (event) {
        $(this).closest('li').find('> ul').slideUp(150);
        $(this).attr('class', 'arrow fa ' + o.collapseClass);
      });
      return this;
    }
  });
  $.fn.extend({
    navsider: $.fn.navsider
  });
})(jQuery);
