@description('Location of the storage account')
param location string

@description('Tags used in the module')
param tags object = {
  Environment: 'Development'
  Owner: 'RealWorldAzure'
}

@minLength(3)
@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

@minLength(3)
@maxLength(24)
@description('Name of the audit storage account')
param auditStorageAccountName string

@allowed([
  'Standard_LRS'
])
@description('Name of the storage account SKU.')
param storageAccountSku string

module storageAccount 'modules/storage-account.bicep' = {
  name: 'deploy-${storageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
  }
}

var auditStorageAccountContainers = [
  'data'
  'logs'
  'archive'
]

module auditStorageAccount 'modules/storage-account.bicep' = {
  name: 'deploy-${auditStorageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: auditStorageAccountName
    storageAccountSku: storageAccountSku
    containerNames: auditStorageAccountContainers
  }
}

output storageAccountName string = storageAccount.outputs.storageAccountName
output auditStorageAccountName string = auditStorageAccount.outputs.storageAccountName

output storageAccountId string = storageAccount.outputs.storageAccountId
output auditStorageAccountId string = auditStorageAccount.outputs.storageAccountId
