# Multi-Cloud DevOps Platform (AWS-first)

## Goal
Build a production-grade DevOps platform that supports:
- Secure cloud infrastructure (IaC)
- GitOps-based delivery
- Observability & SRE practices
- Financial data pipelines
- AI / agent-based workloads

This repository is built incrementally and documents real-world
DevOps, Data Engineering, and AI Data Engineering practices.

## High-level Architecture
- Cloud infrastructure provisioned using Terraform
- Kubernetes (EKS first) as the runtime
- GitOps delivery using Argo CD
- Secure CI/CD with image scanning and signing
- Observability with OpenTelemetry, Prometheus, Grafana

## Repository Structure
- `infra/` – Infrastructure as Code (Terraform)
- `platform/` – Kubernetes add-ons, GitOps, policies, observability
- `apps/` – Sample workloads deployed via GitOps
- `docs/` – Architecture diagrams, runbooks, design decisions

## Status
🚧 Project under active development.
