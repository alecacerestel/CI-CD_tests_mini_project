# Quick Project Setup Guide

## Updating Google Cloud Project ID

### Option 1: Automatic Script (Recommended)

```powershell
# Run the configuration script
.\configure.ps1 -ProjectId "your-project-id-here"
```

### Option 2: Manual

Manually replace in these files:

1. **cloudbuild.yaml**
   - Find: `<your_project_id>` or `prj-poc-001`
   - Replace with: Your Project ID

2. **kubernetes/app1.yaml**
   - Find: `prj-poc-001`
   - Replace with: Your Project ID

3. **kubernetes/app2.yaml**
   - Find: `prj-poc-001`
   - Replace with: Your Project ID

4. **deploy/dev.yaml**
   - Find: `prj-poc-001`
   - Replace with: Your Project ID

5. **deploy/prod.yaml**
   - Find: `prj-poc-001`
   - Replace with: Your Project ID

## GitHub Actions Setup

### Already configured! You just need to:

1. **Upload code to GitHub**:
```powershell
git init
git add .
git commit -m "Add CI/CD pipeline"
git branch -M main
git remote add origin https://github.com/YOUR_USER/gke-cicd.git
git push -u origin main
```

2. **View the pipeline running**:
   - Go to your repo on GitHub
   - Click on "Actions"
   - Watch the workflow in action

## Configuration Checklist

- [ ] Run `configure.ps1` with your Project ID (if using GCP)
- [ ] Verify files were updated
- [ ] Create repository on GitHub
- [ ] Push code
- [ ] Verify GitHub Actions works
- [ ] (Optional) Create GKE clusters
- [ ] (Optional) Create Artifact Registry
- [ ] (Optional) Configure Cloud Build Trigger

## Free Configurations

### GitHub Actions - Already configured
- Complete CI/CD pipeline
- Automated testing
- Security scanning
- 100% free for public repos

### Docker Compose - Already working
```powershell
docker compose up -d
```

### Minikube (Local Kubernetes)
```powershell
# Install
choco install minikube

# Use
minikube start
kubectl apply -f kubernetes/app1-local.yaml
kubectl apply -f kubernetes/app2-local.yaml
```

## Paid Configurations (GCP)

Only if you want to use Google Cloud:

1. **Create project in GCP**
2. **Enable APIs**:
   - Kubernetes Engine API
   - Cloud Build API
   - Cloud Deploy API
   - Artifact Registry API

3. **Create resources**:
```bash
# GKE Clusters
gcloud container clusters create cluster-1 --zone=us-central1-c --num-nodes=3
gcloud container clusters create cluster-2 --zone=us-central1-c --num-nodes=3

# Artifact Registry
gcloud artifacts repositories create gke-repo \
  --repository-format=docker \
  --location=us-central1
```

4. **Connect GitHub to Cloud Build**
   - Cloud Console → Cloud Build → Triggers
   - Connect repository
   - Create trigger on `cloudbuild.yaml`

## Recommended Testing Order

1. Local with Python (already tested)
2. Docker Compose (already working)
3. GitHub Actions (push to activate)
4. Minikube (Free local Kubernetes)
5. GKE (Google Cloud - paid)

## Need Help?

- GitHub Actions: See README.md
- Testing: See documentation in the repository
- Deployment: Follow the guides
- General: Check README.md
