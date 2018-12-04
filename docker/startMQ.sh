#!/bin/bash
docker stop localMQ
docker rm localMQ
docker run \
  --name localMQ \
  --env LICENSE=accept \
  --env MQ_QMGR_NAME=LQM1 \
  --volume qm1data:/mnt/mqm \
  --publish 1414:1414 \
  --publish 9443:9443 \
  --network mq-brown-network --network-alias qmgr \
  --env MQ_APP_PASSWORD=admin01 \
  --detach \
  ibmcase/brownmq
