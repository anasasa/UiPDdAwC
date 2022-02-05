#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail
cd ./UiPDdAwC/Function
sed -i "11s/.*/    client.connect('hdi${MY_INDEX}-ssh.azurehdinsight.net', username='sshuser', password='${HDI_PASSWORD}')/" ./read/__init__.py
func azure functionapp publish "func${MY_INDEX}"
cd ../..
