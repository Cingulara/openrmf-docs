---
layout: default
title: Using Checklists
nav_order: 40
---

# STIGs and STIG Checklists
The Checklists in this process are the results of SCAP scans, Evaluate-STIG scans  and manual processes to create information showing the security status of your system, application, network, host, firewall, server, etc. They are separate by topic such as Microsoft Windows 10, Oracle 12g, Application Security and Development, or CISCO firewall. The checklists have several (usually hundreds) of individual items describing a specific security setting/process/issue and allow you to specify 4 status: Open, Not a Finding (closed), Not Applicable and Not Reviewed. They also classify the security item as a Category 1 (high), Category 2 (medium) or Category 3 (low). Suffice it to say, the less High and Medium the better!

## The requirements of the STIGs become effective almost immediately
Be aware, new checklists come out usually quarterly but can come out in between major releases. As soon as a new checklist version is out you are usually responsible to use that one within a 30-day time period. Check with your cyber folks. It is not fair, it does not have to be, it is just how they do it. 

As new checklist formats and versions/revisions are added to OpenRMF<sup>&reg;</sup> OSS you will see an "Upgrade" button as you view your checklist. We wrote a routine to update and copy over your status, comments, findings, and security override information to the new version of the checklist. Otherwise, you are copying/pasting that information and it is HORRIBLE!

## STIG Checklist Templates
The templates to create these checklists are available at <a href="https://public.cyber.mil/stigs/downloads/" target="_blank">https://public.cyber.mil/stigs/downloads/</a>. They are grouped by topics such as Operating System (OS), Mobile, Application Security, etc. and then further grouped by particular software tool, application, or specific OS. These templates are available in a ZIP file and the specific file you will need in the zip is a "xxxxxx_Manual-xccdf.xml" file (i.e. U_MS_Windows_10_STIG_V1R23_Manual-xccdf.xml).  If you want to know more check out the https://csrc.nist.gov/projects/security-content-automation-protocol/specifications/xccdf site on XCCDF.

> This is a raw set of data, and is NOT a checklist file (CKL file). It must be read in and made into a checklist file.

You can import this file into the NIWC STIGViewer (see the URL below on Tutela's Medium blog post) and then create a checklist from it. Right now, if you are not creating a checklist from a SCAP scan this is the best way to create a checklist. An example of this would be the Application Security and Development (ASD) checklist you must create when you are developing a piece of software to run on a network. Whether a web application, static HTML pages, API, service, or something similar you will be required to do an ASD STIG. You can create a new one by adding the latest _Manual-xccdf.xml raw file to the NIWC STIGViewer and then create your checklist from that. 

## OpenRMF<sup>&reg;</sup> OSS Automatic Checklist Creation
If you are using a SCAP scan to create or update a checklist, all you have to do is Upload that XCCDF format scan result and the process of matching the SCAP scan results to the right checklist is done for you. OpenRMF<sup>&reg;</sup> OSS has 400+ checklist formats from DISA Public website in the tool to automatically match and create your checklist in seconds. Then put into your system and run the scoring, report generation, etc. against it automatically.


## STIGs and the DISA / NIWC STIG Viewer
There is a great Medium blog post by Tutela at <a href="https://medium.com/@dgould_43957/how-to-use-disa-stig-viewer-tool-907358d17cea" target="_blank">https://medium.com/@dgould_43957/how-to-use-disa-stig-viewer-tool-907358d17cea</a>. 
