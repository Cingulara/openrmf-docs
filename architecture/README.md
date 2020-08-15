# OpenRMF Architecture
This has the current architecture information for the OpenRMF application as of version 0.11 and beyond to include the current 1.2 version.

![Image](./openRMF-Tool-Architecture.png?raw=true)

## The Genesis
The January 2019 Phase 1 Vision / Concept as drawn on my whiteboard in my basement:
![Image](./phase1-architecture-whiteboard.jpg?raw=true)

## Current Architecture

The architecture was setup to do a few things for this tool and for the team actually:

* https://github.com/Cingulara/openrmf-web is the web UI pointing to all these APIs below to render checklists listings, data, vulnerabilities, reports, and allowing saving 
of chart data and XLSX downloads.
* https://github.com/Cingulara/openrmf-api-read is for listing, getting, and downloading a checklist and its metadata of title, description, type, and future user info. It also has an export to Excel function that is color coded for status thanks to a request by a good IA/CS friend of mine that needed that.
* https://github.com/Cingulara/openrmf-api-save is for saving checklist data by posting it ALL in a form, including the raw checklist data (not a file). This publishes an "openrmf.save.xxxx" type of event to NATS.
* https://github.com/Cingulara/openrmf-api-template is for uploading, listing, and getting checklist file templates to start from.
* https://github.com/Cingulara/openrmf-msg-score is a NATS messaging subscriber listening to "openrmf.save.*" events from Save and Upload to score the checklist and putting that score into the Mongo DB for the scoring API
* https://github.com/Cingulara/openrmf-api-scoring is for reading a score of a checklist as well as scoring a checklist based on a file posted (at runtime).
* https://github.com/Cingulara/openrmf-api-upload is for uploading a .CKL checklist file with metadata and saving the result. This publishes an "openrmf.save.xxxx" type of event.
* https://github.com/Cingulara/openrmf-api-controls is a read-only lookup of NIST controls to match to CCI for the compliance API and other pieces that need to pull the NIST control descriptions for 800-53.
* https://github.com/Cingulara/openrmf-api-compliance is for generating the compliance listing, matching NIST controls via CCI to 1 or more checklists in a System. This generates a table of controls and the checklists corresponding to the control from the system's group of checklists. The checklist is linked to the Checklist service and color coded by status.
* https://github.com/Cingulara/openrmf-api-audit is a read-only lookup of Audit information for OpenRMF that only Administrators can access.
* https://github.com/Cingulara/openrmf-api-reports is a read-only lookup of OpenRMF data for certain reports that use caching and eventual consistency of data (Nessus Patch Report and Host Vulnerability).
* https://github.com/Cingulara/openrmf-msg-controls is a NATS client for responding to request/reply on a list of all RMF controls or get the information on a specific control (i.e. AC-1).
* https://github.com/Cingulara/openrmf-msg-compliance is a NATS client for responding to request/reply on a list of all compliance listings mapping STIG vulnerability IDs to controls. Use this for a full listing based on a low/moderate/high level as well as if you are using personally identifiable information (PII) or similar data.
* https://github.com/Cingulara/openrmf-msg-template is a NATS client for responding to request/reply on a request for a System template based on the title passed in.
* https://github.com/Cingulara/openrmf-msg-checklist is a NATS client for responding to request/reply on a request for a checklist based on the Mongo DB record Id passed in.
* https://github.com/Cingulara/openrmf-msg-system is a NATS client for responding to published messages for updating a System based on title, number of checklists, or running a compliance check.
* https://github.com/Cingulara/openrmf-msg-audit is a NATS client for responding to published messages for recording auditable events through OpenRMF.
* https://github.com/Cingulara/openrmf-msg-reports is a NATS client for responding to published messages for eventual consistency of OpenRMF data used for reporting.

We started this project with separate microservices all over including messaging for API-to-API communication. We also added organically several publish / subscribe pieces such as compliance, auditing, logging, etc. to make this more user and enterprise ready. Along with the error trapping, checking for NATS connection, etc. that a production 1.0 application would have. Just like any software we are continually updating and adding features, shaping code toward best practices, and including things such as Prometheus and Grafana for metrics as well as Jaeger for tracing calls.

## Current Messaging Architecture

OpenRMF uses NATS messaging to work eventual consistency as well as API-to-API communication. The items below talk on the types of messaging, who initiates the communication, the receiving NATS client, and a description of what it does.

