db.createUser({ user: "openstig" , pwd: "openstig1234!", roles: [{ "role": "readWrite", "db": "openstig"}]});
db.createCollection("Artifacts");