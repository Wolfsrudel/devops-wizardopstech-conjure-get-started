# Quick Start Guide

Get started with Conjure templates in minutes.

## Installation

First, install Conjure:

**macOS/Linux:**
```bash
curl -fsSL https://conjure.sh/install.sh | sh
```

**Windows (PowerShell):**
```powershell
iwr https://conjure.sh/install.ps1 -useb | iex
```

## Clone This Repository

```bash
git clone https://github.com/YOUR_ORG/conjure-get-started.git
cd conjure-get-started
```

## Your First Template

Generate a Kubernetes deployment:

```bash
conjure template templates/kubernetes/deployment \
  --var app_name=hello-world \
  --var image=nginx:latest \
  --var replicas=3
```

This creates a `deployment.yaml` file ready to apply to your cluster.

## Using Values Files

Create a values file for your application:

```yaml
# my-app-values.yaml
app_name: my-awesome-api
image: ghcr.io/myorg/my-api:latest
namespace: production
replicas: 5
port: 8080
cpu_limit: 1000m
memory_limit: 1Gi
```

Generate the deployment:

```bash
conjure template templates/kubernetes/deployment -f my-app-values.yaml
```

## Using Bundles

Bundles generate multiple related files at once.

### Web Application Bundle

This generates everything you need for a web app:

```bash
conjure bundle bundles/web-app -f examples/web-app-values.yaml
```

Generated files:
```
k8s/
  deployment.yaml   # Kubernetes Deployment
  service.yaml      # Kubernetes Service
  ingress.yaml      # Kubernetes Ingress
.github/
  workflows/
    ci.yaml         # CI/CD pipeline
Dockerfile          # Production Dockerfile
docker-compose.yaml # Local development
```

### Microservices Platform

Generate a complete microservices setup:

```bash
conjure bundle bundles/microservices -f examples/microservices-values.yaml
```

## Interactive Mode

Not sure what variables are needed? Run in interactive mode:

```bash
conjure template templates/kubernetes/deployment
```

Conjure will prompt you for each required variable.

## Common Workflows

### Deploy a New Web App

1. **Create your values file:**
   ```yaml
   # production.yaml
   app_name: my-api
   language: nodejs
   image: ghcr.io/myorg/my-api
   host: api.example.com
   replicas: 3
   ```

2. **Generate all configurations:**
   ```bash
   conjure bundle bundles/web-app -f production.yaml
   ```

3. **Review and apply:**
   ```bash
   kubectl apply -f k8s/
   ```

### Create Infrastructure

1. **Generate Terraform for AWS VPC:**
   ```bash
   conjure template templates/terraform/aws/vpc \
     --var vpc_name=production-vpc \
     --var vpc_cidr=10.0.0.0/16 \
     --var availability_zones=3
   ```

2. **Apply with Terraform:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

### Setup CI/CD

Generate GitHub Actions workflow:

```bash
conjure template templates/ci-cd/github-actions/node-ci \
  --var app_name=my-api \
  --var enable_docker=true \
  --var enable_kubernetes_deploy=true
```

## Tips

### Preview Without Creating Files

Use `--dry-run` to see what would be generated:

```bash
conjure template templates/kubernetes/deployment \
  --var app_name=test \
  --var image=nginx \
  --dry-run
```

### Specify Output Location

Control where files are created:

```bash
conjure template templates/kubernetes/deployment \
  --var app_name=my-api \
  --var image=my-api:latest \
  --output ./k8s/deployment.yaml
```

### Override Individual Values

Start with a values file and override specific values:

```bash
conjure bundle bundles/web-app \
  -f production.yaml \
  --var replicas=10
```

## Next Steps

- Browse `templates/` to see all available templates
- Check `bundles/` for complete solutions
- Look at `examples/` for configuration examples
- Read `CONTRIBUTING.md` to add your own templates

## Get Help

```bash
conjure --help
conjure template --help
conjure bundle --help
```

Visit [conjure.sh/docs](https://conjure.sh/docs) for full documentation.
