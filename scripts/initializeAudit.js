db.createUser({ user: "openrmfaudit" , pwd: "openrmf1234!", roles: [{ "role": "readWrite", "db": "openrmfaudit"}]});
db.createCollection("Audits");