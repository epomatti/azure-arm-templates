resourceGroupName="your-resource-group-name"
location="eastus2"

templateFile="azuredeploy.json"

storageName="st888999arm"
storageSku="Standard_GRS"
storageKind="StorageV2"
vmSize="Standard_A2_v2"

az login
az group create --name $resourceGroupName --location $location

az deployment group create \
  --name DeployLocalTemplate \
  --resource-group $resourceGroupName \
  --template-file $templateFile \
  --parameters \
  storageName=$storageName \
  storageSku=$storageSku \
  storageKind=$storageKind \
  vmSize=$vmSize \
  --verbose
