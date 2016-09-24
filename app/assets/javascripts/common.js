function loadPageBody($container, url, data) {
  try {
    var dataseri = $('form').serialize();
    if(data == undefined)
      data = dataseri;
    $container.html("<img src='loading.gif' />");
    var dfd = $.Deferred();
    $container.load(url, data, function (response, status, xhr) {
      if (status == 'error') {
        var msg = I18n.t("status.errors") + xhr.status + " " + xhr.statusText;
        $container.html(msg);
      }
      $('.grid-word ul.pagination li.prev,.grid-word ul.pagination li.next').css("display","none");
      return dfd.resolve();
    });
    return dfd.promise();
  } catch (e) {
    $container.html(e.message);
  }
}

function openDialogView(stitle, urlpageLoad, data, size) {
  try {
    var $container = $('<div></div>');
    loadPage($container, urlpageLoad, data).done(function () {
      var $dialog = BootstrapDialog.show({
        title: stitle,
        onshown: function (dialogRef) {
        },
        message: $container,
        closable: true,
        closeByBackdrop: false,
        draggable: true,
        buttons: [
        {
          label: I18n.t("exit"),
          action: function (dialogRef) {
            dialogRef.close();
          }
        }],
      });
      if (size == 'NORMAL')
        $dialog.setSize(BootstrapDialog.SIZE_NORMAL);
      else if (size == 'SMALL')
        $dialog.setSize(BootstrapDialog.SIZE_SMALL);
      else if (size == 'LARGE')
        $dialog.setSize(BootstrapDialog.SIZE_LARGE);
      else if (size == 'FULL')
        $dialog.setSize(BootstrapDialog.SIZE_FULL);
      else
        $dialog.setSize(BootstrapDialog.SIZE_WIDE);
      console.log(size)
      $dialog.open();
    })
  } catch (e) {}
}

function openDialog(iTitle, urlPageLoad, data, size, buttonName) {
  try {
    var $container = $('<div></div>');
    loadPage($container, urlPageLoad, data).done(function () {
      var $dialog = BootstrapDialog.show({
        title: iTitle,
        onshown: function (dialogRef) {
        },
        message: $container,
        closable: true,
        closeByBackdrop: false,
        draggable: true,
        buttons: [{
          label: (buttonName != 'undefined' && buttonName != '' && buttonName != null) ?
            buttonName : I18n.t("save"),
          cssClass: 'btn-primary',
          hotkey: 13,
          action: function (dialogRef) {
              var $formPost = dialogRef.getModalBody().find('form');
              $formPost.data("dlgref", dialogRef);
              $formPost.submit();
          }
        },
        {
          label: I18n.t("exit"),
          action: function (dialogRef) {
            dialogRef.close();
          }
        }],
      });

      if (size == 'NORMAL')
        $dialog.setSize(BootstrapDialog.SIZE_NORMAL);
      else if (size == 'SMALL')
        $dialog.setSize(BootstrapDialog.SIZE_SMALL);
      else if (size == 'LARGE')
        $dialog.setSize(BootstrapDialog.SIZE_LARGE);
      else if (size == 'FULL') {
        $dialog.setSize(BootstrapDialog.SIZE_FULL);
      }
      else
        $dialog.setSize(BootstrapDialog.SIZE_WIDE);
      $dialog.open();
    })
  } catch (e) {}
}

function loadPage($container, url, data) {
  $container.html("<img src='loading.gif' />");
  var dfd = $.Deferred();
  $container.load(url, data, function (response, status, xhr) {
    if (status == 'error') {
      var msg = I18n.t('status.errors') + xhr.status + " " + xhr.statusText;
      $container.html(msg);
    }
    return dfd.resolve();
  });
  return dfd.promise();
}
