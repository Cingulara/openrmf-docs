db = db.getSiblingDB('admin');
db.createUser({ user: "openrmf" , pwd: "openrmf1234!", roles: ["readWriteAnyDatabase"]});
db.createUser({ user: "openrmftemplate" , pwd: "openrmf1234!", roles: ["readWriteAnyDatabase"]});
db.createUser({ user: "openrmfscore" , pwd: "openrmf1234!", roles: ["readWriteAnyDatabase"]});
db.createUser({ user: "openrmfaudit" , pwd: "openrmf1234!", roles: ["readWriteAnyDatabase"]});
db.createUser({ user: "openrmfreport" , pwd: "openrmf1234!", roles: ["readWriteAnyDatabase"]});
db = db.getSiblingDB('openrmf');
db.createCollection("Artifacts");
db.Artifacts.createIndex({ systemGroupId: 1 })
db.Artifacts.createIndex({ stigType: 1 })
db.Artifacts.createIndex({ stigRelease: 1 })
db.Artifacts.createIndex({ version: 1 })
db.Artifacts.createIndex({ hostName: 1 })
db.Artifacts.createIndex({ created: -1 })
db.Artifacts.createIndex({ updatedOn: -1 })
db.createCollection("SystemGroups");
db.SystemGroups.createIndex({ title: 1 })
db.SystemGroups.createIndex({ created: -1 })
db.SystemGroups.createIndex({ updatedOn: -1 })
db.SystemGroups.createIndex({ numberOfChecklists: 1 })
db = db.getSiblingDB('openrmftemplate');
db.createCollection("Templates");
db.Templates.createIndex({ stigType: 1 })
db.Templates.createIndex({ templateType: 1 })
db.Templates.createIndex({ stigRelease: 1 })
db.Templates.createIndex({ version: 1 })
db.Templates.createIndex({ created: -1 })
db.Templates.createIndex({ updatedOn: -1 })
db.Templates.createIndex({ stigId: 1 })
db.Templates.createIndex({ title: 1 })
db = db.getSiblingDB('openrmfscore');
db.createCollection("Scores");
db.Scores.createIndex({ artifactId: 1 })
db.Scores.createIndex({ systemGroupId: 1 })
db.Scores.createIndex({ hostName: 1 })
db.Scores.createIndex({ stigType: 1 })
db.Scores.createIndex({ created: -1 })
db.Scores.createIndex({ updatedOn: -1 })
db.Scores.createIndex({ totalCat1Open: 1 })
db.Scores.createIndex({ totalCat1NotApplicable: 1 })
db.Scores.createIndex({ totalCat1NotAFinding: 1 })
db.Scores.createIndex({ totalCat1NotReviewed: 1 })
db.Scores.createIndex({ totalCat2Open: 1 })
db.Scores.createIndex({ totalCat2NotApplicable: 1 })
db.Scores.createIndex({ totalCat2NotAFinding: 1 })
db.Scores.createIndex({ totalCat2NotReviewed: 1 })
db.Scores.createIndex({ totalCat3Open: 1 })
db.Scores.createIndex({ totalCat3NotApplicable: 1 })
db.Scores.createIndex({ totalCat3NotAFinding: 1 })
db.Scores.createIndex({ totalCat3NotReviewed: 1 })
db = db.getSiblingDB('openrmfaudit');
db.createCollection("Audits");
db.Audits.createIndex({ created: -1 })
db.Audits.createIndex({ username: 1 })
db.Audits.createIndex({ program: 1 })
db.Audits.createIndex({ action: 1 })
db = db.getSiblingDB('openrmfreport');
db.createCollection("ACASScanReport");
db.ACASScanReport.createIndex({ reportName: 1 })
db.ACASScanReport.createIndex({ hostname: 1 })
db.ACASScanReport.createIndex({ pluginId: 1 })
db.ACASScanReport.createIndex({ pluginName: 1 })
db.ACASScanReport.createIndex({ pluginType: 1 })
db.ACASScanReport.createIndex({ severity: -1 })
db.ACASScanReport.createIndex({ riskFactor: 1 })
db.ACASScanReport.createIndex({ created: -1 })
db.ACASScanReport.createIndex({ updatedOn: -1 })
db.ACASScanReport.createIndex({ operatingSystem: 1 })
db.ACASScanReport.createIndex({ family: 1 })
db.ACASScanReport.createIndex({ systemGroupId: 1 })
db.createCollection("VulnerabilityReport");
db.VulnerabilityReport.createIndex({ vulnid: 1 })
db.VulnerabilityReport.createIndex({ hostname: 1 })
db.VulnerabilityReport.createIndex({ severityCategory: 1 })
db.VulnerabilityReport.createIndex({ status: 1 })
db.VulnerabilityReport.createIndex({ ruleTitle: 1 })
db.VulnerabilityReport.createIndex({ checklistType: 1 })
db.VulnerabilityReport.createIndex({ created: -1 })
db.VulnerabilityReport.createIndex({ updatedOn: -1 })
db.VulnerabilityReport.createIndex({ severityOverride: 1 })
db.VulnerabilityReport.createIndex({ systemGroupId: 1 })
db.VulnerabilityReport.createIndex({ artifactId: 1 })
db.VulnerabilityReport.createIndex({ severity: 1 })
