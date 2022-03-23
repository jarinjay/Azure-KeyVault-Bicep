# Azure-KeyVault-Bicep

This repository provides the code for both the infrastructure creation (in this case Key vault) and also the Azure DevOps multistage pipeline. 

Prerequisite :

1. Have an Azure Subscription
2. Create a Resource Group in the Subsciption

To-Do while using the code : 

1. Create a Service connection
2. Create variable groups in Azure DevOps with service connection details, resource group name, parameter file name
3. Update the values in environment specific parameters file with the object ID for access policy and subnet resource id
