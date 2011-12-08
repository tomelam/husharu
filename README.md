Husharu
=======

*Husharu* is a nodejs website for people to comment about the products they use
in everyday life.

To get started,

* Install couchdb

* Create an admin user for couchdb.  Go to your [couchdb instance](http://localhost:5984/_utils)
and create an admin user (bottom right).

* Create some dummy entries

        $ sh example_db.sh

* Install the required packages

        $ npm install

* Start node

        $ node app.js

husharu was an attempt to learn nodejs, express, jade, stylus and couchdb
during jsFoo hacknight (http://jsfoo.hasgeek.com/hacknight).
