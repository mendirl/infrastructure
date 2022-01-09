# TODO

- specific network for traefik/pgadmin

# WSL2
## docker cli
https://docs.docker.com/docker-for-windows/wsl/ -> step7
 
## elasticsearch
https://github.com/docker/for-win/issues/5202#issuecomment-678277217





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
