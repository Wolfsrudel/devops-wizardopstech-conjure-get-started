# Conjure Get Started

Production-ready templates and bundles for Conjure. Clone this repository and start generating Kubernetes manifests, Docker configurations, and more in seconds.

## Quick Start

```bash
# Clone this repository
git clone https://github.com/YOUR_ORG/conjure-get-started.git

# Set your Conjure templates directory to point here
export CONJURE_TEMPLATES_DIR=$(pwd)/conjure-get-started

# Use a template
conjure template deployment.yaml -o deployment.yaml -f examples/deployment-values.yaml

# Or apply a complete bundle
conjure bundle web-app -o ./output -f examples/web-app-values.yaml
```

## What's Inside

### Templates

Individual reusable templates stored in the `templates/` directory. Each template consists of:
- A `.tmpl` file containing the template content
- A `.json` file containing metadata and variable definitions

**Available Templates:**
- `deployment.yaml` - Kubernetes Deployment with health checks and resource limits
- `service.yaml` - Kubernetes Service (ClusterIP, NodePort, LoadBalancer)
- `docker-compose.yaml` - Docker Compose with optional database and Redis

### Bundles

Complete solution packages in the `bundles/` directory. Each bundle contains:
- A `conjure.json` file defining bundle metadata and variables
- Multiple `.tmpl` files that are rendered together

**Available Bundles:**
- `web-app` - Complete web application (Deployment, Service, Docker Compose)

### Examples

Example values files in the `examples/` directory showing how to configure templates and bundles.

## Template Structure

Templates follow this naming pattern:
- Template file: `{name}.{extension}.tmpl`
- Metadata file: `{name}.{extension}.json`

Example:
```
templates/
├── deployment.yaml.tmpl    # Template content
└── deployment.yaml.json    # Variable definitions
```

When using templates, reference them by name without the `.tmpl` extension:
```bash
conjure template deployment.yaml -o my-deployment.yaml
```

## Bundle Structure

Bundles are directories containing:
- `conjure.json` - Bundle metadata
- `*.tmpl` files - Template files

Example:
```
bundles/
└── web-app/
    ├── conjure.json              # Bundle metadata
    ├── deployment.yaml.tmpl      # Deployment template
    ├── service.yaml.tmpl         # Service template
    └── docker-compose.yaml.tmpl  # Docker Compose template
```

The `conjure.json` file defines:
```json
{
  "bundle_type": "kubernetes",
  "bundle_name": "web-app",
  "bundle_description": "Description here",
  "shared_variables": [
    {
      "name": "app_name",
      "description": "Application name",
      "type": "string",
      "required": true,
      "default": ""
    }
  ],
  "template_variables": {
    "deployment.yaml.tmpl": [
      {
        "name": "replicas",
        "description": "Number of replicas",
        "type": "int",
        "required": false,
        "default": "3"
      }
    ]
  }
}
```

## Usage Examples

### Using Individual Templates

Generate a Kubernetes deployment:

```bash
conjure template deployment.yaml -o deployment.yaml \
  --var app_name=my-api \
  --var image=my-api:1.0.0 \
  --var replicas=3
```

Generate with a values file:

```bash
conjure template deployment.yaml -o deployment.yaml \
  -f examples/deployment-values.yaml
```

### Using Bundles

Deploy a complete web application:

```bash
conjure bundle web-app -o ./k8s -f examples/web-app-values.yaml
```

This generates:
- `k8s/deployment.yaml` - Kubernetes Deployment
- `k8s/service.yaml` - Kubernetes Service
- `k8s/docker-compose.yaml` - Docker Compose configuration

## Variable Types

Templates and bundles support these variable types:
- `string` - Text values
- `int` - Integer numbers
- `bool` - Boolean (true/false)

## Creating Your Own

### Custom Template

1. Create template file `templates/mytemplate.yaml.tmpl`:
   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: {{.name}}
   data:
     key: {{.value}}
   ```

2. Create metadata file `templates/mytemplate.yaml.json`:
   ```json
   {
     "template_name": "mytemplate.yaml",
     "description": "My custom template",
     "variables": [
       {
         "name": "name",
         "description": "ConfigMap name",
         "type": "string",
         "required": true,
         "default": ""
       },
       {
         "name": "value",
         "description": "Configuration value",
         "type": "string",
         "required": false,
         "default": "default-value"
       }
     ]
   }
   ```

### Custom Bundle

1. Create bundle directory: `bundles/my-bundle/`

2. Create `conjure.json` with bundle metadata

3. Add `.tmpl` files for each template in the bundle

See existing bundles for examples.

## Contributing

Contributions welcome! Please:

1. Follow existing template patterns
2. Include proper metadata in `.json` files
3. Provide example values files
4. Test your templates/bundles before submitting
5. Document all variables

## License

MIT License - see LICENSE file for details
