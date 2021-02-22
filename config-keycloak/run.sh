https://github.com/keycloak/keycloak-documentation/blob/master/server_admin/topics/admin-cli.adoc
    
## connection server
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password admin
## creation realms
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create realms -s realm=JupiterR -s id=JupiterR -s enabled=true
## deleting realms
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh delete realms/jupiterR
## listing realms
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh get realms
## creating client
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r jupiterR -s clientId=spring-gateway -s enabled=true

docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r jupiterR -s clientId=spring-gateway -s enabled=true -s clientAuthenticatorType=client-secret -s secret=7ce920b9-ea33-461c-bf28-c6791b75d854 -s 'redirectUris=["*"]'
## deleting client
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh delete clients/59c8934d-b2fe-4b27-a2c0-932abcd04505 -r jupiterR
## listing client
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh get clients -r jupiterR --fields id,clientId
## getting client info
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh get -r jupiterR clients/$CID
## getting client secret
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh get -r jupiterR clients/$CID/client-secret
## setting client secret
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh update -r jupiterR clients/$CID -s "secret=7ce920b9-ea33-461c-bf28-c6791b75d854"
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh update -r jupiterR clients/59c8934d-b2fe-4b27-a2c0-932abcd04505 -s "secret=7ce920b9-ea33-461c-bf28-c6791b75d854"
## creating user
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create users -s username=fabien -s enabled=true -r jupiterR
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh set-password -r jupiterR --username fabien --new-password fabien




## all at once
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password admin
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create realms -s realm=jupiterR -s id=jupiterR -s enabled=true
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r jupiterR -s clientId=spring-gateway -s enabled=true -s clientAuthenticatorType=client-secret -s secret=7ce920b9-ea33-461c-bf28-c6791b75d854 -s 'redirectUris=["*"]'
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create users -s username=fabien -s enabled=true -r jupiterR
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh set-password -r jupiterR --username fabien --new-password fabien