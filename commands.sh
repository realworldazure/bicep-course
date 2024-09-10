
# Deploys a Bicep file in Incremental mode
az deployment group create --name ExampleDeployment --resource-group ExampleResourceGroup --mode Incremental --template-file main.bicep --what-if	

# Using date and tr to create a random deployment group in Linux and MacOS
az deployment group create --name "deploy-$(date +%s)" --resource-group ExampleResourceGroup --mode Incremental --template-file main.bicep --parameters main.bicepparam --what-if

# Using Powershell to create a random deployment group name 
$randomName = "deploy-" + [guid]::NewGuid().ToString()	
az deployment group create `
    --name $randomName `
    --resource-group ExampleResourceGroup `
    --mode Incremental `
    --template-file main.bicep `
    --parameters main.bicepparam `
    --what-if
