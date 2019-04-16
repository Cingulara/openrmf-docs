db.createUser({ user: "openrmf" , pwd: "openrmf1234!", roles: [{ "role": "readWrite", "db": "openrmf"}]});
db.createCollection("Artifacts");