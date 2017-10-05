# Install a development environment with IBM Cloud Private 2.1
This is a quick summary of what you may do to install a ICP 2.1 CE development host on a single VM with Ubuntu 64 bits 16.10.

The developer environment may look like the following diagram, for a developer on Mac and a VM ubuntu image (Windows will look similar)
![](dev-env.png)

A developer needs to have on his development environment the following components:
* [Docker](#install-docker)
* [Kubectl](#install-kubectl)
* [Helm](#install-helm)
* A VM player to install and run ubuntu machine

If you need to access the dockerhub IBM public image, use [docker hub explorer](https://hub.docker.com/explore/)

## Ubuntu Specifics:
* Access to the VM vSPhere and add a VM in your resource pool. The expected resource could be
CPUs: 4 Memory: 32GB Disk: 600GB (Thin Provisioned)
* Install ubuntu following the step by step wizard, create a user with admin privilege
* Login as this user
* Change root user password
```
$ sudo su -
$ passwd
```
* Update the ubuntu repository
```
apt-get update
```
* Set hostname
```
sudo hostname juvm
```
* Install open ssh, and authorize remote access
```
sudo apt-get install openssh-server
systemctl restart ssh
```

* Create ssh keys for root user and authorize ssh
```
# create rsa keys with no passphrase
$ ssh-keygen -b 4096 -t rsa -P ''
```
be sure the following parameters are enabled
```
$ vi  /etc/ssh/sshd_config
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication yes
```
The restart ssh daemon:
```
$ systemctl restart ssh
$ ssh-copy-id -i .ssh/id_rsa root@juvm
```
Then you should be able to ssh via root too
* Install NTP to keep time sync
```
apt-get install -y ntp
sytemctl restart ntp
# test it
ntpq -p
```
* Install Linux image extra packages
```
apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
```
* Install python
  ```
  $  apt-get install -y python-setuptools
  $ easy_install pip
  $ pip install docker-py
  ```
* Disable firewall if enabled
  ```
  $ ufw status
  $ sudo ufw disable
  ```
## Install docker
* Install docker repository
  ```
   $ apt-get install -y apt-transport-https ca-certificates curl software-properties-common
  ```

  * Get the GPG key
   ```
   $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - apt-key fingerprint 0EBFCD88
   ```
  * Setup docker stable repository
  ```
  $ add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb\_release -cs) stable”
  $ apt-get update
  $ apt-get install -y docker-ce
  ```

* Validate it runs
 ```
   docker run hello-world
 ```
* Add user to docker group
  ```
   # Verify docker group is here
   $ cat /etc/group
   # add user
   $ usermod -G docker -a jerome
   # relogin the user to get the group assignment at the session level
   ```

* Boot and log as root user

## IBM Cloud Private CE
* Get the ICP  installer docker image using the following command
 ```
 $ sudo docker pull ibmcom/cfc-installer:2.1.0
 $ su -
 $ mkdir /opt/ibm-cloud-private-ce-2.1.0
 $ cd /opt/ibm-cloud-private-ce-2.1.0
 ```
 The following command extracts configuration file under the *cluster* folder by mounting local folder to /data inside the container:
 ```
 $ docker run -e LICENSE=accept \
  -v "$(pwd)":/data ibmcom/cfc-installer:2.1.0 cp -r cluster /data
 ```
* In the cluster folder there are multiple files to modify: config.yaml, hosts, and ssh-keys
  * hosts: As we run in a single VM, the master, proxy and worker will have the same ip address. So get the VM ip address using:
  ```
  $ ip address
  ```
   * Modify the hosts file
  ```
  [master]
   172.16.251.133
   [worker]
   172.16.251.133
   [proxy]
   172.16.251.133
  ```
  * Modify the config.yaml file by specifying a domain name and cluster name, but also the loopback dns flag so the server will run in single VM without error.
  ```
  loopback_dns: true
  cluster_name: jbcluster
  cluster_domain: adomain
  ```
  * Copy security keys to the ssh_key file
  ```
  $ cp ~/.ssh/id_rsa /opt/cluster/ssh_key
  $ chmod 400 /opt/cluster/ssh_key
  ```
  * Deploy the environment now
  ```
  $ docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster ibmcom/cfc-installer:2.1.0 install
  ```
  * Verify access to ICP console using http://ipaddress:8443 admin/admin
  You should see the dashboard as in figure below:

  ![](icp-dashboard.png)
