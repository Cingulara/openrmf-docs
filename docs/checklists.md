---
title: Step 4 - View Checklists
nav_order: 350
---

# Checklist Detailed View

![OpenRMF Checklist Details](/assets/checklist-record.png)

The detailed Checklist page shows several things about the checklist. It shows the title, automatically named by the checklist uploaded. The format is "hostname"-"type of checklist"-"release and date of the checklist format". So a Windows 10 STIG from the Release 19 Oct 25 2019 of the STIG of the machine named "myserver" would be "MYSERVER-WIN 10 STIG-R19 dated 25 Oct 2019". 

The scoring of the checklist based on status is one of the first things you see as well. The total and then breakdown by category is shown with the relevant colors. There are also download links for the CKL file, an Excel version of the checklist to download, as well as a Delete button. These buttons depend on the Download role and Editor role respectively. Or if you have the Administrator role you get them all. 

Each listing in the score table are linked to the Vulnerability Filter below it. For example, click the CAT 1 OPEN number, and you can filter your vulnerabilities below to only show Category 1 (High severity) Open items. This also affects the Export as you will export only those vulnerabilities shown on the page at that time. 

![OpenRMF Checklist Vulnerability Details](/assets/checklist-record-detail.png)

The specific STIG title and asset information from the STIG checklist are shown next. Then the main section of the checklist is shown. On the left of the section is a list of every single vulnerability for this checklist, color coded by status. Click the vulnerability and the details of it show on the right.  You also can filter the vulnerabilities by status by checking / unchecking the 4 statuses to filter the list down accordingly.

At the bottom of this page are quick visual graph representations of the status and category breakdown of the checklist as well. 

## Editing the Checklist Vulnerability

With the 0.12 version OpenRMF, if you are an Editor or Administrator (role) you can edit the main Checklist data at the top of the screen. The host name, domain name as well as the technology area, asset type and role of the machine for the checklist being viewed/edited. This data will be represented in the downloaded export XLSX as well as the CKL checklist file.

![OpenRMF Edit Checklist Metadata](/assets/checklist-edit-asset.png)

You also can edit each Vulnerability record with those roles. The following fields in the image below can be edited. Once saved, the data in the checklist is updated and the score is recalculated for the checklist and subsequently the system. 

![OpenRMF Edit Checklist Vulnerability Details](/assets/checklist-edit-vulnerability.png)