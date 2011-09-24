
/**
 * Module dependencies.
 */

require.paths.push('/usr/local/lib/node_modules');
var express = require('express'),
    everyauth = require('everyauth'),
    conf = require('./conf'),
    redis = require("redis"),
    client = redis.createClient(),
    user = require('./users'),
    app = module.exports = express.createServer();

everyauth.debug = true;
// Configuration



everyauth
  .facebook
    .appId(conf.fb.appId)
    .appSecret(conf.fb.appSecret)
    .scope("email")
    .findOrCreateUser( function (session, accessToken, accessTokenExtra, fbUserMetadata) {

        user.usermodel.addUser(client, fbUserMetadata);
        return true;
    })
    .redirectPath('/');


client.on("error", function (err) {
    console.log("Error " + err);
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

everyauth.helpExpress(app);

app.listen(process.env['app_port'] || 3000);
