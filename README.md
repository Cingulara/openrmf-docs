# openSTIG Documentation (v 0.6)

## Introduction
openSTIG is an open source tool for managing, viewing, and reporting of your DoD STIG checklists in one web-based interface using your browser. It also generates a compliance listing of all your checklists across a whole system based on NIST 800-53 for your Risk Management Framework (RMF) documentation and process. This tool helps you manage multiple systems going through the RMF process and allows you to structure your data in a clean interface all in one location for your group or program. It can save you weeks of manually checking vulnerability-to-CCI-to-NIST controls and generating reports manually, so you can get on to the value-added work for your cybersecurity hygiene.

Read more about its genesis <a href="https://www.cingulara.com/opensource.html" target="_blank">here</a>.

![Image](./img/UI-checklist-dashboard.png?raw=true)

## Current Functionality
- [x] Save/Upload .CKL files for viewing and safekeeping
- [x] List and display active checklists
- [x] List and display templated checklists (starting points)
- [x] Group and list checklists and reports by System (a group of checklists for a single application, system, etc.)
- [x] Reporting or "scoring" on Open, N/A, "Closed" as well as "not yet reviewed" items in the checklists quickly
- [x] Exporting the .CKL file for quick loading into the STIG Viewer Java application
- [x] Exporting to MS Excel in seconds with color coded rows based on status (Open = RED, Not a Finding = GREEN, etc.)
- [x] Dashboard showing # of checklists, top 5 checklists based on activity
- [x] Exporting of charts for download to PNG
- [x] Generate a Compliance listing of NIST 800-53 Controls to all checklists within a system 
- [x] Filter Vulnerabilities on the Checklist page by status 
- [x] Filter vulnerabilities for your Compliance listing based on major controls
- [x] Exporting your list of checklists and their score by status and category to MS Excel 

## ToDos (in no particular order)
- [ ] Generate the RMF POA&M
- [ ] Import SCAP scans for automatic checklist documentation
- [ ] Import NESSUS scans for automatic checklist documentation
- [ ] Select the fields to export to MS Excel, autofilter enabled on the header row
- [ ] A wizard to ask questions and customize a starting checklist file for you with certain fields and comments filled in
- [ ] User login and auditing
- [ ] Central logging (ledger) for all CRUD and access usage based on NATS
- [ ] Import the Manual XML STIG to create a starting checklist
- [ ] Track changes / versions as you edit for a visual diff
- [ ] Track projects and due dates with notifications on timelines as well as anniversaries and required updates
- [ ] YAML to quickly setup this project in OpenShift or K8s natively

If we are missing something you want, please add it on our main <a href="https://github.com/Cingulara/openstig-web/issues" target="_blank">GitHub Issues</a> page.

## Description

