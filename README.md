# openSTIG Documentation

![Image](./img/UI-checklist-dashboard.png?raw=true)

This is the repo for all the docs as the openSTIG project goes along.  Documentation on the openSTIG application will be here in MD files and reference images and other documents as well as GH markdown. This application idea has been brewing in my head for well over a decade and specifically since July 4th weekend 2018 when I started to put down code. Then in January 2019 when I scrapped all that July stuff and went for web APIs, microservices, eventual consistency, CQRS (command query responsibility segregation to scale separately), using MongoDB and NATS.

Phase 1 Vision / Concept as drawn on my whiteboard:

![Image](./architecture/openSTIG-Tool-0.4-Architecture.png?raw=true)

The architecture was setup to do a few things for this tool and for myself actually:
* https://github.com/Cingulara/openstig-web is the web UI pointing to all these APIs below to render checklists listings, data, vulnerabilities, reports, and allowing saving 
of chart data and XLSX downloads.
* https://github.com/Cingulara/openstig-api-read is for listing, getting, and downloading a checklist and its metadata of title, description, type, and future user info. It also has an export to Excel function that is color coded for status thanks to a request by a good IA/CS friend of mine that needed that.
* https://github.com/Cingulara/openstig-api-save is for saving checklist data by posting it ALL in a form, including the raw checklist data (not a file). This publishes an "openstig.save.xxxx" type of event to NATS.
* https://github.com/Cingulara/openstig-api-template is for uploading, listing, and getting checklist file templates to start from.
* https://github.com/Cingulara/openstig-msg-score is a NATS messaging subscriber listening to "openstig.save.*" events from Save and Upload to score the checklist and putting that score into the Mongo DB for the scoring API
* https://github.com/Cingulara/openstig-api-scoring is for reading a score of a checklist as well as scoring a checklist based on a file posted (at runtime).
* https://github.com/Cingulara/openstig-api-upload is for uploading a .CKL checklist file with metadata and saving the result. This publishes an "openstig.save.xxxx" type of event.

Future enhancements, since I did it with separate microservices all over including messaging, are to organically add publish / subscribe pieces such as compliance, auditing, logging, etc. to make this more user and enterprise ready. Along with all the error trapping, checking for NATS connection, etc. that a production 1.0 application would have. 

## STIG types
All the checklist CKL files have the same structure. Right now I am testing mainly the SQL Server, .NET, Java, and other web server checklists however I have tested the OS and web browser ones as well. All of them work well. I have not included those checklists in here that are beind a PKI certificate login. https://iase.disa.mil/stigs/Pages/index.aspx has the info on STIGs and there are some on web servers, HBSS, Windows, Linux, Oracle, SQL Server, anti-virus, browsers, etc. More to come in this area for sure. There is an Upload page in the UI that lets you upload a CKL file and select the type, name and description to track and report.

```
        Other = 0, // those not listed here, those you need via PKI, etc.

        /* Development Technologies */
        ApplicationSecurityAndDevelopment = 10,
        OracleJRE8UNIX = 101,
        OracleJRE8Windows = 102,
        MSDotNet4 = 105,

        /* ANTI VIRUS */
        McAfeeAntiVirusLocalClient = 201,
        McAfeeAntiVirusManagedClient = 202,
        McAfeeAntiVirusEnterpriseLinuxLocalClient = 203,
        McAfeeAntiVirusEnterpriseLinuxManagedClient = 204,
        McAfeeAntiVirusEnterpriseLinux = 200,
        WindowsDefender = 205,

        /* Application Servers */
        ColdFusion = 301,
        BromiumSecurePlatform4 = 305,
        IBMMQAppliancev9AS = 310,
        IBMMQAppliancev9NDM = 311,

        ...there are more in the code
```

## Known issues
If you find something please add an issue to the correct repo. I know for now, I don't "D" yet to delete. It is ephemeral so I just power down the stack and power back up as I am testing. Eventually I will need to do that. 

## Docker-compose file to run
There is a stack.yml file in here to run the API .net core pieces, messaging subscriber for scoring, as well as local NATS and MongoDB. It uses 10+ images pulled from DockerHub, 1 being the NATS messaging. You can certainly pull down the individual git repos or even pull the individual images and run them. I just did this so it was easier later and so I could show myself I could get it all running. I also have a local-stack for those wanting to do development and use the local copies you build. And an infra-stack to just run a single instance of MongoDB and NATS to test interactively.

## Creating MongoDB Users by Hand
If you wish you can create a MongoDB setup just to persist your data and see what it does. I am not doing that yet as this is more of an alpha or pre-alpha for now. Checkout the [create users by hand](create-users-by-hand.md) readme for more on that. 

## cleaning up the Docker volumes and such every so often
* run `docker volume rm $(docker volume ls -qf dangling=true)` 
* run `docker system prune` and then enter `y` and press Enter when asked

## Examples using Insomnia
The [Insomnia](Insomnia.md) readme has examples of calling the APIs straight

## Screenshots of the UI

The Individual Checklist view
![Image](./img/UI-checklist-scoring-vulns.png?raw=true)

The UI Checklist Graphs
![Image](./img/UI-checklist-graphs.png?raw=true)

The checklist Upload page
![Image](./img/UI-checklist-upload.png?raw=true)

The UI Checklist Template view
![Image](./img/UI-checklist-template.png?raw=true)

Exporting the checklist to XLSX with color coding
![Image](./img/checklist-export-xlsx.png?raw=true)
