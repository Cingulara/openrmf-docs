---
layout: default
title: OpenRMF Reports
nav_order: 600
---

# Available Reports in OpenRMF

Currently there are a few interactive reports in OpenRMF as pictured below. 

![OpenRMF Reports](/assets/reports.png)


## Nessus Scan Report
If you have a Nessus (*.nessus) ACAS scan result file imported for your system, this report will show all data in an interactive table. You can sort the columns, use the Search box to filter data, and click the + icon to see more/less of the detailed data per scan result item.

![OpenRMF Nessus Scan Report](/assets/reports-nessus-scan.png)


## System Score Chart
This is a larger chart used for exporting and viewing the total items in a system by status. The Open items are also further separated by Category 1, 2, and 3 specifically.

![OpenRMF System Score Chart](/assets/reports-system-charts.png)


## System Checklist Vulnerability Report
This reports allows you to select a system to load all available checklists. Choose an checklist and click the Run Report button to see all vulnerability data in an interactive table format. You can order columns, use the Search box to filter the information, and click the + icon to see more detailed information on the vulnerability.

![OpenRMF System Checklist Vulnerability Report](/assets/reports-checklists.png)


## RMF Controls Listing Report
This report lists out the controls and subcontrols across the RMF control listing to let you have more detailed information on what it represents. 

![OpenRMF Controls Report](/assets/reports-controls.png)


## System Checklist Vulnerability Report
This reports lets you search on a vulnerability and see what hosts and checklists have that vulnerability across all checklists within your system.

![OpenRMF Checklist Vulnerability Report](/assets/reports-vulnerabilities.png)


## System Checklist Vulnerability Report
This reports lets you search on a system and major RMF control and see what servers, workstations, devices, etc. relate to that control across all your checklists.

![OpenRMF RMF Controls by Host Report](/assets/reports-host-for-control.png)

## A Note on Refreshing Data

The Nessus Patch Listing and Host Vulnerability Report use the Report API and Report Database to return results quickly. The data is already formatted in a way for very fast retrieval, especially across systems with large numbers of checklists and Nessus Patch data. This data uses an "eventual consistency" pattern. When a new or updated checklist or scan is loaded into OpenRMF, a separate process is kicked off behind the scenes so you can get back to the OpenRMF interface. This process, as an example, pulls the Nessus ACAS Patch data report, parses the data, and puts separate records of the scan results into a particular MongoDB collection for later reporting. 

"Eventual" does not mean hours later! But it does mean you need to give it processing time. For scans of 4 or 5 machines we are talking a minute or two. For a large system of 100 hosts being scanned, the time required would be more on the lines of 15 minutes or so to process all the data. This of course depends on the amount of data in the scan, the type of scans, the amount of processing power you give OpenRMF and the amount of CPU and Memory in particular you give the Report Message client if you are running something like Kubernetes.

Only Administrators can run this. And it is only needed if you want to force a refresh, if you are upgrading from a version before 0.14 and need the data initially loaded, or if your data or system is interrupted and corrupted and you want to ensure the data is right. Right now only those 2 reports use the Report API and database with eventual consistency. There may be more in the future. To learn more about this design choice see https://martinfowler.com/articles/microservice-trade-offs.html.

![Refreshing OpenRMF Report Data](/assets/refresh-report-data.png)
