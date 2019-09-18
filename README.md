# OpenRMF Documentation (v 0.8) (formerly openSTIG)

## Introduction to OpenRMF
OpenRMF is an open source tool for managing, viewing, and reporting of your DoD STIG checklists in one web-based interface using your browser. It also generates a compliance listing of all your checklists across a whole system based on NIST 800-53 for your Risk Management Framework (RMF) documentation and process. This tool helps you manage multiple systems going through the RMF process and allows you to structure your data in a clean interface all in one location for your group or program. It can save you weeks of manually checking vulnerability-to-CCI-to-NIST controls and generating reports manually, so you can get on to the value-added work for your cybersecurity hygiene.

Read more about its genesis <a href="https://www.cingulara.com/opensource.html" target="_blank">here</a>.

![Image](./img/UI-checklist-dashboard.png?raw=true)

## Current Functionality
- [x] User AuthN and AuthZ for login accounts and Role Based Access Control on functions
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
- [x] YAML to quickly setup this project in OpenShift or K8s natively
- [x] Filter the Compliance Generator for Low/Moderate/High projects as well as PII/Privacy overlay information

## ToDos (in no particular order)
- [ ] Generate the RMF POA&M
- [ ] Import SCAP scans (DISA STIGs) for automatic checklist documentation
- [ ] Import ACAS/NESSUS scans (patches and updates) for automatic checklist documentation
- [ ] Select the fields to export to MS Excel, autofilter enabled on the header row
- [ ] A wizard to ask questions and customize a starting checklist file for you with certain fields and comments filled in
- [ ] Auditing all creates, deletes, and updates
- [ ] Central logging (ledger) for all CRUD and access usage based on NATS
- [ ] Import the Manual XML STIG to create a starting checklist
- [ ] Track changes / versions as you edit for a visual diff
- [ ] Track projects and due dates with notifications on timelines as well as anniversaries and required updates

If we are missing something you want, please add it on our main <a href="https://github.com/Cingulara/openrmf-web/issues" target="_blank">GitHub Issues</a> page.

## Description

The openRMF tool is an advanced alternative than the [DISA STIGViewer.jar](https://iase.disa.mil/stigs/Pages/stig-viewing-guidance.aspx) that is used for DoD STIG checklist files, RMF process information, and the like. It is necessary to capture and report on this information, please do not mistake what I say for not agreeing with securing services. However, the DISA Java tool itself is horribly designed and not conducive to today's environment and use. Their Java tool has been like this for a loooooonnnnnngggg time and I have wanted to make something better (IMO) for almost as long. So this tool here is the start! It is a way (currently) to view, report on, dive into, manage, and export your STIG checklists no matter which checklist you are referring to. All the .CKL files have a common format and htis reads and displays/manages that in a web front end using .NET Core APIs, MongoDB and NATS messaging. [View the history](https://www.cingulara.com/opensource.html) of this tool on our website. 

This is the repo for all the docs as the openRMF project goes along.  Documentation on the openRMF application will be here in MD files and reference images and other documents as well as GH markdown. This application idea has been brewing in my head for well over a decade and specifically since July 4th weekend 2018 when I started to put down code. Then in January 2019 when I scrapped all that July stuff and went for web APIs, microservices, eventual consistency, CQRS (command query responsibility segregation to scale separately), using MongoDB and NATS.

## What you need to run
You need a web browser that is fairly current. And you need Docker installed on your desktop (or Kubernetes/minikube) or server as this currently uses the Docker runtime to bring up all components with ` docker-compose ` via the included ".sh" shell (Linux / Mac) or ".cmd" command scripts (Windows).

* Docker is available at <a href="https://docs.docker.com/install/" target="_blank">https://docs.docker.com/install/</a>.

## Run openRMF locally
The best way to run this application (once you have Docker installed) is to go to the Code -- Releases tab https://github.com/Cingulara/openrmf-docs/releases and pull down the latest release. Unzip the file and then run the ./start.sh or .\start.cmd file to pull the latest images and run openRMF. Then you can open a local browser to http://localhost:8080/ and see what happens. If you want to change the ports you only have to edit the stack.yml file locally. 

Be sure to check out the [Keycloak information](develop#authentication-with-keycloak) because version 0.8 and beyond has RBAC for AuthN and AuthZ on the web and API calls. Or you could use another OpenID compliant application to provide AuthN and AuthZ.

> The data is currently mapped to internal Docker-managed volumes for persistence. You can run the "docker volume rm" command below if you wish to remove and start over as you test.  If you want persistence you could change the connection strings to another MongoDB server and adjust the stack.yml accordingly. Or use a volume in your stack.yml or individual docker commands. 

## Run openRMF latest development
For those that want to run the actual "latest" of OpenRMF you should run `git clone https://github.com/Cingulara/openrmf-docs.git `, then `git checkout develop` to switch to the develop branch. There is a ./dev-start.sh (or .\dev-start.cmd on Windows) file to run to start and a corresponding ./dev-stop.sh (.\dev-stop.cmd on Windows) to run the latest development version. These operate on http://localhost:9080 so as not to interfere with a running released version to compare/contrast. Note the dev-stack.yml has different ports and different database mount volumes as well. 

## Authentication with Keycloak

Starting with version 0.8 we have AuthN and AuthZ setup for use. See the [Keycloak Document](keycloak.md) for more information.

## Known issues
If you find something please add an issue to the correct repo. 

- Version 0.7 the scoring currently does not work right. We are working on that.

If you find any problem, have an idea or enhancement please do not hesitate to add to the [Issues](https://github.com/Cingulara/openrmf-docs/issues) area.

## Creating MongoDB Users by Hand
If you wish you can create a MongoDB setup locally to persist your data and see what it does. Checkout the [create users by hand](create-users-by-hand.md) readme for more on that. 

## cleaning up the Docker volumes and such every so often
If you want to remove all data from volumes you can run the below. Do at your own risk and know the consequences! I do this on my development machine to clear ALL volumes including those not for openRMF. 

* run `docker volume rm $(docker volume ls -qf dangling=true)` 
* run `docker system prune` and then enter `y` and press Enter when asked

## Screenshots of the UI

The Individual Checklist view
![Image](./img/UI-checklist-scoring-vulns.png?raw=true)

Generate RMF Compliance Listing with linked Checklists and filtered vulnerabilities!
![Image](./img/UI-system-compliance-generator.png?raw=true)

The UI Checklist Graphs
![Image](./img/UI-checklist-graphs.png?raw=true)

The checklist Upload page
![Image](./img/UI-checklist-upload.png?raw=true)

Exporting the checklist to XLSX with color coding
![Image](./img/checklist-export-xlsx.png?raw=true)
