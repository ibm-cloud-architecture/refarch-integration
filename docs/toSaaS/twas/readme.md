# Lift and shift
This tutorial will demonstrate how to lift and shift WebSphere workload running on-premises to IBM public cloud. When move to Cloud you will be on the latest version of the WebSphere platform available on Cloud.  For this scenario, we are using an On-premise workload running on WebSphere version 8.5.5.13 and the Cloud WebSphere version is running on version 9.x.
On completing this tutorial, you will learn the steps required to successfully migrate applications to cloud.

## Pre-requisites
* An IBM public cloud account
* Access to On-premise WebSphere environment
* Access to WebSphere Configuration Migration Tool


## Install WebSphere Configuration Migration Tool (WCMT)
Download the WebSphere Configuration Migration Tool for IBM Cloud and install it by unzipping it to a directory of your choice. For this scenario we installed the configuration migration tool on the same system  where the WebSphere workload  is running.
[https://developer.ibm.com/wasdev/downloads/#asset/tools-WebSphere_Configuration_Migration_Tool_for_IBM_Cloud](https://developer.ibm.com/wasdev/downloads/#asset/tools-WebSphere_Configuration_Migration_Tool_for_IBM_Cloud)

<img width=468 height=173 src="image001.png"></img>

Note: Set the `JAVA_HOME` environment variable to a version of Java 7 or higher. Also pre-pend the `$JAVA_HOME/bin` directory to your system path. To run the tool, use the following command:
```
java -jar CloudMigration.jar
```
<img border=0 width=468 height=70 src="image002.png"></img>

When you run the tool for the first time you will be prompted to set the language and then to accept the license agreement.

<img border=0 width=468 height=523 src="image003.png"></img>


<img border=0 width=468 height=292 src="image004.png"></img>

Select to use one-time single sign on and select the link below to collect the one time password.

<img border=0 width=468 height=269 src="image005.png"></img>

Enter the passcode obtained from the link and click login

<img border=0 width=468 height=292 src="image006.png"></img>

On the successful login page click  ‘Next ‘

<img border=0 width=468 height=243 src="image007.png"></img>

Select organization  and space and click  ‘New’

<img border=0 width=468 height=291 src="image008.png"></img>


Enter a new name for the services and select the environment. Click create service

<img border=0 width=468 height=234 src="image009.png"></img>

Click ‘Next’

<img border=0 width=468 height=291 src="image010.png"></img>

Select the WebSphere Cell you want to migrate and click ‘Next’

<img border=0 width=468 height=288 src="image011.png"></img>

Read the summary screen and click ‘continue’

<img border=0 width=468 height=292 src="image012.png"></img>

Click the migrate button for the profiles to migrate to Cloud.  For this scenario, we select both Deployment manager and node profile for migration.

<img border=0 width=468 height=243 src="image013.png"></img>

Provide the admin credentials to gather the profile configurations and click upload. You can click migrate button for all the profiles in parallel.

<img border=0 width=468 height=275 src="image014.png"></img>

Click the link in the “Complete the migration screen” to go to the provisioning window in Cloud. Also you can bookmark the provision the environment later.

<img border=0 width=468 height=223 src="image015.png"></img>

Click the ‘Finish button’ to close window.

<img border=0 width=468 height=170 src="image016.png"></img>

Select traditional cell

GO down and select the size of your Deployment manager VM

<img border=0 width=468 height=256 src="image017.png"></img>

Select the number and size of the nodes

<img border=0 width=468 height=267 src="image018.png"></img>

<img border=0 width=468 height=192 src="image019.png"></img>

Review summary and click provision

<img border=0 width=468 height=196 src="image020.png"></img>

<img border=0 width=468 height=253 src="image021.png"></img>


### Post Lift and Shift activities

* Open the service from the Cloud Dashboard and verify the information
* Configure the VPN connection
* Gather login credential to systems
* Open the ports on WAS servers to connect to internal services and external systems
* Verify the connection to third party systems such as Database server
* Logon to WebSphere console and verify the migrated configuration
* Reconfigure the data source to connect to Cloud Database and validate
* Review the binary scan report, make the updates recommended and redeploy the applications
* Validate the application

### Open the service from the Cloud Dashboard and verify the information

Find the service (Brown-WASND) from the dashboard and open it by clicking on it.

<img border=0 width=468 height=186 src="image022.png"></img>

Verify the information

<img border=0 width=468 height=246 src="image023.png"></img>

<img border=0 width=468 height=209 src="image024.png"></img>

<img border=0 width=468 height=227 src="image025.png"></img>

<img border=0 width=468 height=226 src="image026.png"></img>

### Configure the VPN connection
Click on your service ‘Brown-WASND’ service on your cloud dashboard.
Follow the VPN instructions and download the VPN configuration to connect to the Cloud.

<img border=0 width=468 height=234 src="image027.png"></img>

Using ‘Tunnelblick’ on my desktop to connect to US-South Public Cloud.

<img border=0 width=468 height=236 src="image028.png"></img>

Verify the connection by pinging from your terminal window

<img border=0 width=468 height=277 src="image029.png"></img>

### Gather the credentials required

* Next step is to capture the login credentials (root , WebSphere console login ,etc) from the dashboard for all WebSphere systems.

* Gather the ports WebSphere processes using from : /opt/IBM/WebSphere/Profiles/BrownDM01/logs/AboutThisMigratedProfile.txt

<img border=0 width=468 height=277 src="image030.png"></img>

<img border=0 width=468 height=204 src="image031.png"></img>

SSH to the server as root user
```
Eg : ssh  root@ 169.55.3.25
```

Note down the ports for the deployment manager from /opt/IBM/WebSphere/Profiles/BrownDM01/logs/AboutThisMigratedProfile.txt

<img border=0 width=468 height=359 src="image032.png"></img>

#### Open the ports on WAS servers to connect to internal services and external systems

Logon to the WAS servers:  ssh  root@ 169.55.3.25
Change directory to: /opt/IBM/WebSphere/AppServer/virtual/bin
```
drwxrwxr-x 2 virtuser admingroup 4096 Aug 30 18:25 .
drwxrwxr-x 3 virtuser admingroup 4096 Aug 30 18:25 ..
-rwxrwxr-x 1 virtuser admingroup 1604 Aug 30 18:25 federate.sh
-rwxrwxr-x 1 virtuser admingroup 1897 Aug 30 18:25 openFirewallPorts.sh
-rwxrwxr-x 1 virtuser admingroup 1667 Aug 30 18:25 openWASPorts.sh

Execute: ./openWASPorts.sh

Execute: ./openFirewallPorts.sh to open ports to other systems like database or LDAP servers

Eg: ./openFirewallPorts.sh –ports 50000 –persist true
```

#### Verify the connection to third party systems such as the Cloud database instance

For this lift and shift scenario we are using a Db2 on Cloud instance running on Bluemix

Database details:
```
hostname: dashdb-txn-sbox-yp-dal09-04.services.dal.bluemix.net
User Id : vvb46996
password: ********
Database : BLUDB
port: 50000
```
Telnet to the DB server with the port to verify the connection.

<img border=0 width=468 height=76 src="image033.png"></img>

#### Logon to WebSphere console and verify the migrated configuration

Logon to the WebSphere Console

<img border=0 width=468 height=166 src="image034.png"></img>

Verify the version, server and applications got migrated

<img border=0 width=468 height=144 src="image035.png"></img>

<img border=0 width=468 height=152 src="image036.png"></img>

#### Reconfigure the data source to connect to Cloud Database and validate

Change the existing data source configuration to point to the Cloud database instance.

<img border=0 width=468 height=282 src="image037.png"></img>

Check the JDBC driver Path and actual location of the jar files

<img border=0 width=468 height=74 src="image038.png"></img>

<img border=0 width=468 height=117 src="image039.png"></img>

Test the Data Source connection

<img border=0 width=468 height=210 src="image040.png"></img>

#### Review the binary scan report, make the updates recommended and redeploy the applications

Highlights from the  binary scan report

<img border=0 width=468 height=224 src="image041.png"></img>

<img border=0 width=468 height=158 src="image042.png"></img>

<img border=0 width=468 height=185 src="image043.png"></img>

Apply all the changes recommended under the ‘Severe Rules’ section and redeploy the application.
