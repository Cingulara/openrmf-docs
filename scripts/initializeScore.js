db.createUser({ user: "openrmfscore" , pwd: "openrmf1234!", roles: [{ "role": "readWrite", "db": "openrmfscore"}]});
db.createCollection("Scores");