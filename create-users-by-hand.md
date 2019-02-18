
### creating the user for READ/SAVE/UPLOAD by hand
* ~/mongodb/bin/mongo 'mongodb://root:myp2ssw0rd@localhost'
* use admin
* db.createUser({ user: "openstig" , pwd: "openstig1234!", roles: ["readWriteAnyDatabase"]});
* use openstig
* db.createCollection("Artifacts");

### creating the user for TEMPLATES by hand
* ~/mongodb/bin/mongo 'mongodb://root:myp2ssw0rd@localhost'
* use admin
* db.createUser({ user: "openstigtemplate" , pwd: "openstig1234!", roles: ["readWriteAnyDatabase"]});
* use openstigtemplate
* db.createCollection("Templates");

### creating the database user SCORES by hand
* ~/mongodb/bin/mongo 'mongodb://root:myp2ssw0rd@localhost'
* use admin
* db.createUser({ user: "openstigscore" , pwd: "openstig1234!", roles: ["readWriteAnyDatabase"]});
* use openstigscore
* db.createCollection("Scores");

## connecting to the database collection straight (example)
~/mongodb/bin/mongo 'mongodb://openstig:openstig1234!@localhost/openstig?authSource=admin'