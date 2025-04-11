# 🚀 Kubernetes on AWS (EKS) with CI/CD - TechBleat Project

This project is a hands-on implementation of a Kubernetes-based application deployment pipeline using **Terraform**, **Jenkins**, and **AWS EKS**. It follows a structured approach to create infrastructure, deploy services, and manage deployments using GitOps best practices.

---

## 📌 Project Objectives

1. **Provision a 3-node Kubernetes Cluster on AWS (EKS)** using T2.micro instances.
2. **Deploy the following services**:
   - ✅ 2 NGINX instances (Deployment) with a **LoadBalancer Service**
   - ✅ 1 Prometheus instance (Deployment) with a **LoadBalancer Service**
   - ✅ Prometheus Node Exporter (DaemonSet) with a **ClusterIP Service**
3. **Setup complete AWS networking** infrastructure using Terraform:
   - VPC, Subnets, IGW, Route Tables, etc.
4. **Build a CI/CD pipeline using Jenkins** to:
   - Automate Terraform infra provisioning
   - Configure kubectl on EC2
   - Deploy Kubernetes resources via manifest files

---

## 🧱 Infrastructure Diagram

The architecture includes:
- **VPC (192.168.0.0/16)** with public & private subnets across 2 AZs (eu-west-2a & eu-west-2b)
- **NGINX services in public subnets** behind an Application Load Balancer
- **Monitoring stack (Prometheus + Node Exporter)** in private subnets
- EC2 instances used as Jenkins agents and to manage deployments

## 🛠️ Jenkins Pipeline Overview

The `Jenkinsfile` is split into stages:

1. **Terraform Init/Plan/Apply**
2. **Configure kubectl access on remote EC2**
3. **Install kubectl CLI if not present**
4. **Apply Kubernetes manifests for all services**

Environment variables and credentials (e.g., `AWS_ACCESS_KEY_ID`, `KUBECONFIG`, `SSH_PRIVATE_KEY`) are securely injected via Jenkins credentials store.

---

## 🚀 Deployment Steps

### ✅ Prerequisites

- AWS Account with access credentials
- Jenkins Server with required plugins
- Terraform CLI
- EC2 instance with SSH access for kubectl config

### 🔨 Steps

1. **Clone the repository**
2. **Configure Jenkins credentials** (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `SSH_PRIVATE_KEY`, `KUBECONFIG-FILE`)
3. **Trigger Jenkins pipeline**
4. **Verify deployment via `kubectl get all`**

---

## 📦 Kubernetes Resources Deployed

| Component           | Type         | Service Type     |
|---------------------|--------------|------------------|
| NGINX               | Deployment   | LoadBalancer     |
| Prometheus          | Deployment   | LoadBalancer     |
| Node Exporter       | DaemonSet    | ClusterIP        |

