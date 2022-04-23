$resourceGroupName="your-resource-group-name"
$location="eastus2"

$templateFile="azuredeploy.json"

$storageName="st888999arm"
$storageSku="Standard_GRS"
$storageKind="StorageV2"
$vmSize="Standard_A2_v2"

Connect-AzAccount
New-AzResourceGroup -Name $resourceGroupName -Location $location

New-AzResourceGroupDeployment `
  -Name DeployLocalTemplate `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFile `
  -storageName $storageName `
  -storageSku $storageSku `
  -storageKind $storageKind `
  -vmSize $vmSize `
  -verbose
  