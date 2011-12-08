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

  // Find if there is a user with this email, else insert the user
  db.view('all/userByEmail', {key: email}, function(err, res) {
    if (err)  return promise.fail(err);
    if (res.length === 0) {
      db.save({
        level : 'user',
        source: source,
        profile: profile_link,
        email: email,
        first_name: first_name,
        last_name: last_name,
        display_name: display_name
      }, function(err, doc) {
        if (err) return promise.fail(err);
        promise.fulfill(doc);
      });
    } else {
      promise.fulfill(res);
    }
  });


  return promise;
}

everyauth
  .facebook
    .appId(conf.fb.appId)
    .appSecret(conf.fb.appSecret)
    .scope("email")
    .findOrCreateUser(function (session, accessToken, accessTokenExtra, fbUserMetadata) {
      return addUser('facebook', fbUserMetadata, this.Promise());
    })
    .redirectPath('/');
