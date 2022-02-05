#!/bin/bash
az group delete --resource-group "group${myindex}" --yes
echo "All resources deleted"
