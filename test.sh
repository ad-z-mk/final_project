#!/bin/bash
vm2=$(grep -A1 external_ip_address_vm_2 /home/user/terraform.tfstate | sed -e 's/\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\).*$/\1/' -e t -e d | cut -c 17-)

echo -e "- name: Start-jenkins\n  gather_facts: No\n  hosts: all\n  become: yes\n  become_method: sudo\n  tasks:\n\n    - name: Start jenkins\n      docker_container:\n        name: jen\n        image: amukanov/jenkins\n        state: started\n        restart: yes\n        ports:\n          - "8080:8080"\n        volumes:\n          - ./:/var/jenkins_conf\n        env:\n            CASC_JENKINS_CONFIG: /var/jenkins_conf\n            NEXUS_URL: http://$vm2:8081" > pb.yml

