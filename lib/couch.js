var cradle = require('cradle'),
    db_user = process.env['husharu_db_user'] || 'admin',
    db_pass = process.env['husharu_db_pass'] || 'admin',
    db_host = process.env['husharu_db_host'] || '127.0.0.1',
    db_port = process.env['husharu_db_port'] || 5984,
    db = new(cradle.Connection)(db_host, db_port, {
      auth: { username: db_user, password: db_pass }
    }).database('husharu_db');

exports.db = db;

db.save('_design/all', {
  views: {
      comments_products: {
        map: function(doc) {
          if (doc.level && (doc.level === 'comment' || doc.level === 'product')) {
            emit(doc.level, doc);
          }   
        }
      }
    , comments_for_product: {
      map: function(doc) {
        if (doc.level && doc.level === 'comment' && doc.product_id) {
          emit(doc.product_id, doc);
        }   
      }
    }
    , comments: {
      map: function(doc) {
        if (doc.level && doc.level === 'comment') {
          emit(doc.level, doc);
        }   
      }
    }
    , products: {
      map: function(doc) {
        if (doc.level && doc.level === 'product') {
          emit(doc.level, doc);
        }   
      }
    }
    , users: {
      map: function(doc) {
        if (doc.level && doc.level === 'user') {
          emit(doc.level, doc)
        }
      }
    }
    , userByEmail: {
      map: function(doc) {
        if (doc.level && doc.level === 'user') {
          emit(doc.email, doc)
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
