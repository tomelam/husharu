#!/bin/sh

db_user=$husharu_db_user
db_pass=$husharu_db_pass
db_host=$husharu_db_host
db_port=$husharu_db_port

# If the database exists, delete it
curl -X DELETE http://$db_user:$db_pass@$db_host:$db_port/husharu_db

# Create database
curl -X PUT http://$db_user:$db_pass@$db_host:$db_port/husharu_db

# create some categories
realestate=`curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "category", "display_name": "Real Estate"}' | grep -Po '"id":.*?",' | perl -pe 's/"id"://; s/^"//; s/",$//'`

communication=`curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "category", "display_name": "Communication"}' | grep -Po '"id":.*?",' | perl -pe 's/"id"://; s/^"//; s/",$//'`

auto=`curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d '{"level": "category", "display_name": "Auto"}' | grep -Po '"id":.*?",' | perl -pe 's/"id"://; s/^"//; s/",$//'`

# Create a product and grab the document id
sobha=`curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Sobha Forest View\", \"url\": \"http://www.sobhadevelopers.com/projects/forest-view/index.html\", \"image\": \"http://www.sobhadevelopers.com/projects/forest-view/images/forest-view_elevation.jpg\", \"category\": \"$realestate\"}" | grep -Po '"id":.*?",' | perl -pe 's/"id"://; s/^"//; s/",$//'`

# Create a comment
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$sobha\", \"posted_by\": \"avenger_ppc4@yahoo.com\", \"created_at\": \"1322550106000\", \"comment\": \"This project is yet to start.\" }"

# create another comment
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$sobha\", \"posted_by\": \"invalid@example.com\", \"created_at\": \"1322551106000\", \"comment\": \"This is another comment about Sobha forest view.\" }"

bsnl=`curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"BSNL\", \"url\": \"http://www.bsnl.co.in/\", \"image\": \"http://www.topnews.in/files/BSNL_6.jpg\", \"category\": \"$communication\"}" | grep -Po '"id":.*?",' | perl -pe 's/"id"://; s/^"//; s/",$//'`

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$bsnl\", \"posted_by\": \"invalid@example.com\", \"created_at\": \"1322531106000\", \"comment\": \"Do the BSNL guys actually repair anything?\" }"
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H 'Content-type: application/json' -d "{\"level\": \"comment\", \"parent_id\": \"\", \"product_id\": \"$bsnl\", \"posted_by\": \"invalid@example.com\", \"created_at\": \"1322537306000\", \"comment\": \"BSNL guys fixed my modem yesterday.  It is not working again!\" }"

# create some products
curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"TataSky\", \"url\": \"http://www.tatasky.com/\", \"image\": \"http://www.tatasky.com/images/tata-sky-logo.gif\", \"category\": \"$communication\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Toyota Innova\", \"url\": \"http://www.toyotabharat.com/cars/new_cars/in_innova/index.aspx\", \"image\": \"http://images.cardekho.com/images/car-images/large/Toyota/Innova/Innova-6.jpg\", \"category\": \"$auto\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Toyota Etios\", \"url\": \"http://toyotaetios.in/\", \"image\": \"http://images.cardekho.com/car-images/carexteriorimages/large/Toyota/Toyota-Etios/toyota-etios-exterior-047.jpg\", \"category\": \"$auto\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Sobha Onyx\", \"url\": \"http://www.sobhadevelopers.com/projects/onyx/\", \"image\": \"http://www.sobhadevelopers.com/projects/onyx/images/onyx.jpg\", \"category\": \"$realestate\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Sobha Magnolia\", \"url\": \"http://www.sobhadevelopers.com/projects/magnolia/\", \"image\": \"http://www.sobhadevelopers.com/projects/magnolia/images/magnolia.jpg\", \"category\": \"$realestate\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Mahaveer Marvel\", \"url\": \"http://www.mahaveergroup.in/projects_info.aspx?pg=prj&plnk=inf&cid=33&scid=11\", \"image\": \"http://www.mahaveergroup.in/upload/projectmaster/zoom/11/Marvel.jpg\", \"category\": \"$realestate\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Prestige Shantiniketan\", \"url\": \"http://www.prestigeconstructions.com/shantiniketan-residential/overview.html\", \"image\": \"http://www.prestigeconstructions.com/shantiniketan-residential/images/photo-gall-20-large.jpg\", \"category\": \"$realestate\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Prestige White Meadows\", \"url\": \"http://www.prestigeconstructions.com/white-meadows/overview.html\", \"image\": \"http://www.deccanherald.com/images/editor_images/Feb%202010/4%20Feb%202010/white-medows.jpg\", \"category\": \"$realestate\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Adarsh Palm Meadows\", \"url\": \"http://www.adarshdevelopers.com/PalmMeadows/PalmMeadows_Home.aspx\", \"image\": \"http://www.hdfcred.com/project-images1/774/774_Adarsh_Palm_Meadows.jpg\", \"category\": \"$realestate\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Airtel Broadband\", \"url\": \"http://www.airtelbroadband.in/\", \"image\": \"http://mobigyaan.com/images/stories/Airtel/airtel-new-logo.jpg\", \"category\": \"$communication\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Aircel\", \"url\": \"http://www.aircel.com\", \"image\": \"http://stockwatch.in/files/Aircel-Moves-Court.jpg\", \"category\": \"$communication\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Reliance Mobile\", \"url\": \"http://www.rcom.co.in\", \"image\": \"http://www.rcom.co.in/Rcom/personal/images/R-Logo.png\", \"category\": \"$communication\"}"

curl -X POST http://$db_user:$db_pass@$db_host:$db_port/husharu_db -H "Content-type: application/json" -d "{\"level\": \"product\", \"display_name\": \"Spice Mobile\", \"url\": \"http://www.spiceglobal.com/SpiceMobiles/SpiceMobiles.aspx\", \"image\": \"http://www.spiceglobal.com/images/logo.png\", \"category\": \"$communication\"}"
