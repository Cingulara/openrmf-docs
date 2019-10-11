db.createUser({ user: "openrmftemplate" , pwd: "openrmf1234!", roles: [{ "role": "readWrite", "db": "openrmftemplate"}]});
db.createCollection("Templates");