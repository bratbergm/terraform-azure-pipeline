# terraform-azure-pipeline





# GitHub Actions

https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions 

### Basics

- **Workflows** can be triggered when an **event** occurs in the repository
- Workflows contains one or more **jobs**
  - Can run in sequential order or in parallel
- Each job has one or more **steps**
  - Can be scripts you define
  - Can be an **action**: Apps in the GitHub Actions platform, or self-written 
- **Runners**
  - The server that runs the workflows
    - GitHub-hosted
    - Self-hosted





### Workflows

- YAML files in .github/workflows



```yaml
name: learn-github-actions 	# Name that will appear in the GiHub repo
on: [push]					# The trigger for this workflow. (push to any branch)
jobs:						# All the jobs in this workflow
  check-bats-version:		# Defines a job
    runs-on: ubuntu-latest	# The runner
    steps:					# The steps in this job
      - uses: actions/checkout@v2	# Checks out the repo onto the runner
      - uses: actions/setup-node@v2 
        with:
          node-version: '14'
      - run: npm install -g bats # Tells the job to execute a command on the runner
      - run: bats -v
```



### Terraform provisioning

https://www.blendmastersoftware.com/blog/deploying-to-azure-using-terraform-and-github-actions

#### Terraform plan on a pull request

A pull request into master can trigger a workflow which outputs the terraform plan:

```yaml
name: Terraform Plan

on:
	pull_request:
		branches: [master]
		
jobs:
	terraform:
		runs-on: ubuntu-latest
		
		env:
          ARM_CLIENT_ID: ${{secrets.TF_ARM_CLIENT_ID}
          ARM_CLIENT_SECRET: ${{secrets.TF_ARM_CLIENT_SECRET}}
          ARM_SUBSCRIPTION_ID: ${{secrets.TF_ARM_SUBSCRIPTION_ID}}
          ARM_TENANT_ID: ${{secrets.TF_ARM_TENANT_ID}}

        steps:							# add snyk or something here
          - uses: actions/checkout@v2

          - name: Setup Terraform
            uses: hashicorp/setup-terraform@v1

          - name: Terraform Init
            run: terraform init

          - name: Terraform Format
            run: terraform fmt -check

          - name: Terraform Plan
            run: terraform plan
```



#### Terraform apply on a merge

A merge into master can trigger a workflow which runs terraform apply:

```yaml
name: Terraform Apply

on:
  push:
    branches: [ master ]

jobs:
  terraform:
    runs-on: ubuntu-latest

    env:
      ARM_CLIENT_ID: ${{secrets.TF_ARM_CLIENT_ID}
      ARM_CLIENT_SECRET: ${{secrets.TF_ARM_CLIENT_SECRET}}
	  ARM_SUBSCRIPTION_ID: ${{secrets.TF_ARM_SUBSCRIPTION_ID}}
	  ARM_TENANT_ID: ${{secrets.TF_ARM_TENANT_ID}}

    steps:
      - uses: actions/checkout@v2

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1

      - name: Terraform Init
        run: terraform init

      - name: Terraform Apply
        run: terraform apply -auto-approve
```



#### Authentication to Azure 

- Create Azure Service Principal

  Azure CLI:

  ```
  az ad sp create-for-rbac --name "sp-hello-azure-tf" --role Contributor --scopes /subscriptions/<subscription-id> --sdk-auth 
  ```

- In GitHub -> Settings -> Secrets: add TF_ARM_CLIENT_SECRET from output



#### Secrets Management

- GitHub actions provisioning to Azure requires secrets stored in GitHub (?)

- In Azure DevOps it's possible to use Key Vault to store secrets and pass them as variables in the terraform init command in the pipeline (https://julie.io/writing/terraform-on-azure-pipelines-best-practices/#tip-4---authenticate-with-service-principal-credentials-stored-in-azure-key-vault). This way there is no need to have secrets saved multiple places.



























