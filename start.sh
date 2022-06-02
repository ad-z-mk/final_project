#!/bin/bash
terraform apply -auto-approve &
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "Terraform exit status: $?"



./dynamic.sh &
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "Dynamic inventory status: $?"

./test.sh &
process_id=$!
echo "PID: $process_id"
wait $process_id

clear

echo "Inventory file is ready"

echo ********VM PROVISIONING*********

while ansible vm1 -m ping; ss=$?; [[ $ss != 0 ]]
do
    echo *****still provisioning***** 
done
process_id=$!
wait $process_id

clear

echo ********VM IS READY, STARTING PLAYS********

ansible-playbook -l vm1 docker_pre_conf.yml -v &
process_id=$!
echo "PID: $proces_id"
wait $process_id
echo "Pre conf status: $?"

ansible-playbook -l vm1 install_docker.yml -v &
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "Install docker status: $?"

ansible-playbook -l vm1 copy.yml -v &
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "Copy config status: $?"


ansible-playbook -l vm1 pb.yml -v &
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "Jenkins status: $?"

echo ************ JENKINS IS READY, STARTING NEXUS ***************

ansible-playbook -l vm2 docker_pre_conf.yml -v &
process_id=$!
echo "PID: $proces_id"
wait $process_id
echo "Pre conf status: $?"

ansible-playbook -l vm2 install_docker.yml -v &
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "Install docker status: $?"

ansible-playbook -l vm2 start_nexus.yml -v &
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "Nexus status: $?"

echo ******* NEXUS IS READY, UPLOADING JOBS *******

./jobs.sh &
process_id=$!
echo "PID: $process_id"
wait $process_id
echo ************ DONE *************

