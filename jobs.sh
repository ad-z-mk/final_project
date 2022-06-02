#!/bin/bash
vm1=$(grep -A1 external_ip_address_vm_1 /home/user/terraform.tfstate | sed -e 's/\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\).*$/\1/' -e t -e d | cut -c 17-)

java -jar /tmp/jenkins-cli.jar -s http://$vm1:8080 -auth admin:passw0rd create-job job1 <job1.xml
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "upload job1: $?"

java -jar /tmp/jenkins-cli.jar -s http://$vm1:8080 -auth admin:passw0rd create-job job2 < job2.xml
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "upload job2: $?"

java -jar /tmp/jenkins-cli.jar -s http://$vm1:8080 -auth admin:passw0rd create-job job3 < job3.xml
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "upload job3: $?"


java -jar /tmp/jenkins-cli.jar -s http://$vm1:8080 -auth admin:passw0rd build job1
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "Start job: $?"

