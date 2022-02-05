# UiPDdAwC
Final project in the course Usługi i platformy deweloperskie dla aplikacji w Chmurze (UiPDdAwC)


## Workstation requirements

1. Recommended:
	- Ubuntu (Linux)
2. Installed:
	- azure-cli
3. Valid account with resources on:
	- portal.azure.com
4. System variables set:
```bash
export myindex=<index parameter>
export hdi_password=<define hadoop cluster password"
```

	
## Create function on Azure providing data from hadoop

**1. Create Azure resources**<br>
Log in to Azure using command line:
```bash
az login --use-device-code
```

Download repository from github
```bash
git clone https://github.com/anasasa/UiPDdAwC
```
Set paramterer (index number) and run script
```bash
./UiPDdAwC/createresources.sh
```

**2. Prepare data on hadoop cluster**<br>
Upload data to hadoop cluster
```bash
scp -r ./UiPDdAwC/HDI/data sshuser@hdi${myindex}-ssh.azurehdinsight.net:/home/sshuser/data
```

Log in to hadoop cluster
```bash
hdfs dfs -copyFromLocal ./data/data.txt /user/data.txt
```
and run below commands
```bash
hadoop jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-streaming.jar -files ./data/MRatingCount.py,./data/RRatingCount.py -mapper MRatingCount.py -reducer RRatingCount.py -input /user/data.txt -output /user/count
```

**3. Publish function on Azure**<br>
Publish function on Azure portal running below command
```bash
./UiPDdAwC/publishfunction.sh
```

**4. Final verification**<br>
Verify final functionality opening funcion link
```bash
https://func<myindex>.azurewebsites.net/api/read
```

Result should show performed counting:
```
('2', 30)	
('3', 72)	
('4', 164)	
('5', 227)	
```

## Delete all resources
To delete no longer needed resources please run below script
```bash
./UiPDdAwC/deleteresources.sh
```
