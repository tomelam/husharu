var app = require('./app').app,
    db = require('./couch').db,
    conf = require('./conf'),
    everyauth = require('everyauth');

function addUser(source, user, promise) {
  var profile_link = user.link || '',
      email = user.email || '',
      first_name = user.first_name || '',
      last_name = user.last_name || '',
      display_name = user.name || '';

  db.save({
    level : 'user',
    source: source,
    profile: profile_link,
    email: email,
    first_name: first_name,
    last_name: last_name,
    display_name: display_name
  }, function(err, res) {
    if (err) return promise.fail(err);
    promise.fulfill(res);
  });

  return promise;
}

everyauth.debug = true;
everyauth
  .facebook
    .appId(conf.fb.appId)
    .appSecret(conf.fb.appSecret)
    .scope("email")
    .findOrCreateUser(function (session, accessToken, accessTokenExtra, fbUserMetadata) {
      console.log(fbUserMetadata);
      return addUser('facebook', fbUserMetadata, this.Promise());
    })
    .redirectPath('/');
