#!/bin/sh

db_user=$husharu_db_user
db_pass=$husharu_db_pass
db_host=$husharu_db_host
db_port=$husharu_db_port

# If the database exists, delete it
curl -X DELETE http://$db_user:$db_pass@$db_host:$db_port/husharu_db

# Create database
curl -X PUT http://$db_user:$db_pass@$db_host:$db_port/husharu_db

# Create a product and grab the document id
sobha=`curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Sobha Forest View"}' | grep -Po '"id":.*?",' | perl -pe 's/"id"://; s/^"//; s/",$//'`
#sobha=`curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Sobha Forest View"}' | python -c 'import json, sys; data = json.loads(sys.stdin.read()); print data["id"]'`

# Create a comment document
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$sobha\", \"posted_by\": \"avenger_ppc4@yahoo.com\", \"created_at\": \"1322550106000\", \"comment\": \"This project is yet to start.\" }"

# create another comment
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$sobha\", \"posted_by\": \"invalid@example.com\", \"created_at\": \"1322551106000\", \"comment\": \"This is another comment about Sobha forest view.\" }"

bsnl=`curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "BSNL"}' | grep -Po '"id":.*?",' | perl -pe 's/"id"://; s/^"//; s/",$//'`
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$bsnl\", \"posted_by\": \"invalid@example.com\", \"created_at\": \"1322531106000\", \"comment\": \"Do the BSNL guys actually repair anything?\" }"
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$bsnl\", \"posted_by\": \"invalid@example.com\", \"created_at\": \"1322537306000\", \"comment\": \"BSNL guys fixed my modem yesterday.  It is not working again!\" }"

# create some products
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "HP Gas"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "TataSky"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Toyota Innova"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Toyota Etios"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Sobha Onyx"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Sobha Magnolia"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Mahaveer Marvel"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Prestige Shantiniketan"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Prestige Meadows"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Adarsh Palm Meadows"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Airtel broadband"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Aircel"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Reliance mobile"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Spice"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Airtel mobile"}'
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "product", "display_name": "Jet Airways"}'
