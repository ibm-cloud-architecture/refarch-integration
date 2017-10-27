#!/bin/bash
apt update
apt upgrade
sudo apt install unzip
if [ ! -d "wlp" ]; then
  echo "Get Open Liberty server"
  wget https://public.dhe.ibm.com/ibmdl/export/pub/software/openliberty/runtime/release/2017-09-27_1951/openliberty-17.0.0.3.zip
  unzip openliberty-17.0.0.3.zip
  rm openliberty-17.0.0.3.zip
  export PATH=$(pwd)/wlp/bin:$PATH
fi

if [ -z "$(java -version)" ]; then
  echo "Install java 8"
  sudo apt install openjdk-8-jre-headless -y
  server create brownServer
  echo "Get the brown server configuration"
  cp brown/refarch-integration-inventory-dal/src/main/liberty/config/server.xml  wlp/usr/servers/brownServer/
fi

wget https://jazz.net/downloads/DB2/releases/10.1/db2_v1012_linuxx64_expc.tar.gz
tar -xvf db2_v1012_linuxx64_expc.tar.gz
