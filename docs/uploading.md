---
title: Step 1 - Uploading
nav_order: 100
---

# Uploading Checklists and Templates

The Upload page is available to users with the Administrator or Editor role assigned. From this page you can upload a CKL checklist file made from the DISA Java Viewer. You can upload a SCAP scan result in XCCDF XML format. Or you can upload a CKL file as a User Template for others to start from and create their checklist for the appropriate system technology. 

## Upload Checklists or SCAP XCCDF files

![OpenRMF Upload of Checklists](/assets/upload-checklist-xccdf.png)

To upload a CKL file or XCCDF SCAP scan result file go to the Upload page. Use the top section to choose a System name and the file. You can now upload up to 10 files at a time. You can choose all 10 at once, or do 1 file at a time with the Choose Files button. 

If your system is not listed, click the "Add a n ew System" link and type in the System name. Then attach your files and click the Upload and Save button. 

When you upload your files, you will receive a confirmation of the files loading correctly or not. If all works well, the files are saved into the database. And a separate event is fired off to read and "score" the checklist you uploaded to keep track of the number of items by status by category. These are the numbers that show up when you list your checklist. 

If you upload an XCCDF XML DISA SCAP scan result file, that file is matched to internal System Templates from DISA's known good checklists. That checklist is filled in with `pass` or `fail` items from the SCAP scan accordingly. Any vulnerability item not found within the scan is kept as Not Reviewed. This new checklist file is then saved into the database and the scoring process kicks off for it. 

## Uploading Templates

![OpenRMF Upload of Templates](/assets/upload-template.png)

You can upload a checklist file as a Template to start from within the system as well. You can use Templates in OpenRMF for a starting point for your checklists. A great example would be you have an infrastructure package and a platform-as-a-service package that your application(s) run on. That infrastructure and PaaS have known good checklists as a baseline that application owners use as a starting point and adjust the remaining vulnerability items accordingly.  IT personnel would download this template and then fill out remaining items based on their software or system.

To upload you go to the Template Upload section and enter a title and description for the template. Then lcick the Choose file and upload the template. You can only upload one template at a time. 