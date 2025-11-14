https://github.com/keycloak/keycloak-documentation/blob/master/server_admin/topics/admin-cli.adoc
https://github.com/AndriyKalashnykov/sample-spring-security-microservices/tree/master/scripts

## connection server
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://localhost:9999/auth --realm master --user fabien --password ******
## creation realms
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create realms -s realm=JupiterR -s id=JupiterR -s enabled=true
## deleting realms
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh delete realms/JupiterR
## listing realms
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh get realms
## creating client
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r JupiterR -s clientId=spring-gateway -s enabled=true

docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r JupiterR -s clientId=local-spring-gateway -s enabled=true -s clientAuthenticatorType=client-secret -s secret=7ce920b9-ea33-461c-bf28-c6791b75d854 -s 'redirectUris=["*"]'
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r JupiterR -s clientId=spring-gateway -s enabled=true -s clientAuthenticatorType=client-secret -s secret=7ce920b9-ea33-461c-bf28-c6791b75d854 -s 'redirectUris=["*"]' -s serviceAccountsEnabled=true

## deleting client
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh delete clients/59c8934d-b2fe-4b27-a2c0-932abcd04505 -r JupiterR
## listing client
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh get clients -r JupiterR --fields id,clientId
## getting client info
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh get -r JupiterR clients/$CID
## getting client secret
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh get -r JupiterR clients/$CID/client-secret
## setting client secret
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh update -r JupiterR clients/$CID -s "secret=7ce920b9-ea33-461c-bf28-c6791b75d854"
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh update -r JupiterR clients/59c8934d-b2fe-4b27-a2c0-932abcd04505 -s "secret=7ce920b9-ea33-461c-bf28-c6791b75d854"
## creating user
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create users -s username=fabien -s enabled=true -r JupiterR
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh set-password -r JupiterR --username fabien --new-password fabien

# old

docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password admin
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create -x "client-scopes" -r JupiterRealm -s name=TEST -s protocol=openid-connect
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r JupiterRealm -s clientId=spring-with-test-scope -s enabled=true -s clientAuthenticatorType=client-secret -s secret=c6480137-1526-4c3e-aed3-295aabcb7609  -s 'redirectUris=["*"]' -s 'defaultClientScopes=["TEST", "web-origins", "profile", "roles", "email"]'


cli-tools connect http://localhost:8080/auth admin admin


docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password admin
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create realms -r JupiterR -s id=JupiterR -s enabled=true
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r JupiterR -s clientId=local-spring-gateway -s enabled=true -s clientAuthenticatorType=client-secret -s secret=7ce920b9-ea33-461c-bf28-c6791b75d854 -s 'redirectUris=["*"]'
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r JupiterR -s clientId=local-spring-consumer -s enabled=true -s clientAuthenticatorType=client-secret -s secret=7ce920b9-ea33-461c-bf28-c6791b75d854 -s 'redirectUris=["*"]' -s serviceAccountsEnabled=true
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create users -r JupiterR -s username=fabien -s enabled=true
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh set-password -r JupiterR --username fabien --new-password fabien

docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create -x "client-scopes" -r JupiterR -s name=position -s protocol=openid-connect
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh get clients -r JupiterR --fields id,clientId
docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh update  -r JupiterR clients/{{local-spring-consumer-id}} -s defaultClientScopes+=position
