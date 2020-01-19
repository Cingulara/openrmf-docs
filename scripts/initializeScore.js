db.createUser({ user: "openrmfscore" , pwd: "openrmf1234!", roles: [{ "role": "readWrite", "db": "openrmfscore"}]});
db.createCollection("Scores");
db.Scores.createIndex({ artifactId: 1 })
db.Scores.createIndex({ systemGroupId: 1 })
db.Scores.createIndex({ hostName: 1 })