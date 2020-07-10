---
layout: default
title: Step 5 - Compliance Report
nav_order: 400
---

# Generating your System's Compliance Report

![OpenRMF Compliance Generator](/assets/compliance.png)

Running a compliance report across all your checklists is a gigantic effort when done manually! If you do this across all Checklist files using the Java Viewer this can be quite time consuming. Or you have to keep track of the data in yet another media format such as MS Word or Excel. 

When all your checklists are in OpenRMF, you can run a compliance report against the impact level (Low, Moderate, High) as well as the inclusion of personally identifiable information (PII) for your system. Choose your system and the pertinent details and click the Generate button. In a matter of seconds you have a listing of compliance against all your checklists for the relevant NIST controls. 

There is a summary presented that gives you an overall compliance by family. And below that there is a detailed view by control linked to the checklists. 


## Viewing Compliance Results

The data in the compliance report is presented in a filterable table that is common across OpenRMF. Pagination is in the bottom right corner and there is a search filter at the top right of the table as well to quickly find your information. 

![OpenRMF Compliance Details](/assets/compliance-detail.png)

Each result is listed per NIST major control and checklist and is color coded according to the overall status of that control within the checklist. Click on the checklist in the compliance result table to quickly view the checklist through the lens of *only* that control with a filtered vulnerability listing relevant only to that control. This allows you to view the vulnerability items that remain open or not reviewed to quickly tackle your RMF action items. 

## Compliance Color Coding Rules

For compliance, a green color means all the vulnerabilities for that control are either Not a Finding or marked as Not Applicable. If 1 vulnerability is marked as Open, then that whole group is Open. And if there are any vulnerabilities that are Not Reviewed with no Open vulnerabilities for that group, then the whole group is marked as Not Reviewed.