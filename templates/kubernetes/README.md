# Kubernetes Templates

Production-ready Kubernetes manifest templates.

## Available Templates

### deployment
Kubernetes Deployment with configurable replicas, resources, and health checks.

```bash
conjure template templates/kubernetes/deployment \
  --var app_name=my-api \
  --var image=my-api:1.0.0 \
  --var replicas=3
```

### service
Kubernetes Service (ClusterIP, NodePort, or LoadBalancer).

```bash
conjure template templates/kubernetes/service \
  --var app_name=my-api \
  --var service_type=ClusterIP
```

### ingress
Kubernetes Ingress with TLS support.

```bash
conjure template templates/kubernetes/ingress \
  --var app_name=my-api \
  --var host=api.example.com \
  --var service_name=my-api
```

### configmap
ConfigMap for application configuration.

```bash
conjure template templates/kubernetes/configmap \
  --var app_name=my-api \
  --var config_data='{"KEY1":"value1","KEY2":"value2"}'
```

## Common Patterns

### Complete Application Stack

```bash
# Deployment
conjure template templates/kubernetes/deployment \
  -f values/production.yaml

# Service
conjure template templates/kubernetes/service \
  -f values/production.yaml

# Ingress
conjure template templates/kubernetes/ingress \
  -f values/production.yaml
```

Or use the web-app bundle to generate all at once:

```bash
conjure bundle bundles/web-app -f values/production.yaml
```
