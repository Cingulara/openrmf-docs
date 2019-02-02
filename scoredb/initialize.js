db.createUser({ user: "openstigscore" , pwd: "openstig1234!", roles: [{ "role": "readWrite", "db": "openstigscore"}]});
db.createCollection("Scores");