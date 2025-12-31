# Web App Bundle

Complete web application deployment bundle that generates Kubernetes manifests and Docker Compose configuration.

## Usage

```bash
conjure bundle web-app -o ./output
```

Or with a values file:

```bash
conjure bundle web-app -o ./output -f values.yaml
```

## What Gets Generated

- `deployment.yaml` - Kubernetes Deployment
- `service.yaml` - Kubernetes Service
- `docker-compose.yaml` - Docker Compose for local development

## Required Variables

- `app_name` - Name of your application
- `image` - Container image (for deployment)

## Optional Variables

### Shared Variables
- `namespace` - Kubernetes namespace (default: "default")
- `port` - Application port (default: 8080)

### Deployment Variables
- `replicas` - Number of replicas (default: 3)
- `cpu_request` - CPU request (default: "100m")
- `cpu_limit` - CPU limit (default: "500m")
- `memory_request` - Memory request (default: "256Mi")
- `memory_limit` - Memory limit (default: "512Mi")

### Service Variables
- `service_type` - Service type (default: "ClusterIP")
- `service_port` - Service port (default: 80)

### Docker Compose Variables
- `include_database` - Include PostgreSQL (default: true)
- `include_redis` - Include Redis (default: false)

## Example Values File

```yaml
app_name: my-api
namespace: production
port: 8080
image: ghcr.io/myorg/my-api:1.0.0
replicas: 5
service_type: LoadBalancer
include_database: true
include_redis: true
```
