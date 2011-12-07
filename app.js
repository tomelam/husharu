var express = require('express'),
    stylus = require('stylus'),
    everyauth = require('everyauth'),
    login = require('./login'),
    routes = require('./routes'),
    couch = require('./routes');


function compile(str, path) {
  return stylus(str)
    .set('filename', path)
    .set('warn', true)
    .set('compress', true);
}


var app = module.exports = express.createServer();

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({ secret: 'htuayreve'}));
  app.use(app.router);
  app.use(everyauth.middleware());

  app.use(stylus.middleware({
      src: __dirname + '/views' // .styl files are located in `views/stylesheets`
    , dest: __dirname + '/public' // .styl resources are compiled `/stylesheets/*.css`
    , compile: compile
  }));
  app.use(express.static(__dirname + '/public'));
  everyauth.helpExpress(app);
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});


app.listen(process.env['app_port'] || 3000);
console.info("Started on port %d", app.address().port);
