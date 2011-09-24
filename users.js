var usermodel = {
    addUser : function(client, userdata, callback) {
        id = userdata.id;
        hashkey = "user" + ":" + id;
        email = userdata.email;
        first_name = userdata.first_name;
        last_name = userdata.last_name;
        exists = client.hgetall(hashkey, function(err, obj){
            if(obj.length > 0){
                callback(err,obj);
                return ;
            }
            client.hmset(hashkey,
                     {
                         "email": email,
                         "first_name": first_name,
                         "last_name": last_name,
                     }
            );
            client.hgetall(hashkey, function(err, obj){
                     callback(err,obj);
            });

        });
    }
}

exports.usermodel = usermodel;

