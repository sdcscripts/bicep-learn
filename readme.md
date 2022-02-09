To deploy the bicep files above, ensure you have az cli tool installed (or use cloud shell) 

Create a resource group called RSVtest manually and then run the following comamnds: 

az deployment group create --resource-group RSVtest --template-file .\vnet.bicep   

az deployment group create --resource-group RSVtest --template-file .\vnet.bicep

bicep build vnet.bicep

This will deploy the vnets and then a VM attached to the south VM. 
Third command is an example of how to create the ARM template for a deployment should you need it (optional)