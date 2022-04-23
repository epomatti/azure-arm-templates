# ARM Template for Virtual Machine

Example creating Virtual Machines using ARM Templates.

You'll need to have either **PowerShell Azure Extensions** or **Azure CLI**.

### Create the Resource Group

For this example you create the resource group separately (or reuse one you have).

```ps1
# PowerShell
$resourceGroupName="your-resource-group-name"
$location="eastus2"

Connect-AzAccount
New-AzResourceGroup -Name $resourceGroupName -Location $location
```

```bash
# Azure CLI
resourceGroupName="your-resource-group-name"
location="eastus2"

az login
az group create --name $resourceGroupName --location $location
```
### Deploy the Template

Set the variables:

```ps1
# PowerShell
$templateFile="azuredeploy.json"

$storageName="st888999arm"
$storageSku="Standard_GRS"
$storageKind="StorageV2"
$vmSize="Standard_A2_v2"
```

```bash
# Azure CLI
templateFile="azuredeploy.json"

storageName="st888999arm"
storageSku="Standard_GRS"
storageKind="StorageV2"
vmSize="Standard_A2_v2"
```

Trigger the deployment:

```ps1
# PowerShell
New-AzResourceGroupDeployment `
  -Name DeployLocalTemplate `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFile `
  -storageName $storageName `
  -storageSku $storageSku `
  -storageKind $storageKind `
  -vmSize $vmSize `
  -verbose
```

```bash
# Azure CLI
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
```