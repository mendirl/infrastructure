# WSL2
## docker cli
https://docs.docker.com/docker-for-windows/wsl/ -> step7
 
## elasticsearch
https://github.com/docker/for-win/issues/5202#issuecomment-678277217
     

# RENOVATE
https://docs.renovatebot.com/


in powershell 
    
    wsl -d docker-desktop
    sysctl -w vm.max_map_count=262144


### docker doesn't start

in powershell terminal, as root :

    netsh winsock reset


### elastic/open search
in powershell:

    wsl -d docker-desktop
    sysctl -w vm.max_map_count=262144
