This repository provides a framework to deploy and manage a Kubernetes application with a SQL-backed database using infrastructure as code (Terraform) and GitHub Actions for CI/CD.
Infrastructure (Terraform Folder)

The Terraform folder contains the configurations required to deploy the infrastructure. The deployment steps involve:

    GKE Cluster:
        Creates a single-zone Google Kubernetes Engine (GKE) cluster to host the application.

    SQL Instance:
        Creates a Cloud SQL instance.
        Generates a random database password stored securely in Google Secret Manager.

    Secret Management:
        Automates storing and retrieving sensitive data securely.

Deployment Steps

    Clone this repository.
    Navigate to the terraform folder.
    Run Terraform commands to deploy the infrastructure:

    terraform init
    terraform apply

TODOs

    Integrate Atlantis:
        Set up Atlantis on GitHub for automated Terraform plan and apply on pull requests.
        Add validations in the pipeline to ensure:
            HCL syntax is valid.
            Terraform configurations adhere to best practices (e.g., terraform fmt).
    Automate GAR Creation:
        Automatically provision Google Artifact Registry during the Terraform process.

Pipeline

The GitHub Actions pipeline automates the application lifecycle from build to deployment. Key stages include:

    Container Build:
        Builds the application container.
        Pushes the container image to Google Artifact Registry (GAR).

    Deployment:
        Deploys the Kubernetes templates in the repository to the GKE cluster.

TODOs

    Security Enhancements:
        Add static analysis and security checks to the pipeline.
        Incorporate tools for container and infrastructure scanning (e.g., Trivy).

App Deployment

The Kubernetes configuration is designed with resilience and automation in mind, featuring two initialization jobs:

    Database Initialization:
        Configures database credentials dynamically for the application.
        Creates a database user and assigns appropriate privileges.

    Configuration File Initialization:
        Dynamically generates a wp-config.php file for WordPress using the credentials stored in Kubernetes Secrets.
        Mounts a persistent configuration volume to ensure the configuration persists across pod restarts and scaling.

TODOs

    Secrets Management:
        Install and configure External Secrets to manage secrets dynamically in Kubernetes.
    Application Deployment:
        Integrate ArgoCD for GitOps-based application deployment.
        Transition from static deployment YAMLs to Helm charts for better scalability and maintainability.

Security Considerations

To ensure a secure and compliant deployment, the following measures are recommended:

    Secrets Management:
        Implement External Secrets for secure and dynamic secrets retrieval.
    Certificates:
        Apply certificates to secure the load balancer endpoint.
    Container Hardening:
        Restrict the application container to avoid running as root.
        Add resource limits and security contexts to restrict container capabilities.
    Code Review:
        Prevent direct pushes to the main branch.
        Enforce pull request (PR) approvals after thorough review.
    Artifact Scanning:
        Enable and integrate Google Artifact Registry's scanning tool to ensure container images are free from vulnerabilities.
