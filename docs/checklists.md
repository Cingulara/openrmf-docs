---
title: Step 3 - View Checklists
nav_order: 300
has_children: true
---

# Viewing your Systems and Checklists

![OpenRMF System List](/assets/system-listing.png)

The System listing is available when you log in and click on Checklists in the menu. The above screen loads if there are any checklists loaded. FOr now, this is a fairly simple page with the System Name and number of checklists. Improvements on this page will be made in future releases.

Note: if no checklists are loaded then you are automatically redirected to the Upload page.

![OpenRMF Checklist List](/assets/checklist-listing.png)

On the Systems listing page click the button next to the system with the checklists and you will be taken to a table listing all checklists. The initial page shows 50 at a time and has pagination at the bottom right of the screen. There is also a filter you can type into and automatically filter the listing of checklists for that system. 

Each row of the listing shows the total count of items per checklist by status of Not a Finding, Not Applicable, Open, and Not Reviewed. Click the green plus sign to the left and that total number is broken down by item category. The last update date is also listed. Click the linked title to view the detailed record of the checklist.

## Checklist Detailed View

![OpenRMF Checklist Details](/assets/checklist-record.png)

The detailed Checklist page shows several things about the checklist. It shows the title, automatically named by the checklist uploaded. The format is "hostname"-"type of checklist"-"release and date of the checklist format". So a Windows 10 STIG from the Release 19 Oct 25 2019 of the STIG of the machine named "myserver" would be "MYSERVER-WIN 10 STIG-R19 dated 25 Oct 2019". 

The scoring of the checklist based on status is one of the first things you see as well. The total and then breakdown by category is shown with the relevant colors. There are also download links for the CKL file, an Excel version of the checklist to download, as well as a Delete button. These buttons depend on the Download role and Editor role respectively. Or if you have the Administrator role you get them all. 

![OpenRMF Checklist Vulnerability Details](/assets/checklist-record-detail.png)

The specific STIG title and asset information from the STIG checklist are shown next. Then the main section of the checklist is shown. On the left of the section is a list of every single vulnerability for this checklist, color coded by status. Click the vulnerability and the details of it show on the right.  You also can filter the vulnerabilities by status by checking / unchecking the 4 statuses to filter the list down accordingly.

At the bottom of this page are quick visual graph representations of the status and category breakdown of the checklist as well. 