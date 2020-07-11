---
layout: default
title: SCAP Scans Explained
nav_order: 20
---

# What is a SCAP Scan

SCAP stands for Security Content Automation Protocol.  SCAP scans compare the system you are scanning to a baseline (benchmark) which are open security standards of security to find compliance or non-compliance of system.   It uses specific standards to help organizations automate the way they monitor system vulnerabilities and make sure they're in compliance with security policies. More information on the SCAP tools and using the benchmarks in the SCAP scan process can be found at <a href="https://public.cyber.mil/stigs/scap/" target="_blank">https://public.cyber.mil/stigs/scap/</a>. 

## The SCAP Scan Process
The SCAP benchmarks are available as ZIP downloads on this site as well. The DISA SCAP scan is only available to those with a DoD CAC and can be downloaded from the DoD Cyber Exchange NIPR site. See the URL above for more information.  You use the benchmark files to load into the SCAP scanner and that allows the scan to match against good known security standards.  The results of a SCAP scan can be exported as an XCCDF format XML file and then imported into a Checklist using a tool such as STIG viewer or OpenRMF to create an actual checklist of findings.

Tennable's tool Nessus also has a SCAP scan capability for SCAP scans that covers a subset of the scans that the DISA SCAP Scanner can do. You also can export those files as XCCDF Format and import into OpenRMF to create a checklist of findings as well.

## Turning a SCAP Scan into a Checklist
A scan by itself is great, however it needs to be turned into a checklist to show proof and get actionable results. There are a couple ways to do this, as outlined in Tutela's Medium blog post at <a  href="https://medium.com/@dgould_43957/how-to-use-disa-stig-viewer-tool-907358d17cea" target="_blank">https://medium.com/@dgould_43957/how-to-use-disa-stig-viewer-tool-907358d17cea</a>.

The first way is is to export the scan as XCCDF format and import into the STIG Viewer 
(<a target="_blank" href="https://public.cyber.mil/stigs/srg-stig-tools/">https://public.cyber.mil/stigs/srg-stig-tools/</a>). You can import a SCAP scan and turn it into a checklist within the DISA STIG Viewer tool to see items that are Open, Not a Finding, or Not Reviewed from the scan. The checklists you make per system per tool or subject (i.e. one for MS Office, one for Windows 10, one for Windows defender, all on the same machine) are used as evidence of your security posture. You do this when going for compliance, security checks, or a DoD or Federal Government ATO to get your system or network connected to the infrastructure and in production.

![SCAP to Checklist](/assets/OpenRMF-SCAP-Process.png)

A second (read, BETTER!) way involves creating your checklist from the exported SCAP Scan in XCCDF and uploading into OpenRMF. If you use the Upload feature and upload a DISA or Nessus SCAP XCCDF xml file, OpenRMF will match the SCAP scan to the proper template inside OpenRMF and create your Checklist for you. Items matching the Open and Not a Finding will be done in the proper checklist file, the checklist is added to your System you upload into, and the results are available within seconds. You also will see the generated "score" of the total Category 1, 2, and 3 items grouped by their status. 

If you upload an updated SCAP scan, based on the type of benchmark and the hostname your results will be updated. Otherwise, this process creates a brand new checklist and adds it to the System you chose.

## Example of using a SCAP Scan
Understand that a SCAP scan “normally” will only have a subset of standards to perform on a system.   To really understand the security compliance of your system, you need to take the results and import them into a checklist file of the same product.  An example would be to perform a SCAP scan of a system using a Windows 10 Benchmark and then import the results into a Windows 10 checklist.  OpenRMF performs this function if you upload your SCAP scan results.  The checklist will have the full set of security compliance items and when you import the SCAP results it will update the blank checklist with its findings.  You will then go through the rest for applicability to your system.  There is an article on how to perform these actions using the SCAP scanner and STIG tool here .