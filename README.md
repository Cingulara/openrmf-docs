# openSTIG Documentation

This is the repo for all the docs as this project goes along.  Documentation on the openSTIG application will be here in MD files and reference images and other documents as well as GH markdown.

Phase 1 Vision:
![Image](./architecture/phase1-architecture-whiteboard.jpg?raw=true)

## Docker-compose file to run
There is a stack.yml file in here to run the API .net core pieces, messaging subscriber for scoring, as well as local NATS and MongoDB. 

## creating the user for READ/SAVE/UPLOAD
* ~/mongodb/bin/mongo 'mongodb://root:myp2ssw0rd@localhost'
* use admin
* db.createUser({ user: "openstig" , pwd: "openstig1234!", roles: ["readWriteAnyDatabase"]});
* use openstig
* db.createCollection("Artifacts");

## creating the user for TEMPLATES
* ~/mongodb/bin/mongo 'mongodb://root:myp2ssw0rd@localhost'
* use admin
* db.createUser({ user: "openstigtemplate" , pwd: "openstig1234!", roles: ["readWriteAnyDatabase"]});
* use openstigtemplate
* db.createCollection("Templates");

## creating the database user SCORES
* ~/mongodb/bin/mongo 'mongodb://root:myp2ssw0rd@localhost'
* use admin
* db.createUser({ user: "openstigscore" , pwd: "openstig1234!", roles: ["readWriteAnyDatabase"]});
* use openstigscore
* db.createCollection("Scores");

## connecting to the database collection straight (example)
~/mongodb/bin/mongo 'mongodb://openstig:openstig1234!@localhost/openstig?authSource=admin'
