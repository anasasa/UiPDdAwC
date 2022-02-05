import logging
import paramiko

import azure.functions as func


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect('hdi69303-ssh.azurehdinsight.net', username='sshuser', password='HDIhidden.pass02')
    stdin, stdout,_stderr = client.exec_command('hdfs dfs -text /user/count/part-00000')
    lines = stdout.read().decode()
    client.close()
    return func.HttpResponse(lines)
