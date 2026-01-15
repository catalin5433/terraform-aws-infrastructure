
I built this practical learning and proof-of-concept implementation to demonstrate real-world Infrastructure as Code, CI/CD automation and containerization:
https://github.com/catalin5433/terraform-aws-infrastructure

The project delivers a fully automated AWS environment using Terraform, with GitHub Actions managing the deployment pipeline. Any push to the main branch automatically executes:
- terraform init
- terraform plan
- terraform apply


Security-driven design:

 • No credentials stored in source code — AWS access uses encrypted GitHub Secrets
 
 • Terraform state file is stored remotely in a secure AWS S3 bucket
 
 • SSH access is restricted to my real public IP address via a Security Group


Cloud & networking architecture:

 • Custom AWS VPC with Public + Private subnets
 
 • EC2 instance deployed in the public subnet
 
 • Security Groups (SSH restricted, HTTP/HTTPS publicly accessible)


Containers & application layer:

 • EC2 runs an Nginx Docker container serving a presentation website
 
 • The container is built from a custom Docker image and leverages volume mapping to enable dynamic website updates without requiring image rebuilds.
 
 • Amazon Elastic Kubernetes Service (EKS) was also used for Kubernetes-based deployment of the Nginx Docker container, with the cluster and application resources defined using declarative .yaml manifest files
