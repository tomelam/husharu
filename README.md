Husharu
=======

A nodejs website for people to comment about the products they use
in everyday life.
  
To get started,

* Install couchdb and create a database husharu_db
    $ curl -X PUT http://127.0.0.1:5984/husharu_db

* Create a product 
    $ curl -X POST http://127.0.0.1:5984/husharu_db -H 'Content-type: application/json' -d '{"level": "product", "display_name": "Sobha Forest View"}'
    {"ok":true,"id":"922879ab193520a01301ef4bc4003328","rev":"1-387df07419018797c0328be0d3ba93ad"}
    $

* Use the previous id and create a comment
    $ curl -X POST http://127.0.0.1:5984/husharu_db -H 'Content-type: application/json' -d '{"level": "comment", "parent_id": "", "product_id": "922879ab193520a01301ef4bc4003328", "posted_by": "Shady Joe", "created_by": "1322550106", "comment": "This project is yet to start." }'
    {"ok":true,"id":"922879ab193520a01301ef4bc4003c2b","rev":"1-fd424f24118eb53678e4f6de9498534d"}
    $

* Install the required packages
    $ npm install

* Start node   
    $ node app.js

husharu was an attempt to learn nodejs, express, jade, stylus and redit
during jsFoo hacknight (http://jsfoo.hasgeek.com/hacknight).
