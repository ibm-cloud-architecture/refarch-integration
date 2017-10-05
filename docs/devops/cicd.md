# DevOps  
You can setup and enable automated CI/CD for most of the *hybrid integration Compute* components using Jenkins.

# Continuous integration with Jenkins
For continuous integration and deployment we are using Build server with Jenkins server deployed on it. With Jenkins we can do continuous build, test and deployment of each components to different target servers.

## Installation
The installation is following a non-docker install approach as described [here]( https://jenkins.io/doc/book/getting-started/installing), specially the following steps have to be done:

```
$ wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
$ sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
$ sudo apt-get update
$ sudo apt-get install jenkins
```
doing a `ps -ef | grep jenkins` we can see jenkins server is up and running as a java program. Pointing a web browser to http://localhost:8080 goes to the administration wizard to complete the configuration. You need to get the created password using: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`.
The wizard is also asking for a user, so we used *admin/admin01* and to install the standard plugins.

### For java you need jdk
As some of the code are Java based, we had the JDK (to get **javac** and other jars):
```
$ sudo apt-get install openjdk-8-jdk
```

To automate interaction script like ssh we are using [expect](http://expect.sourceforge.net/) tool so password and other input can be injected.
```
$ sudo apt-get install expect
```

### install docker on the build server
and authorize jenkins to be a docker user:
```
$ sudo  usermod -aG docker Jenkins
# if jenkins is running restart the server using the web browser to
(jenkins_url)/restart
```
### Add dependencies for node / angular...
Finally you need to be sure that any dependencies for each project are met. Like for the nodes and angularjs, be sure to have the compatible angular/cli, npm, nodejs (version 6). The following set of commands were used:

```
$ npm cache clean -f
# install nodejs 6
$ curl -sL https://deb.nodesource.com/sertup_6.x | sudo -E bash -
$ sudo apt-get install -y nodejs
$ sudo mpm i -g @angular/cli
```

## Pipeline context
Pipelines are made up of multiple steps that allow you to build, test and deploy applications. The following projects define pipeline in jenkinsfile.

* ibm-cloud-architecture/refarch-integration-inventory-dal. This project includes a *jenkinsfile* which defines a build stage to call a shell to execute *gradlew* to compile and package the war file, built under the folder *build/libs*.
* ibm-cloud-architecture/refarch-caseinc-app: The jenkins file performs npm install, npm run build, docker build, and helm package...

The following schema presents how the pipeline works:
![cicd](cicd-process.png)
1. Jenkins is listening to change / commit to the github public repositories
1. Repositories are cloned and their respective Jenkinsfiles are executed to build war, docker images or helm charts

## Creating Pipeline
Once the Jenkins server is started we need to create a pipeline. So using the **New Item** menu in the administration console: [Build server](http://localhost:8080) add *Web app Build*

![New Pipeline](jk-new-pipeline.png)

Then select the *Pipeline* configuration. This should bring a page with multiple tabs. The following options were selected:
* General:
 * Discard old builds after 2 days and 2 maximum builds
 * Do not allow concurrent builds as there are some dependencies between projects

* Build Triggers
 * Select 'GitHub hook Trigger..'
* Pipeline
 * Pipeline script from SCM: *as each project has a Jenkinsfile*
 * SCM is git and then specify the project to build.
  * http//github.com/ibm-cloud-architecture/refarch-caseinc-app
  OR
  * http//github.com/ibm-cloud-architecture/refarch-integration-inventory-dal/

  Use the *Build Now* option to test the build. You should get the results like:  
  ![results](cicd-results.png)

The folder where code is extracted is /var/lib/jenkins/workspace/BrownBuild@scripts
