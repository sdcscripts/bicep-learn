var location = resourceGroup().location

resource rsv1 'Microsoft.RecoveryServices/vaults@2021-08-01' = {
  name: 'rsv1'
  location: location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

resource rsv1storage 'Microsoft.RecoveryServices/vaults/backupstorageconfig@2021-10-01' = {
  name: '${rsv1.name}/vaultstorageconfig'
  properties: {
     storageModelType: 'LocallyRedundant'
  } 
}

