# Use Vagrant to run different backend services of hybrid integration

Our environment to develop and test the different Brown or Green compute is using vSphere and a lot of hardware. You may not be able to replicate this environment easily. 


Therefore for development purpose, we propose to setup use one of the two approach: different virtual machine using [Vagrant](https://www.vagrantup.com/intro/getting-started/).

## Pre-requisites

This solution requires you have internet access, experience with WebSphere Application Server, DB2 and MQ and its admin console and familiarity with basic Linux commands.
Be to to have clone the linked repositories:
* `git clone https://github.com/ibm-cloud-architecture/refarch-integration-inventory-db2.git` 

## Docker compose:

The simplest way is to use IBM Docker images of all the needed product, and docker compose to manage their dependencies. The compose file and different dockerfiles needed to tune our configuration are under `db2-mq-tWAS-docker` folder.

The DB2 image is built from https://hub.docker.com/r/ibmcom/db2express-c/ and tuned for our DB instance and data.  


## Ubuntu, Liberty, DB2

The file is under `ubuntu-db2-liberty-vagrant` folder.

```
vagrant up
vagrant ssh
```


## Db2, tWAS, MQ image 

This approach is not finished
The Vagrant file is under  db2-mq-tWAS-vagrant folder.

```
vagrant up
vagrant ssh
```