# Conjure Get Started

A collection of production-ready templates and bundles for Conjure. Clone this repository and start generating infrastructure, application configs, and CI/CD pipelines in seconds.

## Quick Start

```bash
# Clone this repository
git clone https://github.com/YOUR_ORG/conjure-get-started.git
cd conjure-get-started

# Use a template
conjure template templates/kubernetes/deployment -f examples/web-app-values.yaml

# Or apply a complete bundle
conjure bundle bundles/web-app -f examples/web-app-values.yaml
```

## What's Inside

### Templates

Individual reusable templates for common configurations:

#### Kubernetes
- **deployment** - Kubernetes Deployment with configurable replicas, resources, and health checks
- **service** - Kubernetes Service (ClusterIP, NodePort, LoadBalancer)
- **ingress** - Kubernetes Ingress with TLS support
- **configmap** - ConfigMap for application configuration
- **secret** - Secret for sensitive data
- **hpa** - Horizontal Pod Autoscaler
- **namespace** - Namespace with resource quotas and limits

#### Docker
- **dockerfile** - Multi-stage Dockerfile for various languages (Node.js, Python, Go, Java)
- **docker-compose** - Docker Compose for local development
- **dockerignore** - Comprehensive .dockerignore file

#### Terraform - AWS
- **vpc** - VPC with public/private subnets across availability zones
- **eks** - EKS cluster with node groups
- **rds** - RDS database (PostgreSQL, MySQL)
- **s3** - S3 bucket with versioning and encryption
- **iam-role** - IAM role with trust policy
- **lambda** - Lambda function with API Gateway

#### Terraform - Azure
- **resource-group** - Azure Resource Group
- **aks** - Azure Kubernetes Service cluster
- **vnet** - Virtual Network with subnets
- **storage-account** - Storage Account with containers

#### Terraform - GCP
- **project** - GCP project setup
- **gke** - Google Kubernetes Engine cluster
- **vpc** - VPC network with subnets
- **cloud-sql** - Cloud SQL instance

#### CI/CD - GitHub Actions
- **node-ci** - Node.js CI/CD pipeline (test, build, deploy)
- **docker-build** - Docker build and push to registry
- **terraform-plan** - Terraform plan and apply workflow
- **release** - Release automation with changelog

#### CI/CD - GitLab CI
- **node-pipeline** - Node.js GitLab CI pipeline
- **docker-pipeline** - Docker build pipeline
- **k8s-deploy** - Kubernetes deployment pipeline

#### Configuration
- **nginx** - Nginx configuration for reverse proxy/static hosting
- **env** - Environment variable templates
- **gitignore** - Comprehensive .gitignore files

#### Monitoring
- **prometheus** - Prometheus configuration
- **grafana** - Grafana dashboard definitions
- **alerts** - Prometheus alert rules

### Bundles

Complete solution packages that generate multiple related files:

- **web-app** - Complete web application deployment (Kubernetes manifests, Dockerfile, docker-compose, CI/CD)
- **microservices** - Microservices platform with API gateway, services, monitoring
- **aws-infrastructure** - Complete AWS infrastructure (VPC, EKS, RDS, S3)
- **azure-infrastructure** - Complete Azure infrastructure (AKS, Database, Storage)
- **monitoring-stack** - Complete monitoring solution (Prometheus, Grafana, Alertmanager)
- **ci-cd-platform** - Complete CI/CD setup for GitHub/GitLab

## Usage Examples

### Using Individual Templates

Generate a Kubernetes deployment:

```bash
conjure template templates/kubernetes/deployment \
  --var app_name=my-api \
  --var image=my-api:1.0.0 \
  --var replicas=3 \
  --var port=8080
```

Generate with a values file:

```bash
conjure template templates/kubernetes/deployment -f examples/api-values.yaml
```

### Using Bundles

Deploy a complete web application:

```bash
conjure bundle bundles/web-app -f examples/web-app-values.yaml
```

This generates:
- Kubernetes Deployment, Service, and Ingress
- Dockerfile and docker-compose.yml
- GitHub Actions CI/CD pipeline
- Environment configuration files

## Directory Structure

```
conjure-get-started/
├── templates/           # Individual reusable templates
│   ├── kubernetes/     # Kubernetes manifests
│   ├── docker/         # Docker-related files
│   ├── terraform/      # Terraform configurations
│   ├── ci-cd/          # CI/CD pipelines
│   ├── config/         # Configuration files
│   └── monitoring/     # Monitoring configs
├── bundles/            # Complete solution bundles
│   ├── web-app/
│   ├── microservices/
│   └── aws-infrastructure/
├── examples/           # Example values files
│   ├── web-app-values.yaml
│   ├── microservices-values.yaml
│   └── infrastructure-values.yaml
└── README.md
```

## Creating Your Own

### Custom Template

1. Create a directory in `templates/`
2. Add your template files with Conjure variables (e.g., `{{ .app_name }}`)
3. Create a `template.yaml` metadata file (optional but recommended)

### Custom Bundle

1. Create a directory in `bundles/`
2. Add a `bundle.yaml` configuration
3. Reference templates to include
4. Define variables

Example `bundle.yaml`:

```yaml
name: my-bundle
description: My custom bundle
version: 1.0.0

templates:
  - name: deployment
    template: kubernetes/deployment
    output: k8s/deployment.yaml

  - name: service
    template: kubernetes/service
    output: k8s/service.yaml

variables:
  - name: app_name
    description: Application name
    required: true
  - name: environment
    description: Environment (dev/staging/prod)
    default: dev
```

## Contributing

Contributions welcome! Please:

1. Follow existing template patterns
2. Include a README in your template/bundle directory
3. Provide example values files
4. Test your templates/bundles before submitting
5. Document all variables

## License

MIT License - see LICENSE file for details