| Subject | Msg Type | Calling API |     Receiving Client  | Description |
|---------|----------|-------------|-----------------------|-------------|
| openrmf.checklist.read | Request/Reply | Score (Msg Client), Compliance  | openrmf-msg-checklist | Ask for a full checklist/artifact record based on the ID passed in |
| openrmf.system.checklists.read | Request/Reply | Compliance          | openrmf-msg-checklist | Ask for all checklist records for a given system title passed in |
| openrmf.checklist.save.new | Subscribe | Upload | openrmf-msg-score | Grab the new uploaded checklist ID sent and generate the score of open, not applicable, not a finding, and not reviewed items across categories |
| openrmf.checklist.save.new | Subscribe | Upload | openrmf-msg-reports | Grab the new uploaded checklist ID sent and generate the vulnerability data in the reports database, separated out by vulnerability ID |
| openrmf.checklist.save.update | Subscribe | Upload | openrmf-msg-score | Grab the updated checklist ID sent and generate the score of open, not applicable, not a finding, and not reviewed items across categories |
| openrmf.checklist.save.update | Subscribe | Upload | openrmf-msg-reports | Grab the new uploaded checklist ID sent and generate the vulnerability data in the reports database, separated out by vulnerability ID while removing the old vulnerability data for that checklist ID |
| openrmf.checklist.delete | Subscribe | Save | openrmf-msg-score | Delete the score record for the passed in checklist ID  |
| openrmf.score.read | Subscribe | Read | openrmf-msg-score | Read API calling for the score when generating an XLSX checklist download listing the score. |
| openrmf.compliance.cci | Request/Reply | Compliance | openrmf-msg-compliance | Send back all CCI to NIST Major Controls listing. |
| openrmf.compliance.cci.control | Request/Reply | Compliance, Read | openrmf-msg-compliance | Send back a full listing of CCI items based on the NIST/RMF control passed in.  |
| openrmf.controls | Request/Reply | Compliance |  openrmf-msg-controls| Send back the list of all controls. |
| openrmf.controls.search | Request/Reply | Controls | openrmf-msg-controls | Send back a single record for the passed in control (i.e. AC-2). |
| openrmf.template.read | Request/Reply | Upload | openrmf-msg-template | Send back a single template checklist record for the passed in title. Used when you upload an XCCDF SCAP scan result to create a checklist. |
| openrmf.checklist.read | Request/Reply | Score | openrmf-msg-checklist | Send back a single checklist record for the passed in Mongo DB InternalId title. Used when you score a checklist in eventual consistency to pull the checklist and create the structure so we can do a count on status. |
| openrmf.system.checklists.read | Request/Reply | Read | openrmf-msg-checklist | Send back the list of checklists so we can export them into XLSX from the System page. |
| openrmf.system.update.{Id} | Subscribe | Save | openrmf-msg-system | When a system title is updated, make sure all references throughout the checklists are updated. We save the system group Id and the title with the checklists for easier usage throughout OpenRMF. The source-of-truth is the systemgroups collection in MongoDB. |
| openrmf.system.count.> | Subscribe | Upload (add) and Save (delete) | openrmf-msg-system | Increments with a ".add" at the end of the subject or decrements if there is a ".delete" at the end of the subject. The payload is the system group Id. |
| openrmf.system.compliance | Subscribe | Compliance | openrmf-msg-system | Stores the date of the last compliance check run into the system group record for display later. |
| openrmf.compliance.cci.references | Request/Reply | Compliance | openrmf-msg-compliance | Passing in the CCI it returns the CCI title and NIST list of references for the CCI passed in to the Compliance API. |
| openrmf.system.delete | Subscribe | Save | openrmf-msg-reports | Passing in the System Group ID, the reporting data for patch scanning and vulnerabilities are removed from the database. |
| openrmf.system.patchscan | Subscribe | Save | openrmf-msg-reports | Passing in the System Group ID, the reporting data for patch scanning is pulled from the raw string data in the Artifact database, parsed, put into the right structure, and saved into the report database. |
| openrmf.report.refresh.nessuspatchdata | Subscribe | Report | openrmf-msg-reports | Issue a command from the GUI as an Administrator to refresh all Nessus Patch Data in every System. |
| openrmf.report.refresh.vulnerabilitydata | Subscribe | Report | openrmf-msg-reports | Issue a command from the GUI as an Administrator to refresh all Checklist Vulnerability on every checklist in every System. |
| openrmf.checklist.save.vulnerability.update | Subscribe | Save | openrmf-msg-reports | Passing in a dictionary of string/string to update the vulnerability record in the report database based on an edit PUT to the Save API editing a checklist. |
| openrmf.checklist.save.vulnerability.update | Subscribe | Save | openrmf-msg-score | Passing in a dictionary of string/string to update the score calculations in the score database based on an edit PUT to the Save API editing a checklist. |
