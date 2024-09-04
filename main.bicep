resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'ststorageaccountdrdev'
  location: 'northeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'stauditbicepdrdev'
  location: 'northeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
    properties: {
      minimumTlsVersion: 'TLS1_2'
      supportsHttpsTrafficOnly: true
    }
}
