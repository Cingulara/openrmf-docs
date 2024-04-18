# Add Template indexes
docker exec mongodb-template mongo --username root --password "$1" --eval "db = db.getSiblingDB('openrmftemplate'); db.Templates.createIndex({ created: -1 }); db.Templates.createIndex({ updatedOn: -1 }); db.Templates.createIndex({ stigId: 1 }); db.Templates.createIndex({ title: 1 });"