The openSTIG tool is a better alternative than the [DISA STIGViewer.jar](https://iase.disa.mil/stigs/Pages/stig-viewing-guidance.aspx) that is used for DoD STIG checklist files, RMF process information, and the like. It is necessary to capture and report on this information, please do not mistake what I say for not agreeing with securing services. However, the DISA Java tool itself is horribly designed and not conducive to today's environment and use. Their Java tool has been like this for a loooooonnnnnngggg time and I have wanted to make something better (IMO) for almost as long. So this tool here is the start! It is a way (currently) to view, report on, dive into, manage, and export your STIG checklists no matter which checklist you are referring to. All the .CKL files have a common format and htis reads and displays/manages that in a web front end using .NET Core APIs, MongoDB and NATS messaging. [View the history](https://www.cingulara.com/opensource.html) of this tool on our website. 

This is the repo for all the docs as the openSTIG project goes along.  Documentation on the openSTIG application will be here in MD files and reference images and other documents as well as GH markdown. This application idea has been brewing in my head for well over a decade and specifically since July 4th weekend 2018 when I started to put down code. Then in January 2019 when I scrapped all that July stuff and went for web APIs, microservices, eventual consistency, CQRS (command query responsibility segregation to scale separately), using MongoDB and NATS.

## What you need to run
You need a web browser that is fairly current. And you need Docker installed on your desktop or server as this currently uses the Docker runtime to bring up all components with ` docker-compose `.

* Docker is available at <a href="https://docs.docker.com/install/" target="_blank">https://docs.docker.com/install/</a>.

## Docker-compose file to run
There is a stack.yml file in here to run the API .net core pieces, messaging subscriber for scoring, as well as local NATS and MongoDB. It uses 10+ images pulled from DockerHub, 1 being the NATS messaging. You can certainly pull down the individual git repos or even pull the individual images and run them. I just did this so it was easier later and so I could show myself I could get it all running. I also have a local-stack for those wanting to do development and use the local copies you build. And an infra-stack to just run a single instance of MongoDB and NATS to test interactively. To run it, do something like this below. Add the ` -d ` before the ` -f stack.yml ` to run as a server/service/daemon versus interactively (default). I usually run interactively so I can see the logs and what is happening.

To run this clone the repo, go into the openstig-docs folder and run the below. Or copy [this file](https://raw.githubusercontent.com/Cingulara/openstig-docs/master/stack.yml) down locally and run it. 

```
docker-compose -f stack.yml up
```

Alternatively, if you clone the openstig-docs repo you can run the ./start.sh (Linux / Mac OSX) or ./start.cmd (Windows) file to start all containers for the complete system. To stop run the corresponding ./stop.sh or ./stop.cmd respectively. 

Then you can open a local browser to http://localhost:8080/ and see what happens. If you want to change the ports you only have to edit the stack.yml file locally.  

> The data is currently mapped to internal Docker-managed volumes for persistenct. You can run the "docker volume rm" command below if you wish to remove and start over as you test.  If you want persistence you could change the connection strings to another MongoDB server and adjust the stack.yml accordingly.

## Architecture explained

Phase 1 Vision / Concept as drawn on my whiteboard:

![Image](./architecture/openSTIG-Tool-0.6-Architecture.png?raw=true)

The architecture was setup to do a few things for this tool and for myself actually:
* https://github.com/Cingulara/openstig-web is the web UI pointing to all these APIs below to render checklists listings, data, vulnerabilities, reports, and allowing saving 
of chart data and XLSX downloads.
* https://github.com/Cingulara/openstig-api-read is for listing, getting, and downloading a checklist and its metadata of title, description, type, and future user info. It also has an export to Excel function that is color coded for status thanks to a request by a good IA/CS friend of mine that needed that.
* https://github.com/Cingulara/openstig-api-save is for saving checklist data by posting it ALL in a form, including the raw checklist data (not a file). This publishes an "openstig.save.xxxx" type of event to NATS.
* https://github.com/Cingulara/openstig-api-template is for uploading, listing, and getting checklist file templates to start from.
* https://github.com/Cingulara/openstig-msg-score is a NATS messaging subscriber listening to "openstig.save.*" events from Save and Upload to score the checklist and putting that score into the Mongo DB for the scoring API
* https://github.com/Cingulara/openstig-api-scoring is for reading a score of a checklist as well as scoring a checklist based on a file posted (at runtime).
* https://github.com/Cingulara/openstig-api-upload is for uploading a .CKL checklist file with metadata and saving the result. This publishes an "openstig.save.xxxx" type of event.
* https://github.com/Cingulara/openstig-api-controls is a read-only lookup of NIST controls to match to CCI for the compliance API and other pieces that need to pull the NIST control descriptions for 800-53.
* https://github.com/Cingulara/openstig-api-compliance is for generating the compliance listing, matching NIST controls via CCI to 1 or more checklists in a System. This generates a table of controls and the checklists corresponding to the control from the system's group of checklists. The checklist is linked to the Checklist service and color coded by status.

Future enhancements, since I did it with separate microservices all over including messaging, are to organically add publish / subscribe pieces such as compliance, auditing, logging, etc. to make this more user and enterprise ready. Along with all the error trapping, checking for NATS connection, etc. that a production 1.0 application would have. 

## Known issues
If you find something please add an issue to the correct repo. I know for now, I don't "D" yet to delete. It is ephemeral so I just power down the stack and power back up as I am testing. Eventually I will need to do that. 

If you find any problem, have an idea or enhancement please do not hesitate to add to the [Issues](https://github.com/Cingulara/openstig-docs/issues) area.

## Creating MongoDB Users by Hand
If you wish you can create a MongoDB setup just to persist your data and see what it does. I am not doing that yet as this is more of an alpha or pre-alpha for now. Checkout the [create users by hand](create-users-by-hand.md) readme for more on that. 

## cleaning up the Docker volumes and such every so often
* run `docker volume rm $(docker volume ls -qf dangling=true)` 
* run `docker system prune` and then enter `y` and press Enter when asked

## Screenshots of the UI

The Individual Checklist view
![Image](./img/UI-checklist-scoring-vulns.png?raw=true)

The UI Checklist Graphs
![Image](./img/UI-checklist-graphs.png?raw=true)

The checklist Upload page
![Image](./img/UI-checklist-upload.png?raw=true)

Exporting the checklist to XLSX with color coding
![Image](./img/checklist-export-xlsx.png?raw=true)
