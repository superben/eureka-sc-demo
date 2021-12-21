#!/bin/sh -e

domain=${SPRING_PROFILES_ACTIVE:-default}

if [ "$domain" = "mesh" ] ; then
  echo "this is mesh domain. skip preStop";
else
  echo "Shutdown the service and sleep 30s then.";
  curl -X POST -H "Content-Type: application/json" -d '{"status": "DOWN"}' http://localhost:8083/actuator/service-registry;
  sleep 30;
fi;