db = db.getSiblingDB('admin');
db.createUser({ user: "openrmf" , pwd: "openrmf1234!", roles: ["readWriteAnyDatabase"]});
db.createUser({ user: "openrmftemplate" , pwd: "openrmf1234!", roles: ["readWriteAnyDatabase"]});
db.createUser({ user: "openrmfscore" , pwd: "openrmf1234!", roles: ["readWriteAnyDatabase"]});
db.createUser({ user: "openrmfaudit" , pwd: "openrmf1234!", roles: ["readWriteAnyDatabase"]});
db = db.getSiblingDB('openrmf');
db.createCollection("Artifacts");
db.Artifacts.createIndex({ systemGroupId: 1 })
db.Artifacts.createIndex({ stigType: 1 })
db.Artifacts.createIndex({ stigRelease: 1 })
db.Artifacts.createIndex({ version: 1 })
db.createCollection("SystemGroups");
db.SystemGroups.createIndex({ title: 1 })
db = db.getSiblingDB('openrmftemplate');
db.createCollection("Templates");
db.Templates.createIndex({ stigType: 1 })
db.Templates.createIndex({ templateType: 1 })
db.Templates.createIndex({ stigRelease: 1 })
db.Templates.createIndex({ version: 1 })
db = db.getSiblingDB('openrmfscore');
db.createCollection("Scores");
db.Scores.createIndex({ artifactId: 1 })
db.Scores.createIndex({ systemGroupId: 1 })
db.Scores.createIndex({ hostName: 1 })
db.Scores.createIndex({ stigType: 1 })
db = db.getSiblingDB('openrmfaudit');
db.createCollection("Audits");
db.Audits.createIndex({ created: -1 })
db.Audits.createIndex({ username: 1 })
db.Audits.createIndex({ program: 1 })
db.Audits.createIndex({ action: 1 })