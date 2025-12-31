{{- if eq .language "nodejs" }}
# Node.js Multi-stage Dockerfile
FROM node:{{ .node_version }} AS builder

WORKDIR {{ .working_dir }}

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Build application (if needed)
RUN npm run build || true

# Production stage
FROM node:{{ .node_version }}

WORKDIR {{ .working_dir }}

# Copy dependencies and built application
COPY --from=builder {{ .working_dir }}/node_modules ./node_modules
COPY --from=builder {{ .working_dir }}/dist ./dist
COPY --from=builder {{ .working_dir }}/package*.json ./

# Create non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001
USER nodejs

EXPOSE {{ .port }}

CMD ["node", "dist/index.js"]

{{- else if eq .language "python" }}
# Python Multi-stage Dockerfile
FROM python:{{ .python_version }} AS builder

WORKDIR {{ .working_dir }}

# Install dependencies
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Production stage
FROM python:{{ .python_version }}

WORKDIR {{ .working_dir }}

# Copy dependencies
COPY --from=builder /root/.local /root/.local

# Copy application code
COPY . .

# Create non-root user
RUN useradd -m -u 1001 appuser
USER appuser

# Make sure scripts in .local are usable
ENV PATH=/root/.local/bin:$PATH

EXPOSE {{ .port }}

CMD ["python", "main.py"]

{{- else if eq .language "go" }}
# Go Multi-stage Dockerfile
FROM golang:{{ .go_version }} AS builder

WORKDIR {{ .working_dir }}

# Copy go mod files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Production stage
FROM alpine:latest

WORKDIR /root/

# Copy the binary from builder
COPY --from=builder {{ .working_dir }}/main .

# Install ca-certificates for HTTPS
RUN apk --no-cache add ca-certificates

EXPOSE {{ .port }}

CMD ["./main"]

{{- else if eq .language "java" }}
# Java Multi-stage Dockerfile
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR {{ .working_dir }}

# Copy pom.xml
COPY pom.xml .

# Download dependencies
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build application
RUN mvn clean package -DskipTests

# Production stage
FROM eclipse-temurin:{{ .java_version }}

WORKDIR {{ .working_dir }}

# Copy jar from builder
COPY --from=builder {{ .working_dir }}/target/*.jar app.jar

# Create non-root user
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

EXPOSE {{ .port }}

ENTRYPOINT ["java", "-jar", "app.jar"]

{{- end }}
