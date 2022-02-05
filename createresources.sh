#!/bin/bash
echo "Creating Azure resources"
az group create --name "group${myindex}" --location australiaeast
echo "Resource group created"
{
	az deployment group create --name "hdi${myindex}" --resource-group "group${myindex}" --template-file ./UiPDdAwC/HDI/hdi_template.json --parameters ./UiPDdAwC/HDI/hdi_parameters.json -p clusterName="hdi${myindex}" -p clusterLoginPassword="${hdi_password}" -p sshPassword="${hdi_password}" -p storageName="hdi${myindex}storage"
	echo "Hadoop cluster created"
}&
az storage account create --name "func${myindex}storage" --sku Standard_LRS --location australiaeast --resource-group "group${myindex}"
echo "Storage account for function created"
az functionapp create --consumption-plan-location australiaeast --runtime python --runtime-version 3.8 --functions-version 3 --os-type linux --resource-group "group${myindex}" --storage-account "func${myindex}storage" --name "func${myindex}"
echo "Function created"
