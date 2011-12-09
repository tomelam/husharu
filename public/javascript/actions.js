YUI().use('node', function(Y) {

  var parentNode = Y.one('#ie-notsupported');
  Y.one('#ie-notsupported .close').on('click', function(e) {
    parentNode.hide();
  });
});
