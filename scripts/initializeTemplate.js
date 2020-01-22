db.createUser({ user: "openrmftemplate" , pwd: "openrmf1234!", roles: [{ "role": "readWrite", "db": "openrmftemplate"}]});
db.createCollection("Templates");
db.Templates.createIndex({ stigType: 1 })
db.Templates.createIndex({ templateType: 1 })