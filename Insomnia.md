# Examples of calling the API with Insomnia

Upload a .CKL file and metadata to save the data and send a save publishing message to score the new checklist.
![Image](./img/openStigUpload.png?raw=true)

Read a STIG checklist entry list, a single entry, or download a checklist. Pass in the Accept header for application/json or application/xml. The JAVA DISA tool needs XML.
![Image](./img/openStigRead.png?raw=true)

Save a checklist by posting metadata and the raw checklist, NOT the file. The File one is Upload. I don't use this much yet but if we needed to save a whole checklist in a form this could work. HEAVY but can work.
![Image](./img/openStigSave.png?raw=true)

Read the Score (number of open / not a finding / not applicable / not reviewed) of a checklist per category 1, 2, and 3. There are totals in here as well when you read them. This is done automagically from the msg-score subscribing microservice using NATS. 
![Image](./img/openStigScore.png?raw=true)

Save and list/get a template for a checklist. This is really used to store a baseline of a checklist and have that as a starting point. You could do this as a sysadmin or SRE to say "our IaaS or PaaS has all these checks approved, so start with that and add your specifics in here".
![Image](./img/openStigTemplate.png?raw=true)
