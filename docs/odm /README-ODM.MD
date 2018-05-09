# ODM ICP and Ruleset Install

In this tutorial we will cover how to install ODM from our ICP Catalog onto our server, and install a previously generated ruleset.
## Requirements

 1. ODM in our ICP Catalog
 2. A zip file of our Rules

## Installing ODM on ICP
The first thing we will do is launch our ICP Dashboard
![ICP Home](ICPHome.png)

Next we will be selecting the dropdown from the right and select our catalog option
![ICPHome-Catalog](ICPHome-Catalog.png)

From there we will select our Helm Chart where we are installing ODM from, and run a search for ODM.
![Catalog-ODM](Catalog-ODM.png)

Here we can see we have found our ODM Package to install, next we select that package.

![ODM HelmChart](ODM-HelmChart.png)

Next we shall read the documentation available. In this example we can gather important information such as the H2 Server needing 5 Gbs of Persistent storage. We will select configure to enter the necessary information

![ODM HelmChart Configuration](ODM-HelmChart-Configuration.png)

We will give our release name as bc-odm and then select our targeted namespace.

![ODM Configuration Service and Resource](ODM-Configuration-Service-and-Resources.png)

We do not need to change anything in the previous screen shot

![ODM Configuration Locale H2](ODM-Configuration-Locale-H2.png)

We will be changing 2 things in the H2 Database.
 1. Check the Use dynamic Provisioning for Persistent volume so that it is enabled
 2. Change the 2 to a 5 for the Storage Size for persistent volume

No other changes are needed to be made for any other options. then click configure at the bottom

After receiving your successful message let's navigate to our dropdown and find our instance. Click the three bars, and then select workloads, and finally helm releases.
![ODM Instance in ICP](ODM-Instance-in-ICP.png)

Next find and select the ODM Instance in the catalog. In our case it is bc-odm
![ODM Instance in Catalog](ODM-Instance-in-Catalog.png)

Now we can see the ODM Instance and info. We can view the password here and also can see the instance we need to navigate to.

![ODM Instance Details](ODM-Instance-Details.png)

![ODM Instance Info](ODM-Instance-Info.png)

Select the link listed inside the service to navigate to more details

![ODM Instance Port](ODM-Instance-Port.png)

Select the Node Port to navigate to the asset. This should take you to the ODM Home Page. Note that you may need to log in with associated info.

![ODM Home](ODM-Home.png)

## Installing the Ruleset

From here we will select the Decision Center Enterprise Console to Add our Rules.

Select Configure at the top right of the navigation bars

![ODM Navigation Import](ODM-Navigation-Import.png)

Select Import Projects to import our rule project. The Rule Project will look something like this but zipped

![ODM Rule Package](ODM-Rule-Package.png)

Next you can select the ODM Project to explore as seen here. I changed the dropdown to explore the ruleset, however to export let's change it back to customer-recommendation-main
![ODM Project Info](ODM-Project-Info.png)

Now Select project again to export the rule archive

![ODM Archive Export](ODM-Archive-Export.png)

And select our ruleset to export
![ODM Rule Extractor](ODM-Rule-Extractor.png)

Select OK and then download the jar archive that it responds with.

Navigate back to our ODM Dashboard and select Decision Server Console
![ODM Home](ODM-Home.png)

Select the Add RuleApp option

![Decision Server Console](Decision-Server-Console.png)

Fill out required information to create our new RuleApp

![New Rule App Info](New-Rule-App-Info.png)

After this is done we will be attaching the necessary archived ruleset from the previous steps. Select Add Ruleset in the below screen

![ODM RuleApp View](ODM-RuleApp-View.png)

Please add the necessary information and attach the JAR that was previously downloaded

![ODM Ruleset Attach](ODM-Ruleset-Attach.png)
