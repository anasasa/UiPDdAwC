#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail
DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE}")")
echo "Creating Azure resources"
az group create --name "group${MY_INDEX}" --location australiaeast
echo "Resource group created"
{
	az deployment group create --name "hdi${MY_INDEX}" --resource-group "group${MY_INDEX}" --template-file ${DIR}/HDI/hdi_template.json --parameters ${DIR}/HDI/hdi_parameters.json -p clusterName="hdi${MY_INDEX}" -p clusterLoginPassword="${HDI_PASSWORD}" -p sshPassword="${HDI_PASSWORD}"
	echo "Hadoop cluster created"
}&
az storage account create --name "func${MY_INDEX}storage" --sku Standard_LRS --location australiaeast --resource-group "group${MY_INDEX}"
echo "Storage account for function created"
az functionapp create --consumption-plan-location australiaeast --runtime python --runtime-version 3.8 --functions-version 3 --os-type linux --resource-group "group${MY_INDEX}" --storage-account "func${MY_INDEX}storage" --name "func${MY_INDEX}"
echo "Function created"
