var everyauth = require('everyauth'),
    conf = require('./conf');
    redis = require("redis"),
    client = redis.createClient(),
    user = require('./users');

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

everyauth.debug = true;

