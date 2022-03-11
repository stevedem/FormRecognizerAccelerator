@description('The environment suffix to append to resource names.')
param environmentPrefix string = ''

@description('The image storage account name.')
param imageStorageAccountName string = 'formrecognizerimg'

@description('The function application storage account name.')
param functionAppStorageAccountName string = 'formrecognizerfnc'

@description('The environment prefix to append to resource names.')
param functionAppName string = 'form-recognizer-fnc'

// Resource names
var imageStorageAccountResourceName = '${environmentPrefix}${imageStorageAccountName}'
var functionAppStorageAccountResourceName = '${environmentPrefix}${functionAppStorageAccountName}'
var functionAppResourceName = '${environmentPrefix}-${functionAppName}'

// Storage Account
module sa 'storage-account.bicep' = {
  name: 'sa'
  params: {
    storageAccountName: imageStorageAccountResourceName
  }
}

// Function
module function 'function.bicep' = {
  name: 'functionDeploy'
  params: {
    function_app_name: functionAppResourceName
    storage_account_name: functionAppStorageAccountResourceName
  }
}
