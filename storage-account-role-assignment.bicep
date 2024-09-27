@description('Name of the storage account')
param storageAccountNames array 

@description('Id of the AD group for the role assignment')
param adGroupId string

@description('ID of the RBAC role definition')
param roleAssignmentId string

resource role 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: roleAssignmentId
}

resource storageAccounts 'Microsoft.Storage/storageAccounts@2023-04-01' existing = [for storageAccountName in storageAccountNames: {
  name: storageAccountName
}]

resource roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for i in range(0,length(storageAccountNames)): {
  name: guid(storageAccounts[i].id, role.id, adGroupId)
  scope: storageAccounts[i]
  properties: {
    principalId: role.id
    roleDefinitionId: adGroupId
}
]

var roleName = role.name

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid( storageAccountName, role.id, adGroupId)
  scope: storageAccount
  properties: {
    principalId: role.id
    roleDefinitionId: adGroupId

  }
}
