# CI/CD Pipeline for GKE

![CI/CD Pipeline](https://github.com/alecacerestel/CI-CD_tests_mini_project/actions/workflows/ci-cd.yml/badge.svg)

## Project Description

This project implements a complete CI/CD pipeline to automatically deploy Flask applications on Google Kubernetes Engine (GKE).

## Objectives

- Deploy two Flask applications (app1 & app2) on GKE clusters
- Fully automate the deployment process through code push
- Implement dev to prod flow with manual approval
- Use DevOps best practices

## Technology Stack

- **GKE**: Managed Kubernetes service
- **Kubernetes**: Container orchestration  
- **Docker**: Application containerization
- **Cloud Build**: CI pipeline for building images
- **Cloud Deploy**: CD management
- **Skaffold**: Deployment workflow automation
- **GitHub Actions**: Automated testing and security
- **Python & Flask**: Application framework

## Project Structure

```
gke-cicd/
 app1/                   # Flask app 1 (port 8080)
 app2/                   # Flask app 2 (port 8081)
 kubernetes/             # K8s manifests
 deploy/                 # Cloud Deploy config
 .github/workflows/      # GitHub Actions
 cloudbuild.yaml         # Cloud Build pipeline
 docker-compose.yml      # Local deployment
 skaffold.yaml           # Skaffold config
```

## Quick Start

### Local Testing
```bash
docker compose up -d
```

### GKE Deployment
1. Update Project ID in config files
2. Create GKE clusters
3. Push to GitHub
4. Cloud Build triggers automatically

## Application Endpoints

Both apps include:
- `/` - Main dashboard
- `/health` - Health check
- `/api/info` - Deployment info

## Best Practices Implemented

- Environment separation (dev/prod)
- Manual production approval
- GitOps workflow
- Immutable infrastructure
- Automated testing
- Security scanning

## References

- [Cloud Build Docs](https://cloud.google.com/build/docs)
- [Cloud Deploy Docs](https://cloud.google.com/deploy/docs)
- [GKE Docs](https://cloud.google.com/kubernetes-engine/docs)
- [Skaffold Docs](https://skaffold.dev/docs/)

## License

Open source for educational purposes.
