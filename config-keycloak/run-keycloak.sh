#!/usr/bin/env bash

ACTION=$1
REALM=$2
CLIENT=$3
USER=$4


connect() {
  docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password admin
}

install-realm() {
  docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create realms -s realm=$REALM -s id=$REALM -s enabled=true
}

install-client() {
  docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r $REALM -s clientId=$CLIENT -s enabled=true -s clientAuthenticatorType=client-secret -s secret=7ce920b9-ea33-461c-bf28-c6791b75d854 -s 'redirectUris=["*"]'
}

install-client-service() {
  docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r $REALM -s clientId=$CLIENT -s enabled=true -s clientAuthenticatorType=client-secret -s secret=7ce920b9-ea33-461c-bf28-c6791b75d854 -s 'redirectUris=["*"]' -s serviceAccountsEnabled=true
}

install-user() {
  docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh create users -s username=$USER -s enabled=true -r $REALM
  docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh set-password -r $REALM --username $USER --new-password $USER
}

delete-realm() {
  docker exec -it keycloak /opt/jboss/keycloak/bin/kcadm.sh delete realms/$REALM
}


case "$ACTION" in

install)
  connect
  install-realm
  install-client
  install-user
  exit $?;;

delete)
  delete-realm
  exit $?;;

connect)
  connect
  exit $?;;

install-realm)
  install-realm
  exit $?;;

install-client)
  connect
  install-client
  exit $?;;

install-user)
  install-user
  exit $?;;

delete)
  delete-realm
  exit $?;;
  
delete-realm)
  delete-realm
  exit $?;;

*)
  echo "Usage: $0 {install|install-realm|install-client|install-user}"; exit 1;
esac


exit 0
