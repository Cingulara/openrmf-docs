db.createUser({ user: "openrmfreport" , pwd: "openrmf1234!", roles: [{ "role": "readWrite", "db": "openrmfreport"}]});
db.createCollection("ACASScanReport");
db.ACASScanReport.createIndex({ reportName: 1 })
db.ACASScanReport.createIndex({ hostname: 1 })
db.ACASScanReport.createIndex({ pluginId: 1 })
db.ACASScanReport.createIndex({ pluginName: 1 })
db.ACASScanReport.createIndex({ pluginType: 1 })
db.ACASScanReport.createIndex({ severity: -1 })
db.ACASScanReport.createIndex({ riskFactor: 1 })
db.createCollection("VulnerabilityReport");
db.VulnerabilityReport.createIndex({ vulnid: 1 })
db.VulnerabilityReport.createIndex({ hostname: 1 })
db.VulnerabilityReport.createIndex({ severityCategory: 1 })
db.VulnerabilityReport.createIndex({ status: 1 })
db.VulnerabilityReport.createIndex({ ruleTitle: 1 })
db.VulnerabilityReport.createIndex({ checklistType: 1 })
