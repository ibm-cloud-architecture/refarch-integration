# Install a development environment with IBM Cloud Private 2.1
This is a quick summary of what needs to be done for installing ICP 2.1 on a single VM, used for development purpose. We are using vSphere environment, and will define a VM with Ubuntu 16.10. For a full tutorial on how to install ICp see [this note]()

See [product documentation](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/installing/install_containers_CE.html) to get details. We still found some tricks to be considered so here are our steps:
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
* Install open ssh
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
* install NTP to keep time sync
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

* Install docker
 * install docker repository
  ```
   $ apt-get install -y apt-transport-https ca-certificates curl software-properties-common
  ```

  * get the GPG key
   ```
   $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - apt-key fingerprint 0EBFCD88
   ```
  * setup docker stable repository
  ```
  $ add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb\_release -cs) stable”
  $ apt-get update
  $ apt-get install -y docker-ce
  ```

 * validate it runs
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
  * install python
  ```
  $  apt-get install -y python-setuptools
  $ easy_install pip
  $ pip install docker-py
  ```
  * disable firewall is enabled
  ```
  $ ufw status
  $ sudo ufw disable
  ```

* Boot and log as root user

## IBM Cloud Private CE
* Get the ICp  installer docker image using the following command
 ```
 sudo docker pull ibmcom/cfc-installer:2.1.0
 su -
 mkdir /opt/ibm-cloud-private-ce-2.1.0
 cd /opt/ibm-cloud-private-ce-2.1.0
 ```
 The following command creates the cluster folder by mounting local the data folder from installer image
 ```
 docker run -e LICENSE=accept \
  -v "$(pwd)":/data ibmcom/cfc-installer:2.1.0 cp -r cluster /data
 ```
* In the cluster folder there are multiple files to modify: config.yaml, hosts, and ssh-keys
  * hosts: As we run in a single VM, the master, proxy and worker will have the same ip address. So get the VM ip address using:
  ```
  $ ip address
  ```
  modify the hosts file
  ```
  [master]
   172.16.251.133
   [worker]
   172.16.251.133
   [proxy]
   172.16.251.133
  ```
  * modify the config.yaml file by specifying a domain name and cluster name, but also the loopback dns flag so the server will run in single VM without error.
  ```
  loopback_dns: true
  cluster_name: jbcluster
  cluster_domain: adomain
  ```
