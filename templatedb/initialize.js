db.createUser({ user: "openstigtemplate" , pwd: "openstig1234!", roles: [{ "role": "readWrite", "db": "openstigtemplate"}]});
db.createCollection("Templates");