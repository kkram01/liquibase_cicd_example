# Continuous Integration & Continuous Deployment for Cloud Run
This repository is designed to lint code, scan code and deploy packaged code to Cloud Run. It manages the promotion process from development to production through pull requests and releases while also allowing for canary deployments through workflow dispatch. 

## Prerequisites
 * Develop, QA and Production Google Cloud projects are created.
 * Workload identity [pools and providers](https://cloud.google.com/iam/docs/manage-workload-identity-pools-providers) have been created and added to [GitHub Secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions).
 * The roles/iam.workloadIdentityUser role has been granted to the service account that will authenticate with workload identity federation. See [documentation](https://cloud.google.com/blog/products/identity-security/secure-your-use-of-third-party-tools-with-identity-federation) for guidance on provisioning workload identity with GitHub Actions.
 * The service account has been added to GitHub Secrets and has the following roles. 
    * roles/artifactregistry.writer
    * roles/run.admin
    * roles/secretmanager.secretAccessor
    * roles/cloudsql.client
 * All required APIs for Google Cloud services have been enabled.
 * [Artifact Registry](https://cloud.google.com/artifact-registry/docs/docker/store-docker-container-images) repository must be created. 
 * Branches are created for develop and main. 
 * Environments for dev, qa and prod are created within GitHub Environments. 
 * Following environment variables are created in each environment. 
    * ARTIFACT_REGISTRY_PROJECT
    * ARTIFACT_REGISTRY_REPO
    * CLOUD_RUN_SA
    * GCP_PROJECT_ID
    * SERVICE_NAME
 * Following repsository variables are created in each environment. 
    * CODE_DIRECTORY
    * LANGUAGE
    * REGION


## Deploying to DEV 
1. Create a new feature branch from main, make necessary changes to your code. 
2. Raise a pull request from your new feature branch to develop. 
3. When the pull request is raised, the workflow will lint the code to ensure quality and CodeQL will scan the code to ensure there are no vulnerabilities in the code. 
4. If there are no linting issues or CodeQL vulnerabilities, the pull request can be merged after the workflow completes and approvals are received. 
5. Once merged, the image would be built and pushed to Artifact Registry in the Google Cloud project used for development.
6. In develop, once the image is built, it will immediately be deployed to Cloud Run as a new revision in the development project. 

## Deploying to QA 
1. Raise a pull request from develop to main. This will not trigger a workflow. 
2. Once develop is merged to main, the image is built and pushed to the **production** Artifact Registry repository. The reason this is done is to test the image in QA, then re-tag the image for use in production if QA testing is sucessful. 
3. Once the image is pushed to the production Artifact Registry, Cloud Run will pull the image and deploy it to the QA Google Cloud project. 

## Canary Deployments to Production 
1. Go to the Google Cloud console to retrieve the existing revision name. 
2. Go to the workflow named *Canary Deployment to Cloud Run* to trigger the workflow from workflow dispatch. 
3. Insert the existing revision name into the field named *Old Revision Name* and set the traffic split so it adds up to 100%. Feel free to do this a few times to gradually rollout the new revision, increasing the traffic to the new revision each time. 
4. In the console, you can see the new revision will have the URL tag *blue* and the old revision will have the URL tag *green*. This can be used to see which users hit each revision or to have users test the new revision by using the revision URL. 

## Deploying to Production
1. Create a [GitHub Release](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository) to trigger a new production deployment. Once the release is published, the workflow will be triggered. 
2. This environment should have approvals on the workflow, so approvers will need to approve before the image build and before the Cloud Run deployment. 
3. This workflow will re-tag the image with the release tag and will deploy 100% of traffic to the new revision. 
=======
##DB Change Management With Liquibase
#test change

This serves as an example liquibase set up following the liquibase's best practices as outlined on the [liquibase website](http://www.liquibase.org/bestpractices.html).

###SqlFire Example
You will find the required jar files in the lib folder of the packaged version of liquibase. 

* sqlfireclient.jar
* liquibase-sqlfire-3.0.0.jar (sqlfire extensions for liquibase)

The example creates the example schema that was shipped with verion 1.0 of SqlFire and was used in thier documentation. (Airline, Cities, Flights, etc).

The schema generation uses the functionality added in liquibase 3.0 to use annotated sql scripts. This allows for the use of sqlfire's extended keyword set required for sqlfire schemas (collocate, replicate, etc).

It also loads reference data that was provided with the example sqlfire download.

It is important to note that due to the extended keyword set and changes to the information schema from Apache Derby to support sqlfire's distribution, liquibase funcitionality such as database diff/generateChangelog is not supported.


###SqlServer Example


###PostgreSql Example
