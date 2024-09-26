@description('Location of the resources.')
param location string = 'northeurope'

@description('Tags for the storage account.')
param tags object = {
  Environment: 'Development'
  Owner: 'RealWorldAzure'
}

@description('The type of storage account')
@allowed([
  'BlobStorage'
  'StorageV2'
])
param storageAccountKind string = 'StorageV2'

@minLength(3)
@maxLength(24)
@description('Name of the storage account.')
param storageAccountName string

@description('Supports HTTPs Traffic Only')
param supportsHttpsTrafficOnly bool = true

@description('Name of the storage account SKU.')
@allowed([
  'Standard_LRS'
])
param storageAccountSku string

@description('Name of the containers to deploy')
param containerNames array = []

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  tags: tags
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
  }
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  name: 'default'
  parent: storageAccount
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: 'data1'
  parent: blobServices
  properties: {
    publicAccess: 'None'
  }
}

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = [for containerName in containerNames: {
  name: containerName 
  parent: blobServices
  properties: {
    publicAccess: 'None'
  }
}]

output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
