#!/bin/bash
vm1=$(grep -A1 external_ip_address_vm_1 /home/user/terraform.tfstate | sed -e 's/\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\).*$/\1/' -e t -e d | cut -c 17-)
vm2=$(grep -A1 external_ip_address_vm_2 /home/user/terraform.tfstate | sed -e 's/\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\).*$/\1/' -e t -e d | cut -c 17-)

echo -e "[all]\nvm1 ansible_host=$vm1 ansible_user=user\nvm2 ansible_host=$vm2 ansible_user=user" > hosts.txt
