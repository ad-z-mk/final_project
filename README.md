This repo contains all scripts from all my another repos and a little bit more.  
- Project starts running newstart.sh, in the finish we should have: Jenkins and Nexus servers running as containers in yandex.cloud. Jenkins builds calculator app using maven and pushes all artifacts to private repo in Nexus.  
- Shell scripts are used for: start all components of project (terraform script, ansible playbooks, shell scripts), make dynamic inventory for ansible, upload jobs to jenkins server.  
- Terraform used for: start 2 VMs in yandex.cloud
- Ansible used for: start servers in docker, configure servers (upload plugins, configure users via api, make repos ETC)
