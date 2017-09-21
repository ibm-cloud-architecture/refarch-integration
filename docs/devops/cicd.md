# DevOps  
You can setup and enable automated CI/CD for most of the *hybrid integration Compute* components using Jenkins.

## Continuous integration with Jenkins
For continuous integration and deployment we are using Build server with Jenkins server deployed on it. With Jenkins we can do continuous build, test and deployment of each components to different target servers.

## Installation
The installation is following the non-docker install as described [here]( https://jenkins.io/doc/book/getting-started/installing), specially the following steps have to be done:

```
$ wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
$ sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
$ sudo apt-get update
$ sudo apt-get install jenkins
```
doing a ps -ef | grep jenkins we can see jenkins server is up and running as a java program. Pointing a web browser to http://172.16.254.32:8080 goes to the administration wizard to complete the configuration. You need to get the created password using: sudo cat /var/lib/jenkins/secrets/initialAdminPassword.
The wizard is also asking for a user, so we used *admin/admin01* and to install the standard plugins.

As some of the code are Java based, we had **javac**:
```
$ sudo apt-get install openjdk-8-jdk
```

Finally to automate interaction script like ssh we are using [expect](http://expect.sourceforge.net/) tool.
```
$ sudo apt-get install expect
```

## Pipeline context
Pipelines are made up of multiple steps that allow you to build, test and deploy applications. The current environment uses a single repository and one project, looking up ibm-cloud-architecture/refarch-integration-inventory-dal. This project includes a *jenkinsfile* which defines a build stage to call a shell to execute *gradlew* so code can be compiled and packaged as war file, built under the folder *build/lib*. The second step of the pipeline for this project is to deploy the war to the target Liberty App Server.
```
pipeline {
    agent { docker 'gradle' }
    stages {
        stage('build') {
            steps {
                sh './gradlew build'
            }
        }
    },
    stage('deploy') {
        steps {
         timeout(time: 3, unit: 'MINUTES') {
            sh './deployToWlp.sh'
          }
        }
    }
}
```
The following schema presents how the pipeline works:
![cicd](cicd-process.png)
1. Jenkins is listening to change / commit to the github public repositories
2. Repositories are cloned and Their Jenkinsfile are executed. So for the Java project, build and unit tests are performed on the Utility server
3. The war file is deployed to the App Server, via remote copy.

The deployToWlp.bsh script is under the DAL project but it is using an interesting trick: the exp script to inject password
```
exp admin01 scp ./build/libs/*.war admin@172.16.254.44:~/IBM/wlp/usr/servers/appServer/apps
```

*exp* is a shell that uses the [expect](http://expect.sourceforge.net/) tool to automate interaction with application like ssh or scp. The script is defined in this project. It get the password as first argument and then the command to execute.
```
#!/usr/bin/expect
set timeout 20
set cmd [lrange $argv 1 end]
set p [lindex $argv 0]
eval spawn $cmd
expect "Pipeline"
send "Yes\r";
expect "assword:"
send "$p\r";
interact
```
The Pipeline is used when there is a question about certificate to accept.

 ## Creating BrownPipeline
Once the Jenkins server is started we need to create a pipeline. So using the **New Item** menu in the adminstration console: [Utility server](http 172.16.254.34:8080) add *BrownPipeline*

![New Pipeline](jk-new-pipeline.png)

Then select the *Pipeline* configuration. This should bring a page with multiple tabs. The following options were selected:
* General:
 * Discard old builds after 2 days and 2 maximum builds
 * Do not allow concurrent builds are there are some dependencies between projects
 * Github project is http//github.com/ibm-cloud-architecture/refarch-integration/
* Build Trigger
 * GitHub hook Trigger
* Pipeline
 * Pipeline script from SCM: *as each project has a Jenkinsfile*
 * SCM is git and then specify each project to build.
  * https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal

  Use the *Build Now* option to test the build. You should get the results like:  
  ![results](cicd-results.png)
