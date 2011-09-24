
/**
 * Module dependencies.
 */

require.paths.push('/usr/local/lib/node_modules');
var express = require('express'),
    app = module.exports = express.createServer(),
   everyauth = require('everyauth'),
   login = require('./login');

everyauth.debug = true;
// Configuration




app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({ secret: 'htuayreve'}));
  app.use(everyauth.middleware());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

// Routes

app.get('/', function(req, res){
    res.render('home', {
      title: 'Login'
    });
});

app.get('/comment', function(req, res){
  res.render('comment', {
      title: 'Comment page'
  });
});


client.on("error", function (err) {
    console.log("Error " + err);
});

everyauth.debug = true;

everyauth.helpExpress(app);

app.listen(process.env['app_port'] || 3000);
