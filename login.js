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
        var promise = this.Promise();
        user.usermodel.addUser(client, fbUserMetadata, function (err, user) {
            if (err) return promise.fail(err);
            console.dir(user);
            promise.fulfill(user);
        });
        return promise;
    })
    .redirectPath('/');


client.on("error", function (err) {
    console.log("Error " + err);
});

everyauth.debug = true;

