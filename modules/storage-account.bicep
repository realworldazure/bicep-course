@description('Location of the resources.')
param location string = 'northeurope'

@description('Tags for the storage account.')
param tags object = {
  Environment: 'Development'
  Owner: 'RealWorldAzure'
}

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

output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
