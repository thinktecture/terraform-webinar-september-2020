# Terraform Webinar September 2020

The [src](src) folder contains all the [Terraform](https://terraform.io) script created during the webinar. In order to use those scripts locally, go ahead and install `terraform` on your local machine.

## Requirements

This example demonstrates how to create [Azure](https://azure.com) infrastructures using Terraform. That said, some authentication context has to be established with Azure to interact with your Azure Subscription.

The Azure Provider for Terraform offers several ways how to authenticate. Simples is of course re-using existing authentication tokens from Azure CLI (`az`). 

For production usage, you should create a dedicated *Service Principal* and provide authentication information using the following environment variables:

```bash
# Service Principal Client ID
ARM_CLIENT_ID=xxx
# Service Principal Client Secret (aka Password)
ARM_CLIENT_SECRET=xxx

# Azure Subscription ID
ARM_SUBSCRIPTION_ID=xxx
# Azure Tenant ID
ARM_TENANT_ID=xxx

```

Please verify that your Service Principal has sufficient *Role Assignments* to interact with your Azure Subscription. Required *Role Assignments* may vary depending on the actual Terraform project. For demonstration purpose, the Service Principal used during the webinar had *Contributor* permissions on the scope of the Azure Subscription.

## Backend Storage

When working with Terraform, you should use a so-called *State Backend*. This example uses a dedicated *Azure Storage Account* as *State Backend* (see [meta.tf](src/meta.tf)). Terraform requires an *Access Key* to read and write the Terraform State to the Storage Account. The access key must be provided as environment variable too:

```bash
# State Backend - Access Key
ARM_ACCESS_KEY=xxx

```

## GitHub Actions

See the GitHub Actions [workflow file](.github/workflows/deploy.yml), it is used to walk through the Terraform lifecycle for push operations on the master branch. Additionally, pull requests are also processed. However, `terraform apply` is only invoked for `push` operations on the `master`.

## The Terraform Lifecycle

### Initializing the project

```bash
cd src
terraform init

```

### Reformat Terraform Project

```bash
cd src
terraform fmt

```

### Validate Terraform Project

```bash
cd src
terraform validate

```

### Preview Changes

```bash
cd src
terraform plan

```

### Apply Changes

```bash
cd src
terraform apply

```

### Destroy the Infrastructure

```bash
cd src
terraform destroy

```