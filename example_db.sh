#!/bin/sh

# If the database exists, delete it
curl -X DELETE http://127.0.0.1:5984/husharu_db

# Create database
curl -X PUT http://127.0.0.1:5984/husharu_db

# Create a product and grab the document id
iddd=`curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Sobha Forest View"}' | grep -Po '"id":.*?",' | perl -pe 's/"id"://; s/^"//; s/",$//'`
#iddd=`curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Sobha Forest View"}' | python -c 'import json, sys; data = json.loads(sys.stdin.read()); print data["id"]'`

# Create a comment document
curl -X POST http://127.0.0.1:5984/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$iddd\", \"posted_by\": \"Shady Joe\", \"created_at\": \"1322550106\", \"comment\": \"This project is yet to start.\" }"
