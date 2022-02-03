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


### Terraform provisioning

https://www.blendmastersoftware.com/blog/deploying-to-azure-using-terraform-and-github-actions


#### Terraform plan on push to master branch
```yaml
name: Terraform PLan

on:
  push:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest

    env:
      ARM_CLIENT_ID: ${{secrets.TF_ARM_CLIENT_ID}}
      ARM_CLIENT_SECRET: ${{secrets.TF_ARM_CLIENT_SECRET}}
      ARM_SUBSCRIPTION_ID: ${{secrets.TF_ARM_SUBSCRIPTION_ID}}
      ARM_TENANT_ID: ${{secrets.TF_ARM_TENANT_ID}}

    steps:
      - uses: actions/checkout@v2

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1

      - name: Terraform Init
        run: terraform init
        working-directory: ./terraform

      - name: Terraform Plan
        run: terraform plan --var-file="test/test.tfvars"
        working-directory: ./terraform
```

#### Terraform plan on a pull request

A pull request into master can trigger a workflow which outputs the terraform plan:

```yaml
name: Terraform Plan

on:
  pull_request:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest

    env:
      ARM_CLIENT_ID: ${{secrets.TF_ARM_CLIENT_ID}}
      ARM_CLIENT_SECRET: ${{secrets.TF_ARM_CLIENT_SECRET}}
      ARM_SUBSCRIPTION_ID: ${{secrets.TF_ARM_SUBSCRIPTION_ID}}
      ARM_TENANT_ID: ${{secrets.TF_ARM_TENANT_ID}}

    steps:
      - uses: actions/checkout@v2

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1

      - name: Terraform Init
        run: terraform init
        working-directory: ./terraform

      - name: Terraform Plan
        run: terraform plan --var-file="test/test.tfvars"
        working-directory: ./terraform
```



#### Terraform apply on a merge

A merge into master can trigger a workflow which runs terraform apply:

```yaml
name: Terraform Apply

on:
  push:
    branches:
      - main

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
        working-directory: ./terraform

      - name: Terraform Apply
        run: terraform apply -auto-approve --var-file="test/test.tfvars"
        working-directory: ./terraform
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



























