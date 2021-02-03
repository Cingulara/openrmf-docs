---
layout: default
title: What's New in v1.4
nav_order: 2
---

# What's New with OpenRMF

Please refer to the <a href="https://github.com/Cingulara?tab=projects" target="_blank">OpenRMF Projects listing on GitHub</a> for more information on feature updates and timeline.

## Version 1.4
Version 1.4 included one added feature:
* Feature #216: Ability to upload OpenSCAP results XCCDF XML file to create Checklists, along with Nessus and DISA SCAP XCCDF XML results

## Version 1.3.2
Version 1.3.2 was a bug fix release primarily as outlined below:
* Fix score calculation bug #213 on checklists for Not a Finding counts
* Added additional DISA public STIG Templates

## Version 1.3.1
Version 1.3.1 was a bug fix release primarily as outlined below:
* Fix a bug #203 on CAT 3 checklist Not a Finding counts not matching the checklist file
* Updated to the Jan 22, 2021 DISA public STIG templates

## Version 1.3
Version 1.3 was a bug fix release primarily as outlined below:
* Display the status of the vulnerability in the checklist/template view
* Scoring a checklist now uses the Severity Override as the severity if it is filled in (API and MSG client)
* Fixed a bug in the low/moderate/high loading of NIST 800.53 Controls
* Fixed a bug where PII controls are always used in the Compliance engine -- now only if the checkbox is set

## Version 1.2
Version 1.2 was also a security fix primarily with some updated functionality as outlined below:
* .NET Core 3.1 update with Debian 10 based containers
* Updated .NET Core 3.1 components such as Jaeger client, Swashbuckle, etc.
* Keycloak 10 upgrade from 7.0
* Keycloak theme for OpenRMF for seamless look-and-feel interaction
* Header Security fixes from an active scan of the web application 
* Compliance Summary buttons are interactive for filtering now
* Help documentation is now local to the application, not up on github.io pages

## Version 1.1
Version 1.1 was a security fix primarily with some updated functionality as outlined below:
* Rootless containers for APIs, messages, NGINX, and MongoDB databases
* Updated jQuery, File Upload, Bootstrap and other JS components
* Security Fixes from an active scan of the web application 
* Upload an existing checklist for a given checklist type and host = update the info (it was just duplicating the information)
* Allow Bulk Edits on Vulnerabilities across similar checklist types within a System grouping
* Container "restart: always" on the Docker Compose file
* All CSS, HTML, JS are local not reaching out over the public Internet

## Version 1.0

Version 1.0 of OpenRMF Core has these updates below:
* Fixing a bug on the Web UI updating Vulnerabilities via the web form in a checklist
* Updating the version descriptions to 1.0 throughout the codebase

## Version 0.15

Version 0.15 is the last update before going to version 1.0 of OpenRMF Core. The recent updates on that are below:
* Migrating the Web UI and all APIs behind NGINX for a single port 8080
* Automatically updating the checklist score on the page when editing a vulnerability status
* Various small bug fixes

## Version 0.14

The recent updates on version 0.14 are below:
* A new Report API for certain reports, using eventual consistency for behind the scenes reporting and faster data.
* Better indexing across all databases.
* Caching of certain data to quicken retrieving (reports, control listing, list of values, etc.).
* A new NATS Client Metrics exporter and Grafana dashboard we created to track metrics to the consumer level.

## Version 0.13

The recent updates for version 0.13 are below:
* Showing the CCI title and NIST related controls for each Vulnerability in a Checklist
* Export the Compliance listing to MS Excel
* Updated /healthz checks for Kubernetes for database connectivity
* Model showing an external API connected to OpenRMF via [Kong API Gateway](https://github.com/Cingulara/openrmf-ext-api-score) for "Scoring" a raw checklist 
* All APIs show tracing information in Jaeger UI
* Initial Kubernetes CNI network policies in the Helm 3.0 chart

## Version 0.12

The latest working version is version 0.12. The recent updates on that are below:
* Live editing of Checklist Asset data and Vulnerability status data
* Showing the version of the checklist
* Updated UI of the Template page to match the Checklist page
* Filtering on the System page listing checklists by status and severity/category of Vulnerabilities across all System checklists
* Filtering on the Checklist page by status and severity/category of Vulnerabilities within that checklist
* Create a Test Plan Summary across your System of Checklists and Nessus ACAS scan data
* Updated color coding throughout the UI for Open items to show severity / category better
* Generating the POA&M for Open and Not Reviewed items for a system (across all checklists)
* Generating the Risk Assessment Report (RAR) for a system (across all checklists)
* Generating the Test Plan Summary for a system (across all checklists)
* Upgrading a Checklist to the latest version and release with the click of a button!
