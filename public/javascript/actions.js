YUI().use('node', function(Y) {
  var node = Y.one('#ie-notsupported');
  if (node) {
    Y.one('#ie-notsupported .close').on('click', function(e) {
      node.hide();
    });
  }
});
