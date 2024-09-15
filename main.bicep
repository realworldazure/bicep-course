@minLength(3)
@maxLength(24)
@description('Name of the storage account.')
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
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
  }
}

module auditStorageAccount 'modules/storage-account.bicep' = {
  name: 'deploy-${auditStorageAccountName}'
  params: {
    storageAccountName: auditStorageAccountName
    storageAccountSku: storageAccountSku
  }
}

output storageAccountName string = storageAccount.outputs.storageAccountName
output auditStorageAccountName string = auditStorageAccount.outputs.storageAccountName

output storageAccountId string = storageAccount.outputs.storageAccountId
output auditStorageAccountId string = auditStorageAccount.outputs.storageAccountId
