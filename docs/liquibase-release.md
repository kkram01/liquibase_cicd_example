# liquibase-release.yaml Reusable Workflow

This workflow is designed to encapsulate all necessary steps to complete the release of liquibase migrations to `prod` environments.


## Overview

This is a GitHub Action Reusable Workflow created for the purpose of establishing a consistent method of updating database migrations for prod environment.

The following sections outline the parameters (i.e., inputs and secrets) as well as the outputs and an example build workflow.

## Inputs
| Name                 | Description                                                                                                |Type|Required|Default|Notes|
|----------------------|------------------------------------------------------------------------------------------------------------|----|--------|-------|-----|
| GOOGLE_CLOUD_PROJECT | The Google Cloud Project in which the SQL_INSTANCE_CONNECTION_NAME secret is stored in the Secrets Manager |string|true|||
| SQL_LOG_LEVEL        | The SQL_LOG_LEVEL setting for the Liquibase.                                                               |string|true||https://docs.liquibase.com/parameters/sql-log-level.html|
| LOG_LEVEL            | The LOG_LEVEL setting for the Liquibase.                                                                   |string|true||https://docs.liquibase.com/parameters/log-level.html|
| URL                  | The JDBC URL setting for the Liquibase to connect with.                                                    |string|true|||
| RUNNER               | The Github action runner platform (linux-only supported for this workflow) to execute the jobs on.         |string|true|||


## Secrets
| Name              | Description                                                                                  |Required|Notes|
|-------------------|----------------------------------------------------------------------------------------------|--------|-----|
| SERVICE_ACCOUNT               | The Service Account that is workload Identity Federated with the pool and Github repo        |true||
| WORKLOAD_IDENTITY_PROVIDER    | The Workload Identity Provider Service Pool which is configured to use with this repository  |true||
| USERNAME          | The account with access to the specified registry.                                           |true||

## Example Release Workflow for Production Environment
The following is an example of how to utilize this reusable workflow.

```yaml
on:
  release:
    types: [published]
  workflow_dispatch:

jobs:
  plan-production:
    name: Liquibase plan and Update
    uses: ./.github/workflows/liquibase-ci.yml
    secrets:
      SERVICE_ACCOUNT: ${{ secrets.SERVICE_ACCOUNT }}
      WORKLOAD_IDENTITY_PROVIDER: ${{ vars.WORKLOAD_IDENTITY_PROVIDER }}
      USERNAME: ${{ secrets.USERNAME }}
    with:
      environment: "prod-plan"
      URL: ${{ vars.URL }}
      GOOGLE_CLOUD_PROJECT: ${{ vars.GOOGLE_CLOUD_PROJECT }}
      SQL_LOG_LEVEL: ${{ vars.SQL_LOG_LEVEL }}
      LOG_LEVEL: ${{ vars.LOG_LEVEL }}
      RUNNER: "ubuntu-latest"

  deploy-production:
    name: Liquibase plan and Update on production
    if:
    uses: ./.github/workflows/liquibase-release.yml
    secrets:
      SERVICE_ACCOUNT: ${{ secrets.SERVICE_ACCOUNT }}
      WORKLOAD_IDENTITY_PROVIDER: ${{ vars.WORKLOAD_IDENTITY_PROVIDER }}
      USERNAME: ${{ secrets.USERNAME }}
    with:
      environment: "prod"
      URL: ${{ vars.URL }}
      GOOGLE_CLOUD_PROJECT: ${{ vars.GOOGLE_CLOUD_PROJECT }}
      SQL_LOG_LEVEL: ${{ vars.SQL_LOG_LEVEL }}
      LOG_LEVEL: ${{ vars.LOG_LEVEL }}
      RUNNER: ${{ vars.RUNNER }}
```
