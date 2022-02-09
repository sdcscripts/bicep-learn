var locationsouth   = 'uksouth'
var southAddPrefix  = '192.168.0.0/16'
var southAddSubnet  = '192.168.0.0/24'
var southSubnetName = 'southsubnet'

var locationwest   = 'ukwest'
var westAddPrefix  = '172.16.0.0/16'
var westAddSubnet  = '172.16.1.0/24'
var westSubnetName = 'westsubnet'

resource southvn 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: 'southvn'
  location: locationsouth
  properties: {
    addressSpace: {
      addressPrefixes: [
        southAddPrefix
      ]
    }
    subnets: [
      {
        name: southSubnetName
        properties: {
          addressPrefix: southAddSubnet 
        }
      }
    ]
  }
}


resource westvn 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name:  'westvn'
  location: locationwest
  properties: {
    addressSpace: {
      addressPrefixes: [
        westAddPrefix
      ]
    }
    subnets: [
      {
        name: westSubnetName
        properties: {
          addressPrefix: westAddSubnet 
        }
      }
    ]
  }
}

