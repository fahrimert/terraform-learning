# Enterprise-Grade AWS Infrastructure Simulation on LocalStack

![Terraform](https://img.shields.io/badge/Terraform-Infrastructure-purple?logo=terraform)
![LocalStack](https://img.shields.io/badge/LocalStack-AWS%20Emulator-hotpink?logo=localstack)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazon-aws)
![CI/CD](https://img.shields.io/badge/GitHub%20Actions-Automated-blue?logo=github-actions)

This project demonstrates a complete **Infrastructure as Code (IaC)** implementation designed to mimic real-world enterprise cloud environments without incurring cloud costs. By leveraging **Terraform** and **LocalStack**, it simulates a robust AWS architecture featuring **Multi-AZ High Availability**, modular design patterns, and automated **CI/CD pipelines**.

##  Architecture

The infrastructure consists of a modular 3-tier architecture simulated locally:

* **VPC Layer:** A custom VPC spanning multiple Availability Zones (`us-east-1a`, `us-east-1b`).
* **Compute Layer:** EC2 instances deployed across different subnets for High Availability.
* **State Management:** S3 Backend for state storage and DynamoDB for state locking to simulate team collaboration.
* **Automation:** GitHub Actions workflow using Self-Hosted Runners to bypass local network restrictions.

## Key Features

* **Modular Design:** Network (`vpc`) and Compute (`compute`) resources are decoupled into reusable Terraform modules.
* **Multi-AZ Deployment:** Resources are automatically distributed across multiple Availability Zones to ensure high availability.
* **Remote State & Locking:** Prevents state corruption in team environments using S3 (Storage) and DynamoDB (Locking).
* **Environment Isolation:** Uses **Terraform Workspaces** to manage distinct environments with different configurations:
    * **Dev:** Cost-efficient `t2.micro` instances (1 node).
    * **Prod:** Performance-oriented `t3.medium` instances (Scaled to 3 nodes).
* **Zero-Cost Development:** Fully compatible with LocalStack for offline/free cloud simulation.

##  Prerequisites

Before running this project, ensure you have the following installed on your local machine:

* **[Docker](https://www.docker.com/)** & **[Docker Compose](https://docs.docker.com/compose/)**: Required to run the LocalStack container (AWS Emulator).
* **[Terraform](https://developer.hashicorp.com/terraform/downloads)** (v1.0+): Infrastructure as Code tool to provision resources.
* **[AWS CLI](https://aws.amazon.com/cli/)** (v2): Needed to initialize the S3 Backend and DynamoDB table on LocalStack.
* **Git**: To clone the repository.

##  Project Structure

```text
.
├── modules/
│   ├── compute/       # EC2 Instances & Security Group Logic
│   └── vpc/           # Networking (VPC, Subnets, Route Tables)
├── .github/
│   └── workflows/     # CI/CD Pipeline Configuration
├── main.tf            # Root module orchestrating sub-modules
├── backend.tf         # S3 Backend configuration
├── provider.tf        # AWS/LocalStack provider setup
├── outputs.tf         # Global outputs (IPs, IDs)
└── docker-compose.yml # LocalStack configuration
```

## Start LocalStack
```bash
docker-compose up -d
```

##  Prepare Remote Backend

# Create S3 Bucket for State
```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://terraform-state-storage
```

# Create DynamoDB Table for Locking
```bash
aws --endpoint-url=http://localhost:4566 dynamodb create-table \
    --table-name terraform-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```

## Initialize & Deploy

# Initialize Modules & Backend
```bash
terraform init
```

# Create and Select Workspace
```bash
terraform workspace new prod
```

# Apply Configuration
```bash
terraform apply
```

##  CI/CD Pipeline
```text
This project uses GitHub Actions for automated deployments.

Self-Hosted Runner: Configured to run on the local machine to access the LocalStack instance.

Workflow:

Pull Requests: Triggers terraform plan to preview changes.

Push to Main: Triggers terraform apply to deploy changes automatically.
```

##  Clean Up
```bash
terraform destroy -auto-approve
```

```bash
docker-compose down
```


##  Troubleshooting

**Common Issue: "S3 Bucket Not Found" Error**
Since LocalStack is ephemeral, stopping the container (`docker-compose down`) deletes all data, including the Terraform Backend (S3/DynamoDB).
* **Fix:** You must run the S3 and DynamoDB creation commands in the "Getting Started" section **every time** you restart Docker.

**Issue: "Connection Refused"**
Ensure that the `docker-compose` container is fully running and healthy before running Terraform commands.