@description('Location of the resources.')
param location string = 'northeurope'

@minLength(3)
@maxLength(24)
@description('Name of the storage account.')
param storageAccountName string = 'ststorageaccountdrdev'

@minLength(3)
@maxLength(24)
@description('Name of the audit storage account')
param auditStorageAccountName string = 'stauditbicepdrdev'

var storageKind = 'StorageV2'
var minimumTlsVersion = 'TLS1_2'
var supportsHttpsTrafficOnly = true

@allowed([
  'Standard_LRS'
])
@description('Name of the storage account SKU.')
param storageAccountSku string

// string
var myFirstString = 'mystring${storageAccountName }'
var lowerCase = toLower(myFirstString)
var upperCase = toUpper(myFirstString)
var trimmed = trim(' spaces ')
var sub = substring(trimmed, 0 ,2)
var myInteger = int('10')
var myString = string(10)

// arrays
var myArray = [
  'myString'
  'myOtherString'
]

var mySecondArray = [
  'mySecondString'
  'mySecondOtherString'
]


var combinedArray = concat(myArray, mySecondArray)
var firstElement = first(myArray)
var arrayContains = contains(myArray, 'myString')
var isArrayEmpty  = empty(myArray)

var splitString = split('header1,header2,header3', ',')


//data conversions
var myBool = bool('true')

// scope functions
var myResourceGroupName = resourceGroup().name
var subscriptionId = subscription().id

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageKind
  properties: {
    minimumTlsVersion: minimumTlsVersion
    supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
  }
}

var storageAccountKey = storageAccount.listKeys().keys[0]

// Load json
var loadedJson = loadJsonContent('example.json')
var jsonContent = loadedJson.storageAccounts[0].name

resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: auditStorageAccountName
  location: 'northeurope'
  sku: {
    name: storageAccountSku
  }
  kind: storageKind
    properties: {
      minimumTlsVersion: minimumTlsVersion
      supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
    }
}

output storageAccountName string = storageAccount.name
output auditStorageAccountName string = auditStorageAccount.name

output storageAccountId string = storageAccount.id
output auditStorageAccountId string = auditStorageAccount.id
