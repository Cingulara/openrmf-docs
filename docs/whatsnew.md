---
layout: default
title: What's New in v1.8
nav_order: 2
---

# What's New with OpenRMF

Please refer to the <a href="https://github.com/Cingulara?tab=projects" target="_blank">OpenRMF Projects listing on GitHub</a> for more information on feature updates and timeline.

## Version 1.8
Version 1.8 has the latest DISA templates (438) for SCAP scan matching up to May 10, 2022 as well as the following feature updates:
* Allow creating a new checklist from a template from the template checklist page
* Allow removing a Nessus patch scan from a system package record
* Updated the POAM to DoD format for use in eMASS and other applications
* Show the checklist template version and release on the template listing page
* Updated button help throughout
* Updated XLSX formatting with merged cells and borders
* Logging configurable with LOGLEVEL environment variable 0 - 5 (Trace through Critical), defaulting to Warn = 3
* MongoDB 5.0
* Keycloak 15.0
* NATS 2.8
* .NET Core 6 runtime
* consolidated 4 APIs into 1
* consolidated 2 MSG clients into 1

## Version 1.7
Version 1.7 has the latest DISA templates for SCAP scan matching up to December 24, 2021 as well as the following feature updates:
* updated base container image for vulnerability fixes
* updated NGINX container for the web UI for vulnerability fixes
* easier editing of vulnerabilities, all on one page w/o a popup
* fixing a bug removing \n from Template formatting
* fixing loading of HTML / XML characters in checklist details listings
* adding the NGINX prometheus exporter for tracking metrics of the web UI
* allow tagging of checklists (one at a time)
* listing all templates, including internal ones from DISA's public site
* better formatting of plugin description for Nessus report
* better formatting for vulnerability detail on reports and chekclist vulnerability listings

## Version 1.6
Version 1.6 fixed the POSIX bug after updating to Docker Desktop where the .env file and APIs read the environment variables but they had a "-" in them. That was breaking it. 

## Version 1.5.4
Version 1.5.4 added the updated DISA Templates from April 27 and April 28 2021. These allow you to match on SCAP scan uploads to automatically create checklists.

## Version 1.5.3
Version 1.5.3 included these updates:
* Keycloak v 12.0.3 OpenRMF Theme
* Download All CKL into ZIP for a System Package
* Merge POAM and RAR fields into one for XLSX download
* Table cell click for filtering Checklists and Templates Vulnerabilities listing
* Color code reports for status
* Improved UI on messaging and spacing
* Various small bug fixes

## Version 1.5.2
Version 1.5.2 included one update:
* Update to Keycloak v 12.0.3
* Fix for Keycloak Windows-based realm creation script

## Version 1.5.1
Version 1.5.1 included a few updated features:
* Updated base image and application container image to use Alpine and self-contained application executables for reduced scanning surface and size
* Bug fix for the Reporting when you upgrade to a new STIG Checklist release with changing Vulnerability IDs
* Auto-logoff after 15 minutes
* Auto-refresh of the Keycloak token when on a page longer than 5 minutes

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
