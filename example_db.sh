#!/bin/sh

# If the database exists, delete it
curl -X DELETE http://127.0.0.1:5984/husharu_db

# Create database
curl -X PUT http://127.0.0.1:5984/husharu_db

# Create a product and grab the document id
sobha=`curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Sobha Forest View"}' | grep -Po '"id":.*?",' | perl -pe 's/"id"://; s/^"//; s/",$//'`
#sobha=`curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Sobha Forest View"}' | python -c 'import json, sys; data = json.loads(sys.stdin.read()); print data["id"]'`

# Create a comment document
curl -X POST http://127.0.0.1:5984/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$sobha\", \"posted_by\": \"Shady Joe\", \"created_at\": \"1322550106\", \"comment\": \"This project is yet to start.\" }"

# create another comment
curl -X POST http://127.0.0.1:5984/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$sobha\", \"posted_by\": \"Shady Joe\", \"created_at\": \"1322551106\", \"comment\": \"This is another comment about Sobha forest view.\" }"

bsnl=`curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "BSNL Landline"}' | grep -Po '"id":.*?",' | perl -pe 's/"id"://; s/^"//; s/",$//'`
curl -X POST http://127.0.0.1:5984/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$bsnl\", \"posted_by\": \"Shady Joe\", \"created_at\": \"1322531106\", \"comment\": \"Do the BSNL guys actually repair anything?\" }"
curl -X POST http://127.0.0.1:5984/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$bsnl\", \"posted_by\": \"Shady Joe\", \"created_at\": \"1312531106\", \"comment\": \"BSNL guys fixed my modem yesterday.  It is not working again!\" }"

# create some products
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "HP Gas"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "TataSky"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Toyota Innova"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Toyota Etios"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Sobha Onyx"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Sobha Magnolia"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Mahaveer Marvel"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Prestige Shantiniketan"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Prestige Meadows"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Adarsh Palm Meadows"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Airtel broadband"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Aircel"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Reliance mobile"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Spice"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Airtel mobile"}'
curl -X POST http://127.0.0.1:5984/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Jet Airways"}'
