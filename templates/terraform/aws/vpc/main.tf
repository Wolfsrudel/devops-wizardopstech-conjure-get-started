terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, {{ .availability_zones }})

  public_subnets  = [for k, v in local.azs : cidrsubnet("{{ .vpc_cidr }}", 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet("{{ .vpc_cidr }}", 8, k + 10)]
}

data "aws_availability_zones" "available" {
  state = "available"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = "{{ .vpc_cidr }}"
  enable_dns_hostnames = {{ .enable_dns_hostnames }}
  enable_dns_support   = {{ .enable_dns_support }}

  tags = {
    Name        = "{{ .vpc_name }}"
    Environment = "{{ .environment }}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "{{ .vpc_name }}-igw"
    Environment = "{{ .environment }}"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count = length(local.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_subnets[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "{{ .vpc_name }}-public-${local.azs[count.index]}"
    Environment = "{{ .environment }}"
    Type        = "public"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count = length(local.private_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnets[count.index]
  availability_zone = local.azs[count.index]

  tags = {
    Name        = "{{ .vpc_name }}-private-${local.azs[count.index]}"
    Environment = "{{ .environment }}"
    Type        = "private"
  }
}

{{- if .enable_nat_gateway }}
# Elastic IPs for NAT Gateways
resource "aws_eip" "nat" {
  count  = {{ .availability_zones }}
  domain = "vpc"

  tags = {
    Name        = "{{ .vpc_name }}-nat-eip-${count.index + 1}"
    Environment = "{{ .environment }}"
  }

  depends_on = [aws_internet_gateway.main]
}

# NAT Gateways
resource "aws_nat_gateway" "main" {
  count = {{ .availability_zones }}

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name        = "{{ .vpc_name }}-nat-${local.azs[count.index]}"
    Environment = "{{ .environment }}"
  }

  depends_on = [aws_internet_gateway.main]
}
{{- end }}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "{{ .vpc_name }}-public-rt"
    Environment = "{{ .environment }}"
  }
}

# Public Route Table Association
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

{{- if .enable_nat_gateway }}
# Private Route Tables
resource "aws_route_table" "private" {
  count = {{ .availability_zones }}

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name        = "{{ .vpc_name }}-private-rt-${local.azs[count.index]}"
    Environment = "{{ .environment }}"
  }
}

# Private Route Table Associations
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
{{- end }}

{{- if .enable_vpn_gateway }}
# VPN Gateway
resource "aws_vpn_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "{{ .vpc_name }}-vpn-gw"
    Environment = "{{ .environment }}"
  }
}
{{- end }}

# Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

{{- if .enable_nat_gateway }}
output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.main[*].id
}
{{- end }}
