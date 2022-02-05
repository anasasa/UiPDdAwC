#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail
az group delete --resource-group "group${MY_INDEX}" --yes
echo "All resources deleted"
