var usermodel = {
    addUser : function(client, userdata) {
        id = userdata.id;
        hashkey = "user" + id;
        if(client.hgetall(hashkey))
            return;

        hashkey = "user" + id;
        email = userdata.email;
        first_name = userdata.first_name;
        last_name = userdata.last_name;

        client.hmset(hashkey,
                     {
                         "email": email,
                         "first_name": first_name,
                         "last_name": last_name,
                     }
         );
    }
}

exports.usermodel = usermodel;

