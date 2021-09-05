
1 zpool -> n vdev -> v disk

- Storage Repository:
    - ssd
    - 150Go
    - xfs ? ou ext4

- repository data:
    - xfs
    - raidz1
    - 8To (+ 4to)
    - folder docker
    - folder nas
    - plex
- vm:
    - xoa
    - dev (docker: pgsql, elk, grafana, prometheus, hashi,...)
    - nas
    - plex
    - k8s


### cle ssh
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIdQrr30S1gcLpvtPAHoDYWq4yabywRUPc+7ZQot35bz couillard.fabien@gmail.com


#### suppression du repo xcp
    xe sr-list name-label=<Name of the SR>
    xe pbd-list sr-uuid=<UUID of SR>
    xe pbd-unplug uuid=<UUID of PBD>
    xe sr-forget uuid=<UUID of SR>


#### montre certaines info concernant xcp
    source /etc/xensource-inventory
    echo $INSTALLATION_UUID 


### REPO VM
# creation de la partition
    fdisk /dev/sda
    n     # add a new partition
    
    w     # write table to disk and exit
    mkfs.ext4 /dev/sda4

# creation du pool
pwd: /mnt/pool-vm

    zpool create \
    -o ashift=12 \
    -m /mnt/pool-vm \
    pool-vm \
    ata-M4-CT256M4SSD2_0000000012380916196D-part4 \
    -f

# creation du repo
    xe sr-create \
    host-uuid=4956ce32-e270-448b-8e51-fb3fae7f26c8 \
    type=zfs \
    content-type=user \
    name-label=pool-vm-sr \
    device-config:location=/mnt/pool-vm/

    xe pool-param-set \
    uuid=82235782-4613-70b1-2230-b5d3f2779621 \
    default-SR=893d79bf-c6a2-8f0a-48b0-c160e597278b


### REPO DATA
pwd: /mnt/pool-data

    zpool create \
    -o ashift=12 \
    -m /mnt/pool-data \
    pool-data \
    raidz \
    ata-WDC_WD40EFZX-68AWUN0_WD-WX32DC02VF5U \
    ata-WDC_WD40EFZX-68AWUN0_WD-WX32DC02VV4C \
    ata-WDC_WD40EFZX-68AWUN0_WD-WX42DC0PC34E \
    -f

    zfs create -o compress=lz4 pool-data/nas
    zfs create -o compress=lz4 pool-data/docker

    xe sr-create host-uuid=4956ce32-e270-448b-8e51-fb3fae7f26c8 type=zfs content-type=user name-label=pool-data-nas device-config:location=/mnt/pool-data/nas
    xe sr-create host-uuid=4956ce32-e270-448b-8e51-fb3fae7f26c8 type=zfs content-type=user name-label=pool-data-docker device-config:location=/mnt/pool-data/docker

### REPO ISO

    wget https://releases.ubuntu.com/20.04.2/ubuntu-20.04.2-live-server-amd64.iso
    wget https://releases.ubuntu.com/20.04.2/ubuntu-20.04.2-live-server-amd64.iso
    wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/34.20210711.3.0/x86_64/fedora-coreos-34.20210711.3.0-live.x86_64.iso
    wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.10.0-amd64-netinst.iso

    zfs create -o compress=lz4 pool-data/iso
    xe sr-create name-label="ISO Repository" type=iso device-config:location=/mnt/pool-data/iso device-config:legacy_mode=true content-type=iso
    xe sr-create name-label="ISO Repository" type=iso device-config:location=/mnt/pool-data/iso device-config:legacy_mode=true content-type=iso device-config:path=/mnt/pool-data/iso
    xe sr-list name-label="ISO Repository"
    xe sr-scan uuid=...


### INSTALL DOCKER
https://docs.docker.com/engine/install/ubuntu/
https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user
https://docs.docker.com/compose/cli-command/#installing-compose-v2

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt install docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
    docker run hello-world
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service

    mkdir -p ~/.docker/cli-plugins/
    curl -SL https://github.com/docker/compose-cli/releases/download/v2.0.0-rc.2/docker-compose-linux-amd64 -o ~/.docker/cli-plugins/docker-compose
    chmod +x ~/.docker/cli-plugins/docker-compose

