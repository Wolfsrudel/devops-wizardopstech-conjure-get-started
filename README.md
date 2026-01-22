# Conjure Get Started

Example eady templates and bundles for Conjure. Clone this repository and start generating Kubernetes manifests, Terraform configurations, configuration files, and more.

## Quick Start

Configure Conjure to use this repository using one of three methods:

### Option 1: Global Configuration

Configure Conjure to use this repository for all projects:

```bash
# Clone the repository
git clone https://github.com/WizardOpsTech/conjure-get-started.git
cd conjure-get-started

# Create global config
cat > ~/.conjure.yaml << EOF
templates_dir: $(pwd)
EOF

# Verify configuration
conjure list templates
```

### Option 2: Environment Variable

Set a temporary configuration using environment variables:

```bash
# Clone the repository
git clone https://github.com/WizardOpsTech/conjure-get-started.git
cd conjure-get-started

# Set environment variable
export CONJURE_TEMPLATES_DIR=$(pwd)

# List available templates
conjure list templates
```

### Option 3: Project-Local Configuration

Create a project-specific configuration:

```bash
# Clone the repository
git clone https://github.com/WizardOpsTech/conjure-get-started.git

# Create project config
cat > conjure.yaml << EOF
templates_dir: ./conjure-get-started
EOF

# Use with --config flag
conjure list templates --config conjure.yaml
conjure template k8s-deployment -o deployment.yaml --config conjure.yaml
```

## Repository Contents

This repository contains 27 templates and 4 bundles organized by category.

### Templates

All templates follow the versioned directory structure: `templates/<name>/<version>/`

#### Kubernetes (8 Templates)

| Template | Type | Description | Output |
|----------|------|-------------|--------|
| `k8s-deployment` | kubernetes | Deployment with health checks and resource limits | deployment.yaml |
| `k8s-service` | kubernetes | Service (ClusterIP, NodePort, LoadBalancer) | service.yaml |
| `k8s-ingress-nginx` | kubernetes | NGINX Ingress with TLS, CORS, rate limiting | ingress.yaml |
| `k8s-cert-manager` | kubernetes | Cert-Manager Certificate for automated TLS | certificate.yaml |
| `k8s-configmap` | kubernetes | ConfigMap for application configuration | configmap.yaml |
| `k8s-secret` | kubernetes | Secret with Base64 encoding | secret.yaml |
| `k8s-hpa` | kubernetes | Horizontal Pod Autoscaler | hpa.yaml |
| `argocd-application` | kubernetes | ArgoCD Application for GitOps | application.yaml |

#### Cloud Infrastructure (3 Templates)

| Template | Type | Description | Output |
|----------|------|-------------|--------|
| `terraform-aws-ec2` | terraform | AWS EC2 instance with VPC and security groups | main.tf |
| `terraform-azure-vm` | terraform | Azure VM with networking | main.tf |
| `terraform-gcp-vm` | terraform | GCP Compute Engine with firewall | main.tf |

#### CI/CD & Containers (5 Templates)

| Template | Type | Description | Output |
|----------|------|-------------|--------|
| `github-actions-ci` | ci-cd | GitHub Actions workflow | ci.yaml |
| `gitlab-ci` | ci-cd | GitLab CI pipeline | .gitlab-ci.yaml |
| `jenkinsfile` | ci-cd | Jenkins declarative pipeline | Jenkinsfile |
| `dockerfile` | docker | Multi-stage Dockerfile | Dockerfile |
| `docker-compose` | docker | Docker Compose with PostgreSQL/Redis | docker-compose.yaml |

#### Application Configuration (6 Templates)

| Template | Type | Description | Output |
|----------|------|-------------|--------|
| `hashicorp-vault-config` | config | HashiCorp Vault server configuration | vault.hcl |
| `nginx-config` | config | NGINX reverse proxy with SSL/TLS | nginx.conf |
| `prometheus-config` | config | Prometheus scrape configuration | prometheus.yaml |
| `grafana-dashboard` | config | Grafana dashboard JSON | dashboard.json |
| `redis-config` | config | Redis server configuration | redis.conf |
| `postgresql-config` | config | PostgreSQL tuning and settings | postgresql.conf |

#### System & Utilities (3 Templates)

| Template | Type | Description | Output |
|----------|------|-------------|--------|
| `systemd-service` | system | Linux systemd service unit | service |
| `env-file` | system | Environment variables file | .env |
| `cron-job` | system | Crontab entry for scheduled tasks | crontab |

#### Gaming (2 Templates)

| Template | Type | Description | Output |
|----------|------|-------------|--------|
| `minecraft-server` | gaming | Minecraft server configuration | server.properties |
| `palworld-server` | gaming | Palworld dedicated server | PalWorldSettings.ini |

### Bundles

Complete solution packages that generate multiple related files:

| Bundle | Type | Description | Generates |
|--------|------|-------------|-----------|
| `k8s-web-app` | kubernetes | Complete web application stack | Deployment, Service, Ingress |
| `k8s-microservice` | kubernetes | Microservice with observability | Deployment, Service, ConfigMap, ServiceMonitor |
| `docker-stack` | docker | Complete development environment | Docker Compose, Dockerfile |
| `terraform-aws-vpc` | terraform | Complete AWS VPC infrastructure | VPC, Subnets, IGW, Route Tables |

## Usage Examples

### Templates

**Interactive mode** (prompts for required variables):
```bash
conjure template k8s-deployment -o deployment.yaml
```

**Non-interactive with variables**:
```bash
conjure template k8s-deployment -o deployment.yaml \
  --var app_name=my-api \
  --var image=my-api:1.0.0 \
  --var replicas=3
```

**Using a values file**:
```bash
conjure template k8s-deployment -o deployment.yaml \
  -f values-examples/k8s-deployment-example.yaml
```

**Filter by type**:
```bash
conjure list templates --type kubernetes
conjure list templates --type terraform
conjure list templates --type ci-cd
```

**Specify version**:
```bash
conjure template k8s-deployment --version 1.0.0 -o deployment.yaml
```

### Bundles

**Interactive mode**:
```bash
conjure bundle k8s-web-app -o ./output
```

**Using a values file**:
```bash
conjure bundle k8s-web-app -o ./k8s \
  -f values-examples/k8s-web-app-bundle-example.yaml
```

**Filter bundles by type**:
```bash
conjure list bundles --type kubernetes
conjure list bundles --type terraform
```