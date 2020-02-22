---
title: What's New in v0.12
nav_order: 2
---

# What's New with OpenRMF

Please refer to the <a href="https://github.com/Cingulara?tab=projects" target="_blank">OpenRMF Projects listing on GitHub</a> for more information on feature updates and timeline.

The latest working version is version 0.12. The recent updates on that are below:
* Live editing of Checklist Asset data and Vulnerability status data
* Showing the version of the checklist
* Updated UI of the Template page to match the Checklist page
* Filtering on the System page listing checklists by status and severity/category of Vulnerabilities across all System checklists
* Filtering on the Checklist page by status and severity/category of Vulnerabilities within that checklist
* Create a Test Plan Summary across your System of Checklists and Nessus ACAS scan data
* Updated color coding throughout the UI for Open items to show severity / category better

Version 0.11 updates are also below:
* Interactive Reports for Nessus Scan data, System Score and Checklist Vulnerability Data
* New and Improved Dashboard for at-a-glance Critical and High patch issues
* New and Improved Dashboard for at-a-glance list of Open Items for checklists
* Systems page showing all info on a system
* Reworked the System page for quick look at systems and status at a glance
* Ability to have a description and title of a system, as well as last recorded compliance generation date
* Import of Nessus File to keep with the System -- Export back out
* Export Nessus Summary to XLSX
* Beta of Importing Nessus SCAP scan XCCDF files for generating checklists (DoD SCAP already included)
* Auditing of certain Create, Update, and Delete events into a separate database
* Summary Compliance Report by Family when generating compliance report
* Update to 0.10 of the NATS C# client
* Prometheus export for NATS and documentation on showing in Grafana
* Setup NATS client to auto reconnect, log on disconnect
* Updated Documentation