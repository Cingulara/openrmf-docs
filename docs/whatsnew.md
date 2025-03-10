---
layout: default
title: What's New
nav_order: 2
---

# What's New with OpenRMF<sup>&reg;</sup> OSS

Please refer to the <a href="https://github.com/Cingulara?tab=projects" target="_blank">OpenRMF Projects listing on GitHub</a> for more information on feature updates and timeline.

## Version 1.13 (Security and Performance Update)
Version 1.13 has the following added features and fixes:
* Added the patch vulnerability numbers to the system package dashboard
* Added a checklist dashboard report
* Added a Missing Data report (checklist with Not a Finding or N/A, but no details or comments)
* Added CCI and NIST 800-53 to checklist report results
* Fixed parsing STIG Viewer v3 combined CKLs with their different field usage
* Updated the Template xccdf parsing to use "info" as "low" for severity
* Added a Postgres migration to 16.2-alpine
* Added MongoDB 6 compatibility scripts
* Updated 3rd party images including Keycloak
* Update the CCI listing to the latest from DISA January 2025
* Latest DISA Templates as of February 28, 2025
* Migrated code to .NET 8 baseline
* Added the OpenRMF OSS logo
* Updated base images when compiling for cleaner vulnerability scans

## Version 1.12 (Security and Performance Update)
Version 1.12 has the following added features and fixes:
* Add checklist uniqueness based on `system package`-`hostname`-`checklist type`-`web or database T/F`-`site`-`instance`
* Fixed the Evaluate-STIG parsing bug
* Fix a bug with podman on not specifying the full image path
* Fix a bug with SCAP not finding the DISA template correctly
* Update the CCI listing to the latest from DISA
* Latest DISA Templates as of Sept 20, 2024
* Updated Keycloak, MongoDB
* Updated base images when compiling for cleaner vulnerability scans

## Version 1.11 (Security and Performance Update)
Version 1.11 has the following added features and fixes:
* Added MARKING, HOST IP, HOST MAC, Web or Database Fields for display and editing
* Get Host IP, MAC, FQDN from the SCAP scan results, if there, for a checklist
* Read for Not Applicable in SCAP scan results, and fill in CKL record accordingly
* Updated Keycloak `KC_PROXY` environment variable from `passthrough` to `edge` for HTTPS setup later
* Updated base images for web, code
* Updated 3rd party infrastructure images
* Updated matching SCAP to DISA Checklist Templates on naming conventions
* Removed Jaeger and OpenTracing older code not used
* Removed build warnings on NLog and throwing extra exceptions
* Sped up loading of report and template data
* Latest DISA Templates as of April 18, 2024
* Mounted the initial JS for database collections with `:Z` versus `:ro` to work in REL/podman

## Version 1.10 (Performance, Reports, Fixes and Updated Templates)
Version 1.10 has the following added features and fixes:
* Sped up reports using AJAX calls to load some tables versus "foreach" Javascript
* Added indexes on certain fields for speeding up the listing and searching of data in 5 MongoDB databases
* Added a report to list vulnerabilities by status and severity options
* Added a report to show activity on checklists for age and stale data
* Added a report to show all Vulnerabilities with severity override set
* Added a report to list all Checklists that require an Upgrade
* Fix for Empty Comments / Details not saved on Checklists
* Fix for Apostrophe and special HTML characters being escaped in data on textboxes
* Fix for matching SCAP to Checklists on certain changed DISA templates
* Fix for Severity Override not resetting after being on a VULN record that has one, to one that does not
* Remove Caching on Reporting API to show proper data after deleting checklists correctly
* Latest DISA Templates as of November 4, 2023
* Updated help with better descriptions and overview

## Version 1.9
Version 1.9 has the following feature updates:
* Fix for SCAP Scans featuring enhanced information from SCC tool
* Fix for hostname filter to be case insensitive on system package checklist listing
* Allow searching Vulnerability from Reports with a partial VULN ID match
* Updated base container images for vulnerability fixes
* latest DISA templates (480) for SCAP scan matching up to March 08, 2023
* support for `podman` and `podman-compose`
* use of `docker compose` versus `docker-compose` in scripts

> BREAKING CHANGE of Keycloak 20 with new configuration, all under a single port 8080 / 8443

> BREAKING CHANGE of Grafana under a single port 8080 / 8443

## Version 1.8.2
Version 1.8.2 has the latest DISA templates (460) for SCAP scan matching up to August 28, 2022 as well as updated base images for web and service components for vulnerability issues.

## Version 1.8.1
Version 1.8.1 had some small fixes in it immediately after v1.8 went public:
* Fix the Nessus SCAP parser to pull results correctly
* Fix the msg-system consolidated code from msg-checklist to score new checklists correctly
* Please see the note on v1.8.0 release on updating the MongoDB compatibility before upgrading from 1.7.2 or earlier

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
