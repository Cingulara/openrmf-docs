# openSTIG Documentation

This is the repo for all the docs as the openSTIG project goes along.  Documentation on the openSTIG application will be here in MD files and reference images and other documents as well as GH markdown. This application idea has been brewing in my head for well over a decade and specifically since July 4th weekend 2018 when I started to put down code. Then in January 2019 when I scrapped all that July stuff and went for web APIs, microservices, eventual consistency, CQRS (command query responsibility segregation to scale separately), using MongoDB and NATS.

Phase 1 Vision / Concept as drawn on my whiteboard:
![Image](./architecture/phase1-architecture-whiteboard.jpg?raw=true)

The architecture was setup to do a few things for this tool and for myself actually:
* https://github.com/Cingulara/openstig-api-read is for listing, getting, and downloading a checklist and its metadata of title, description, type, and future user info
* https://github.com/Cingulara/openstig-api-save is for saving checklist data by posting it ALL in a form, including the raw checklist data (not a file). This publishes a "openstig.save.xxxx" type of event.
* https://github.com/Cingulara/openstig-api-template is for uploading, listing, and getting checklist file templates to start from
* https://github.com/Cingulara/openstig-msg-score is a NATS messaging subscriber listening to "save" events from Save and Upload to score the checklist
* https://github.com/Cingulara/openstig-api-scoring is for reading a score of a checklist as well as (future) scoring a checklist based on a file posted (at runtime)
* https://github.com/Cingulara/openstig-api-upload is for uploading a .CKL checklist file with metadata and saving the result. This publishes a "openstig.save.xxxx" type of event.

Future enhancements, since I did it with separate microservices all over including messaging, is to organically add publish / subscribe pieces such as compliance, auditing, logging, etc. to make this more user and enterprise ready. Along with all the error trapping, checking for NATS connection, etc. that a production 1.0 application would have. 

## STIG types
All the checklist CKL files have the same structure. Right now I am testing these below as I am a developer of course. However any of the STIGs should work here. The type is just to keep them straight and sort/order/filter on them in the future. https://iase.disa.mil/stigs/Pages/index.aspx has the info on STIGs and there are some on web servers, HBSS, Windows, Linux, Oracle, SQL Server, anti-virus, browsers, etc. More to come in this area for sure.

```
        ASD = 0,
        DBInstance = 10,
        DBServer = 20,
        DOTNET = 30,
        JAVA = 40
```

## Known issues
If you find something please add an issue to the correct repo. I know for now, the "updates" may or may not update. The "C" in CRUD should work. And I don't "D" yet to delete. It is ephemeral so I just power down the stack and power back up as I am testing. Eventually I will need to do that. 

OH and I have NO UI as of yet. :( Working on that.

## Docker-compose file to run
There is a stack.yml file in here to run the API .net core pieces, messaging subscriber for scoring, as well as local NATS and MongoDB. It uses 10 images pulled from DockerHub, 1 being the NATS messaging. You can certainly pull down the individual git repos or even pull the individual images and run them. I just did this so it was easier later and so I could show myself I could get it all running.

## Creating MongoDB Users by Hand
If you wish you can create a MongoDB setup just to persist your data and see what it does. I am not doing that yet as this is more of an alpha or pre-alpha for now. 

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

## Examples using Insomnia

Upload a .CKL file and metadata to save the data and send a save publishing message to score the new checklist.
![Image](./img/openStigUpload.png?raw=true)

Read a STIG checklist entry list, a single entry, or download a checklist. Pass in the Accept header for application/json or application/xml. The JAVA DISA tool needs XML.
![Image](./img/openStigRead.png?raw=true)

Save a checklist by posting metadata and the raw checklist, NOT the file. The File one is Upload. I don't use this much yet but if we needed to save a whole checklist in a form this could work. HEAVY but can work.
![Image](./img/openStigSave.png?raw=true)

Read the Score (number of open / not a finding / not applicable / not reviewed) of a checklist per category 1, 2, and 3. There are totals in here as well when you read them. This is done automagically from the msg-score subscribing microservice using NATS. 
![Image](./img/openStigScore.png?raw=true)

Save and list/get a template for a checklist. This is really used to store a baseline of a checklist and have that as a starting point. You could do this as a sysadmin or SRE to say "our IaaS or PaaS has all these checks approved, so start with that and add your specifics in here".
![Image](./img/openStigTemplate.png?raw=true)
