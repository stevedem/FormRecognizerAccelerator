param function_app_name string
param storage_account_name string
param location string = resourceGroup().location
var app_insights_name = function_app_name
var appservice_plan_name = function_app_name

resource storage_account 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storage_account_name
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_ZRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

resource app_insights 'Microsoft.Insights/components@2015-05-01' = {
  name: app_insights_name
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

resource appservice_plan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appservice_plan_name
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
}

resource function_app 'Microsoft.Web/sites@2020-12-01' = {
  name: function_app_name
  location: location
  kind: 'functionapp'
  dependsOn: [
    storage_account
    appservice_plan
    app_insights
  ]
  properties: {
    serverFarmId: appservice_plan.id
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: concat('DefaultEndpointsProtocol=https;AccountName=', storage_account.name, ';AccountKey=', listKeys(storage_account.id, '2019-06-01').keys[0].value)
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: reference(app_insights.id, '2015-05-01').InstrumentationKey
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '~14'
        }
      ]
    }
  }
}
