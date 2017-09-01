# Run on Bluemix as Cloud Foundry App

You need to have a [Bluemix](http://bluemix.net) account, and know how to use cloud foundry command line interface and blumix container CLI to push to bluemix, the containized web application used to demonstrate the solution. Add a new space:
 1. Click on the Bluemix account in the top right corner of the web interface.
 2. Click Create a new space.
 3. Enter a name like "ra-integration" for the space name and complete the wizard steps.

### Step1: Install the different CLI needed
It includes bluemix, cf, and kubernetes. A script exists in this project for that see:  `./install_cli.sh`


### Step 2: Provision Kubernetes Cluster on IBM Bluemix
The kubernetes cluster is optional as the Case Inc Portal app can run in a docker container or as a cloud foundry application. We still encourage to use Kebernetes to deploy microservices as it offers a lot of added values we need. So if you want to deploy to Kubernetes you need to do the following instructions:
```
$ bx login
$ bx cs init
```
