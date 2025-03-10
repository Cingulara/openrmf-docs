---
layout: default
title: ACAS / Patch Scanning
nav_order: 40
---

# Patch Management through Nessus / ACAS

You can do Patch Management through the Nessus / ACAS tool as well and import those into OpenRMF<sup>&reg;</sup> OSS. The Nessus application links to information such as the Windows Server Update Services, Red Hat Network Satellite Server, or Symantec Altiris for example and then scans your systems to see your patch compliance. If you have patches missing, it will notify you in a report showing the server or host, the patch, the issue, and the fix to perform. 

> Note: Patch scanning is not SCAP scanning. This tool scans for patches applied or missing, where the SCAP scan works with a baseline of security settings to know if your system is compliant with the security benchmarks used. This is a common question that comes up to the OpenRMF<sup>&reg;</sup> OSS team. 

## Patch Management Process
An example of using these scans in a patch management process would involve "Patch Tuesday" and "Patch Thursday". This is quite common in the DoD realms of IT administrators. Each Tuesday and Thursday known good security patches are applied to systems on the network. You then do an ACAS scan to get the results, make sure patches were applied, and note any systems that did not get the patch from a security update, policy update or manual update performed. 

The results of the scan will show you where you have critical, high, medium, and low risk patch issues and the overall risk and health status of those patches across your systems.

## Exporting Scan Results
Not everyone will have access to the Nessus server, even at a read-only level.  To view the results, you can export a `.nessus` file from the scan and import into OpenRMF<sup>&reg;</sup> OSS through the Systems page. This will show your Nessus patch data updated on the Dashboard / homepage as well as within the Systems and Reports pages. You can export to MS Excel or run reports and search/view the results of the scans across your whole system or per machine.

> Note: For OpenRMF<sup>&reg;</sup> OSS you must have a credentialed patch scan.

## More Information
See the <a href="https://docs.tenable.com/nessus/Content/PatchManagement.htm">https://docs.tenable.com/nessus/Content/PatchManagement.htm</a> site for more information.