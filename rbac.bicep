// RBAC Role Assignments using Azure Verified Modules (AVM)
// This module assigns the necessary permissions for the Function App's system-assigned managed identity
// and optionally for a user identity for development/testing scenarios

param storageAccountName string
param appInsightsName string
param managedIdentityPrincipalId string
param userIdentityPrincipalId string = ''
param allowUserIdentityPrincipal bool = false

var roleDefinitions = {
  storageBlobDataOwner: 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'
  storageQueueDataContributor: '974c5e8b-45b9-4653-ba55-5f855dd0fb88'
  storageTableDataContributor: '0a9a7e1f-b9d0-4cc4-a60d-0319b160aaa3'
  monitoringMetricsPublisher: '3913510d-42f4-4e42-8a64-420c390055eb'
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: storageAccountName
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: appInsightsName
}

// Storage Blob Data Owner - System Identity
module storageRoleAssignment 'br/public:avm/ptn/authorization/resource-role-assignment:0.1.2' = if (!empty(managedIdentityPrincipalId)) {
  name: 'storageRoleAssignment-${uniqueString(storageAccount.id, managedIdentityPrincipalId)}'
  params: {
    resourceId: storageAccount.id
    roleDefinitionId: roleDefinitions.storageBlobDataOwner
    principalId: managedIdentityPrincipalId
    principalType: 'ServicePrincipal'
    description: 'Storage Blob Data Owner role for Function App system-assigned managed identity'
    roleName: 'Storage Blob Data Owner'
  }
}

// Storage Blob Data Owner - User Identity
module storageRoleAssignment_User 'br/public:avm/ptn/authorization/resource-role-assignment:0.1.2' = if (allowUserIdentityPrincipal && !empty(userIdentityPrincipalId)) {
  name: 'storageRoleAssignment-User-${uniqueString(storageAccount.id, userIdentityPrincipalId)}'
  params: {
    resourceId: storageAccount.id
    roleDefinitionId: roleDefinitions.storageBlobDataOwner
    principalId: userIdentityPrincipalId
    principalType: 'User'
    description: 'Storage Blob Data Owner role for user identity (development/testing)'
    roleName: 'Storage Blob Data Owner'
  }
}

// Storage Queue Data Contributor - System Identity
module queueRoleAssignment 'br/public:avm/ptn/authorization/resource-role-assignment:0.1.2' = if (!empty(managedIdentityPrincipalId)) {
  name: 'queueRoleAssignment-${uniqueString(storageAccount.id, managedIdentityPrincipalId)}'
  params: {
    resourceId: storageAccount.id
    roleDefinitionId: roleDefinitions.storageQueueDataContributor
    principalId: managedIdentityPrincipalId
    principalType: 'ServicePrincipal'
    description: 'Storage Queue Data Contributor role for Function App system-assigned managed identity'
    roleName: 'Storage Queue Data Contributor'
  }
}

// Storage Queue Data Contributor - User Identity
module queueRoleAssignment_User 'br/public:avm/ptn/authorization/resource-role-assignment:0.1.2' = if (allowUserIdentityPrincipal && !empty(userIdentityPrincipalId)) {
  name: 'queueRoleAssignment-User-${uniqueString(storageAccount.id, userIdentityPrincipalId)}'
  params: {
    resourceId: storageAccount.id
    roleDefinitionId: roleDefinitions.storageQueueDataContributor
    principalId: userIdentityPrincipalId
    principalType: 'User'
    description: 'Storage Queue Data Contributor role for user identity (development/testing)'
    roleName: 'Storage Queue Data Contributor'
  }
}

// Storage Table Data Contributor - System Identity
module tableRoleAssignment 'br/public:avm/ptn/authorization/resource-role-assignment:0.1.2' = if (!empty(managedIdentityPrincipalId)) {
  name: 'tableRoleAssignment-${uniqueString(storageAccount.id, managedIdentityPrincipalId)}'
  params: {
    resourceId: storageAccount.id
    roleDefinitionId: roleDefinitions.storageTableDataContributor
    principalId: managedIdentityPrincipalId
    principalType: 'ServicePrincipal'
    description: 'Storage Table Data Contributor role for Function App system-assigned managed identity'
    roleName: 'Storage Table Data Contributor'
  }
}

// Storage Table Data Contributor - User Identity
module tableRoleAssignment_User 'br/public:avm/ptn/authorization/resource-role-assignment:0.1.2' = if (allowUserIdentityPrincipal && !empty(userIdentityPrincipalId)) {
  name: 'tableRoleAssignment-User-${uniqueString(storageAccount.id, userIdentityPrincipalId)}'
  params: {
    resourceId: storageAccount.id
    roleDefinitionId: roleDefinitions.storageTableDataContributor
    principalId: userIdentityPrincipalId
    principalType: 'User'
    description: 'Storage Table Data Contributor role for user identity (development/testing)'
    roleName: 'Storage Table Data Contributor'
  }
}

// Monitoring Metrics Publisher - System Identity
module appInsightsRoleAssignment 'br/public:avm/ptn/authorization/resource-role-assignment:0.1.2' = if (!empty(managedIdentityPrincipalId)) {
  name: 'appInsightsRoleAssignment-${uniqueString(applicationInsights.id, managedIdentityPrincipalId)}'
  params: {
    resourceId: applicationInsights.id
    roleDefinitionId: roleDefinitions.monitoringMetricsPublisher
    principalId: managedIdentityPrincipalId
    principalType: 'ServicePrincipal'
    description: 'Monitoring Metrics Publisher role for Function App system-assigned managed identity'
    roleName: 'Monitoring Metrics Publisher'
  }
}

// Monitoring Metrics Publisher - User Identity
module appInsightsRoleAssignment_User 'br/public:avm/ptn/authorization/resource-role-assignment:0.1.2' = if (allowUserIdentityPrincipal && !empty(userIdentityPrincipalId)) {
  name: 'appInsightsRoleAssignment-User-${uniqueString(applicationInsights.id, userIdentityPrincipalId)}'
  params: {
    resourceId: applicationInsights.id
    roleDefinitionId: roleDefinitions.monitoringMetricsPublisher
    principalId: userIdentityPrincipalId
    principalType: 'User'
    description: 'Monitoring Metrics Publisher role for user identity (development/testing)'
    roleName: 'Monitoring Metrics Publisher'
  }
}
