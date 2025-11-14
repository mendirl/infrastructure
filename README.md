# Docker on Synology NAS

## portainer 

sudo docker run -p 8000:8000 -p 9000:9000 -p 9443:9443 --detach --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /volume1/docker/portainer:/data portainer/portainer-ce



# TODO

- specific network for traefik/pgadmin

# WSL2
## docker cli
https://docs.docker.com/docker-for-windows/wsl/ -> step7
 
## elasticsearch
https://github.com/docker/for-win/issues/5202#issuecomment-678277217

# LINUX

## Manage Docker as a non-root user 
https://docs.docker.com/engine/install/linux-postinstall/
    
    sudo usermod -aG docker $USER





# RENOVATE
https://docs.renovatebot.com/


### docker doesn't start

in powershell terminal, as root :

    netsh winsock reset


### elastic/open search
in powershell:

    wsl -d docker-desktop
    - sysctl -w vm.max_map_count=262144 (temporarily)
    - echo "vm.max_map_count=262144" >  /etc/sysctl.d/100-elastic.conf && sysctl -p /etc/sysctl.d/100-elastic.conf

### commands to execute

    docker network create infra_network





# TLS

### create local certificats

in /mnt/docker/config/cert
    minica --domains mend.local

