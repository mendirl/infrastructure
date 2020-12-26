#!/usr/bin/env bash

ACTION=$1

case "$ACTION" in

install)
  docker volume create odfe-master
  docker volume create odfe-data1
  docker volume create odfe-data2
  docker volume create odfe-single
  docker volume create odfe-coordinating

  docker network create odfe-network-cluster
  docker network create odfe-network-single
  exit $?;;

remove)
  docker volume rm odfe-master
  docker volume rm odfe-data1
  docker volume rm odfe-data2
  docker volume rm odfe-single
  docker volume rm odfe-coordinating

  docker network rm odfe-network-cluster
  docker network rm odfe-network-single
  exit $?;;

prune)
  docker system prune
  exit $?;;

start-single)
  docker-compose --compatibility -f docker-compose-odfe-single.yml up -d
  exit $?;;

stop-single)
  docker-compose --compatibility -f docker-compose-odfe-single.yml down
  exit $?;;

config-single)
  docker-compose --compatibility -f docker-compose-odfe-single.yml config
  exit $?;;

start-cluster)
  docker-compose --compatibility -f docker-compose-odfe-cluster.yml up -d
  exit $?;;

stop-cluster)
  docker-compose --compatibility -f docker-compose-odfe-cluster.yml down
  exit $?;;

config-cluster)
  docker-compose --compatibility -f docker-compose-odfe-cluster.yml config
  exit $?;;

start-spring-cloud-data-flow)
  export DATAFLOW_VERSION=2.6.2
  export SKIPPER_VERSION=2.5.2
  docker-compose --compatibility -f spring-cloud-data-flow.yml up
  exit $?;;

stop-spring-cloud-data-flow)
  export DATAFLOW_VERSION=2.6.2
  export SKIPPER_VERSION=2.5.2
  docker-compose --compatibility -f spring-cloud-data-flow.yml down
  exit $?;;

*)
  echo "Usage: $0 {install|remove|prune|start-single|stop-single|config-single|start-cluster|stop-cluster|config-cluster}"; exit 1;
esac


exit 0
