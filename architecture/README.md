# openRMF Architecture
This has the current architecture information for the OpenRMF application as of version 0.8.

## The Genesis
The January 2019 Phase 1 Vision / Concept as drawn on my whiteboard in my basement:
![Image](./architecture/phase1-architecture-whiteboard.jpg?raw=true)

## Current Architecture

The architecture was setup to do a few things for this tool and for myself actually:
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
* https://github.com/Cingulara/openrmf-msg-controls is a NATS client for responding to request/reply on a list of all RMF controls or get the information on a specific control (i.e. AC-1).
* https://github.com/Cingulara/openrmf-msg-compliance is a NATS client for responding to request/reply on a list of all compliance listings mapping STIG vulnerability IDs to controls. Use this for a full listing based on a low/moderate/high level as well as if you are using personally identifiable information (PII) or similar data.

I started this project with separate microservices all over including messaging for API-to-API communication. Future enhancements are to organically add publish / subscribe pieces such as compliance, auditing, logging, etc. to make this more user and enterprise ready. Along with all the error trapping, checking for NATS connection, etc. that a production 1.0 application would have. 