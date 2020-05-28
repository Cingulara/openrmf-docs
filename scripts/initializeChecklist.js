db.createUser({ user: "openrmf" , pwd: "openrmf1234!", roles: [{ "role": "readWrite", "db": "openrmf"}]});
db.createCollection("Artifacts");
db.Artifacts.createIndex({ systemGroupId: 1 })
db.Artifacts.createIndex({ stigType: 1 })
db.Artifacts.createIndex({ stigRelease: 1 })
db.Artifacts.createIndex({ version: 1 })
db.createCollection("SystemGroups");
db.SystemGroups.createIndex({ title: 1 })