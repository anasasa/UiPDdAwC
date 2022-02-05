#!/bin/bash
cd ./UiPDdAwC/Function
sed -i "11s/.*/    client.connect('hdi${myindex}-ssh.azurehdinsight.net', username='sshuser', password='${hdi_password}')/" ./read/__init__.py
func azure functionapp publish func69303
cd ../..
