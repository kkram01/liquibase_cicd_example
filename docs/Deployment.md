# Deployment

## Overview

There are two Github workflows under the .github/workflows/ folder used to facilitate CI/CD process of Database schema updation in dev, qa and prod environments using Liquibase
- ci.yaml does the following during dev and QA:
    * Setup Gcloud authentication with Workload Identity Federation
    * Fetch the CONNECTION_STRING
    * Establish cloudSQL proxy connection to the SQL database
    * Setup liquibase and run liquibase status. Print SQL to be executed as an artifact to the workflow
    * Additionally, if triggered due to a push request, the liquibase update is run to execute the changes on the respective environment based on which the push is triggered (dev for develop branch and QA for main branch)
- release.yaml
    * Executes database changes in the production environment on creation of a release from the main branch.

## Deployment into dev, QA, and prod
### Dev environment
- Make a new branch, `your-branch`, off of the `develop` branch and make your changes.
- Create a PR merging `your-branch` into `develop`.
    - This will run checks on your changes, attaches the SQL script to be executed as an artifact to the workflow run. This should be reviewed and approved before merging.
- Once merged, liquibase update command will be run and changes will be deployed to the `dev` environment.
- Test on `dev`
### QA environment
- When testing is completed successfully in dev environment create a PR merging `develop` into `main`.
    - This will again run checks on your changes, adds a SQL script to be reviewed before merging to the workflow.
- Then merge `develop` into `main` and the database changes will be deployed to the `qa` environment.
- Test again on `qa ` for quality assurance.
### Prod environment
- When QA is completed successfully, you can now promote to `prod`.
- To do this, you will have to create release from the `main` branch with the appropriate tag and release notes.
- Once this is done, a plan will be run on the github workflow and an artifact of the SQL script to be run will be attached to the workflow.
- If approved and published, this will execute the same database changes on `prod`.


## References
- [Creating a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)
- [Using environments for deployment](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)
- [Reviewing deployments](https://docs.github.com/en/actions/managing-workflow-runs/reviewing-deployments)

### Deployment diagram
![Liquibase Migrations Deployment](liquibase-migrations-workflow.jpeg "Liquibase Migrations Deployment")