using 'main.bicep'

param environmentName = 'migrate'
param location = 'eastus'
param resourceGroupName = 'rg-migrate'

// Function runtime configuration
param functionAppRuntime = 'dotnet-isolated'
param functionAppRuntimeVersion = '8.0'

// User principal for dev/test RBAC access
param principalId = ''
