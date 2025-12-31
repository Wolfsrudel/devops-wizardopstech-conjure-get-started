# Docker Templates

Docker-related templates for containerization.

## Available Templates

### dockerfile
Multi-stage Dockerfile for Node.js, Python, Go, or Java applications.

```bash
# Node.js application
conjure template templates/docker/dockerfile \
  --var language=nodejs \
  --var app_name=my-api \
  --var port=8080

# Python application
conjure template templates/docker/dockerfile \
  --var language=python \
  --var app_name=my-service \
  --var python_version=3.12-slim

# Go application
conjure template templates/docker/dockerfile \
  --var language=go \
  --var app_name=my-server

# Java application
conjure template templates/docker/dockerfile \
  --var language=java \
  --var app_name=my-app \
  --var java_version=17-alpine
```

### docker-compose
Docker Compose configuration for local development with optional database and Redis.

```bash
conjure template templates/docker/docker-compose \
  --var app_name=my-api \
  --var include_database=true \
  --var include_redis=true
```

## Features

- **Multi-stage builds** for smaller production images
- **Non-root users** for security
- **Caching optimization** for faster builds
- **Alpine-based images** for minimal size
- **Production-ready** configurations
