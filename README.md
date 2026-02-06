# Conjure Get Started

Example ready templates and bundles for Conjure. Clone this repository and start generating Kubernetes manifests, Terraform configurations, configuration files, and more.

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
