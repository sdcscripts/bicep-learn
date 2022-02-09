var location = resourceGroup().location
param HostVmSize string = 'Standard_D2_v3'
param VmAdminUsername string = 'localadmin'

var VmAdminPassword = 'secure!:password!123h'
var storageAccountName = '${uniqueString(resourceGroup().id)}'

resource southnic 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: 'southnic1'
  location: location
  properties: {
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {

          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '/subscriptions/ea944c3e-a8ae-4f9b-b272-c11ec4b79ff4/resourceGroups/RSVtest/providers/Microsoft.Network/virtualNetworks/southvn/subnets/southsubnet'
          }
        }
      }
    ]
  }
}

resource VM 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: 'southvm'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: HostVmSize
    }
    osProfile: {
      computerName: 'southvm'
      adminUsername: VmAdminUsername
      adminPassword: VmAdminPassword
    }
    storageProfile: {
      imageReference: {
        
        publisher: 'canonical'
        offer    : '0001-com-ubuntu-server-focal'
        sku      : '20_04-lts'
        version  : 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: null
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: southnic.id
          }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: stg.properties.primaryEndpoints.blob
      }
    }
  }
}

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}

