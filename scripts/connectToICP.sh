#!/bin/bash

if [ -z "$1" ]; then
  master="green2.cluster.icp"
else
  master=$1
fi

# Then login using kubectl
  token=""
  while [ "$token" = "" ]
  do
    token=`curl -k -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" -d "grant_type=password&client_id=rp&client_secret=LDo8LTor&username=admin&password=admin&scope=openid" https://$master:8443/idprovider/v1/auth/identitytoken --insecure | grep -o '(?<="id_token":)(.*?)(?=})' | sed 's/\(^"\|"$\)//g'`
     if [ "$token" = "" ]
     then
       printf "."
       sleep 5
     fi
  done

  kubectl config set-cluster cfc --server=https://${master}:8001 --insecure-skip-tls-verify=true
  kubectl config set-credentials user --token=$token
  kubectl config set-context cfc --cluster=cfc
  kubectl config set-context cfc --user=user --namespace=default
  kubectl config use-context cfc
