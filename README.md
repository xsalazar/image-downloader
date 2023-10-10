> **Warning**
> This repository has been archived as Google is now properly returning CORS headers and this workaround is no longer necessary.

# 💿 Image Downloader

This repository holds both the Terraform infrastructure code as well as the simple Javascript application that runs inside the AWS Lambda function.

This application code is a basic image downloading service that takes in a URL to a [Google Emoji Kitchen](https://blog.google/products/android/emoji-kitchen-new-mashups-mixing-experience/) source image, download it, and send the data to the front-end client.

The infrastructure supporting this backend application is a simple public API Gateway that forwards valid requests to the Lambda function.

This backend application is used to support the website [https://emojikitchen.dev](https://emojikitchen.dev) for quick and reliable bulk downloads.

## Why?

This backend application is required because Google does not allow cross-origin requests on their source URLs. Specifically, their [source images](https://www.gstatic.com/android/keyboard/emojikitchen/20201001/u1f600/u1f600_u1f914.png) do not have the `access-control-allow-origin` header set to `*`. Without this header, requests from other domains cannot be made to it via a users browser.

## Getting Started

This repository leverages [VSCode's devcontainer](https://code.visualstudio.com/docs/remote/containers) feature to ensure all necessary dependencies are available inside the container for development.

### Application

The application code for this repository is contained in the [`./app`](./app) directory.

To get started:

```bash
cd app/ && npm init
```

All application deployments are managed via GitHub Actions and the [`./.github/workflows/deploy_application.yml`](./.github/workflows/deploy_application.yml) workflow.

### Infrastructure

The infrastructure code for this repository is contained in the [`./terraform`](./terraform) directory. The required Terraform version is `1.1.2`. The AWS artifacts managed in this repository are illustrated below.

To get started:

```bash
cd terraform/ && terraform init
```

All infrastructure deployments are managed via GitHub Actions and the [`./.github/workflows/deploy_infrastructure.yml`](./.github/workflows/deploy_infrastructure.yml) workflow.

![](./assets/architecture.svg)
