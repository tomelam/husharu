/**
 * Module dependencies.
 */

var express = require('express'),
    app = module.exports = express.createServer(),
    stylus = require('stylus'),
    everyauth = require('everyauth'),
    login = require('./login'),
    cradle = require('cradle'),
    db = new(cradle.Connection)().database('husharu_db');

function compile(str, path) {
  return stylus(str)
    .set('filename', path)
    .set('warn', true)
    .set('compress', true);
}

db.save('_design/comments', {
  views: {
    all: {
      map: function(doc) {
        if (doc.level && doc.level === 'comment') {
          emit(doc.level, doc);
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

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({ secret: 'htuayreve'}));
  app.use(everyauth.middleware());
  app.use(app.router);

  app.use(stylus.middleware({
      src: __dirname + '/views' // .styl files are located in `views/stylesheets`
    , dest: __dirname + '/public' // .styl resources are compiled `/stylesheets/*.css`
    , compile: compile
  }));
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

function renderHome(renderer, comments) {
  renderer.render('index', {
    title: 'Welcome',
    locals: {
      comments: comments
    }
  });
}

// Routes

app.get('/', function(req, renderer){
  var comments = [];
  db.view('comments/all', function (err, res) {
    if (err) {
      console.log(err);
      return;
    }
    var end = res.length - 1, i = 0;
    res.forEach(function (row) {
      row.display_date = (new Date(row.created_at*1000)).toDateString();
      db.get(row.product_id, function(err1, doc) {
        row.product_name = doc.display_name;
        comments.push(row);
        if (i === end) {
          renderHome(renderer, comments);
        } else {
          i++;
        }
      });
    });
  });
});

app.get('/login', function(req, res){
  res.render('login', {
    title: 'Login'
  });
});

app.get('/comment', function(req, renderer){
  var products = [];
  db.view('products/all', function (err, res) {
    if (err) {
      throw new Error('Unable to retrieve products');
    }
    res.forEach(function (row) {
      products.push(row);
    });
    renderer.render('comment', {
      title: 'Comment page',
      locals: {
        products: products 
      }
    });
  });
});

app.get('/comment/:id', function(req, renderer) {
  var id = req.params.id;
  db.get(id, function(err, doc) {
    if (err) {
      console.log('no such document');
      return;
    }
    renderer.render('comment_detail', {
      title: 'Comment page',
      locals: {
        comment: doc 
      }
    });
  });
});

app.post('/comment/save', function(req, renderer) {
  if ( !req.body.product || !req.body.comment ) {
    throw new Error('Both product and comment are needed');
  }

  db.save({
    "level": "comment",
    "product_id": req.body.product,
    "created_at": (new Date()).getTime(),
    "posted_by": "",
    "comment": req.body.comment
  }, function(err, res) {
    renderer.redirect('/', 301);
  });
});

everyauth.helpExpress(app);

app.listen(process.env['app_port'] || 3000);
console.info("Started on port %d", app.address().port);
