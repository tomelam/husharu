var cradle = require('cradle'),
    db = new(cradle.Connection)().database('husharu_db');

exports.db = db;

db.save('_design/all', {
  views: {
    comments_products: {
      map: function(doc) {
        if (doc.level && (doc.level === 'comment' || doc.level === 'product')) {
          emit(doc.level, doc);
        }   
      }
    },
    comments_for_product: {
      map: function(doc) {
        if (doc.level && doc.level === 'comment' && doc.product_id) {
          emit(doc.product_id, doc);
        }   
      }
    }
  }
});

db.save('_design/products', {
  views: {
    all: {
      map: function(doc) {
        if (doc.level && doc.level === 'product') {
          emit(doc.level, doc);
        }   
      }
    }
  }
});
