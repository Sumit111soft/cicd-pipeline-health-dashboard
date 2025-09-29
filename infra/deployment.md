
# Deployment Guide

## Overview
This infra provisions:
- VPC + Public Subnet + IGW
- Security Groups for EC2 and RDS
- RDS Postgres instance
- EC2 instance that will build and run the app using Docker Compose

> IMPORTANT: This Terraform template assumes your application source code is available in a public Git repository. Update `var.git_repo` or the `user_data.sh` script before applying.

## Steps
1. Install Terraform and AWS CLI, configure AWS credentials.
2. Place your SSH public key path at `~/.ssh/id_rsa.pub` or update variable.
3. Edit `infra/terraform.tfvars` to set db_password, git_repo, and admin_cidr.
4. Run:
```bash
cd infra
terraform init
terrafrom plan
terraform apply
```
5. After apply, note the output `instance_public_ip`. Visit `http://<instance_public_ip>/` to see the frontend.

## Notes
- RDS is not publicly accessible. EC2 has access to RDS via security groups.
- For production, consider private subnets, backups, and stronger secrets handling (use SSM Parameter Store or Secrets Manager).

## Destroy Infra
```bash
terraform destroy
```
