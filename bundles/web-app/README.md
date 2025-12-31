# Web App Bundle

Complete web application deployment bundle that generates:

- Kubernetes manifests (Deployment, Service, Ingress)
- Dockerfile with multi-stage build
- docker-compose.yaml for local development
- GitHub Actions CI/CD pipeline

## Usage

### With Interactive Prompts

```bash
conjure bundle bundles/web-app
```

### With Values File

```bash
conjure bundle bundles/web-app -f examples/web-app-values.yaml
```

### With Command-Line Variables

```bash
conjure bundle bundles/web-app \
  --var app_name=my-api \
  --var language=nodejs \
  --var image=ghcr.io/myorg/my-api \
  --var host=api.example.com \
  --var replicas=5
```

## What Gets Generated

```
.
├── k8s/
│   ├── deployment.yaml     # Kubernetes Deployment
│   ├── service.yaml        # Kubernetes Service
│   └── ingress.yaml        # Kubernetes Ingress with TLS
├── .github/
│   └── workflows/
│       └── ci.yaml         # GitHub Actions CI/CD pipeline
├── Dockerfile              # Multi-stage production Dockerfile
└── docker-compose.yaml     # Local development stack
```

## Variables

### Required

- `app_name` - Name of your application
- `language` - Programming language (nodejs, python, go, java)
- `image` - Container image name (e.g., ghcr.io/myorg/myapp)
- `host` - Domain name for ingress (e.g., api.example.com)

### Optional

- `port` - Application port (default: 8080)
- `namespace` - Kubernetes namespace (default: default)
- `replicas` - Number of replicas (default: 3)
- `cpu_request` - CPU request (default: 100m)
- `cpu_limit` - CPU limit (default: 500m)
- `memory_request` - Memory request (default: 128Mi)
- `memory_limit` - Memory limit (default: 512Mi)
- `enable_tls` - Enable TLS/HTTPS (default: true)
- `include_database` - Include PostgreSQL in docker-compose (default: true)
- `include_redis` - Include Redis in docker-compose (default: false)
- `enable_docker` - Build Docker images in CI (default: true)
- `enable_kubernetes_deploy` - Deploy to K8s in CI (default: true)
- `run_tests` - Run tests in CI (default: true)
- `run_lint` - Run linter in CI (default: true)

## Example Values File

See `examples/web-app-values.yaml` for a complete example.
