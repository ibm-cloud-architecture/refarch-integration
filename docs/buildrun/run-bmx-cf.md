# Run on WebApp on IBM Cloud as Cloud Foundry App

You need to have a [IBM Cloud](http://bluemix.net) account, and know how to use cloud foundry command line interface and the container CLI to push to IBM Cloud, the containized web application used to demonstrate the solution.

Add a new space:
 1. Click on the IBM Cloud account in the top right corner of the web interface.
 2. Click Create a new space.
 3. Enter a name like "ra-integration" for the space name and complete the wizard steps.

## Step 1: Install the different CLI needed
It includes bluemix, cf, and kubernetes. A script exists in the scripts folder to automate the CLI installation:  `./scripts/install_cli.sh`

## Step 2: Connect to IBM Cloud via CLI
Get you IBM Cloud API end points where your account belong to. For IBM Cloud see the region end point in [this](https://console.bluemix.net/docs/overview/cf.html#howwork) documentation

* For US South region the API is
```
cf login -a https://api.ng.bluemix.net
```
Enter userid, password, organization and space. You are ready to push your application.

## Step 3: Push the app using CF
To push the application as defined in the Manifest. The only application to push is the web app.
```
cd refarch-caseinc-app
```
* Edit the manifest.yml file to specify the hostname of the server as it has to be unique: The URL is based on those parameter. So once the application is deployed the URL will be
http://caseincapp.mybluemix.net
```yaml
applications:
- path: .
  name: refarch-caseinc-app
  host: caseincapp
  instances: 1
  domain: mybluemix.net
  memory: 256M
  disk_quota: 1024M
  services:
    - ITSupportConversation
```

The cloud foundry command is push:
```
cf push

```
