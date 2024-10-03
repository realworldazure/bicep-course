@description('Name of the storage account')
param storageAccountName string

@description('Id of the AD group for the role assignment')
param adGroupId string

@description('ID of the RBAC role definition')
param roleAssignmentId string

resource role 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: roleAssignmentId
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-04-01' existing = {
  name: storageAccountName
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(storageAccountName, role.id, adGroupId)
  scope: storageAccount
  properties: {
    principalId: role.id
    roleDefinitionId: adGroupId
  }
}
