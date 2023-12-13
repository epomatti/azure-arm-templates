# ARM Templates

## Virtual Machine

Enter the VM folder:

```sh
cd virtual-machine
```

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

## Key Vault

Enter the `keyvault` directory:

```sh
cd keyvault
```

Directly copied/implemented from the documentation [tutorial][1].

```sh
az group create --name ExampleGroup --location eastus2
az keyvault create \
  --name kvarmtemplate999 \
  --resource-group ExampleGroup \
  --location centralus \
  --enabled-for-template-deployment true

az keyvault secret set --vault-name kvarmtemplate999 --name "ExamplePassword" --value "hVFkk965BuUv"
```

### Static

Create the `static-parameters.json` file from the sample:

```sh
# Set the variables manually
cp static-parameters-sample.json static-parameters.json
```

To deploy it with `STATIC` id:

> ℹ️ The Key Vault resource ID is statically defined in the static-parameters.json` file.

```sh
az deployment group create \
  --resource-group ExampleGroup \
  --template-file static-resources.json \
  --parameters static-parameters.json
```

### Dynamic

Create the `dynamic-parameters.json` file from the sample:

```sh
# Set the variables manually
cp dynamic-parameters-sample.json dynamic-parameters.json
```

To deploy it with `DYNAMIC` id:

```sh
az deployment group create \
  --resource-group ExampleGroup \
  --template-file dynamic-resources.json \
  --parameters dynamic-parameters.json
```


[1]: https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/key-vault-parameter?tabs=azure-cli
