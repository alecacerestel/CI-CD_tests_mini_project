# CI/CD Pipeline for Deploying Applications on Google Kubernetes Engine (GKE)# CI/CD Pipeline for Deploying Applications on Google Kubernetes Engine (GKE)



![CI/CD Pipeline](https://github.com/alecacerestel/CI-CD_tests_mini_project/actions/workflows/ci-cd.yml/badge.svg)![CI/CD Pipeline](https://github.com/alecacerestel/CI-CD_tests_mini_project/actions/workflows/ci-cd.yml/badge.svg)



## Project Description## Project Description



This project implements a complete **CI/CD (Continuous Integration/Continuous Deployment)** pipeline to automatically deploy Flask applications on **Google Kubernetes Engine (GKE)**. The system automates the entire process from code push to production deployment, including a development environment for validation.This project implements a complete **CI/CD (Continuous Integration/Continuous Deployment)** pipeline to automatically deploy Flask applications on **Google Kubernetes Engine (GKE)**. The system automates the entire process from code push to production deployment, including a development environment for validation.



## Objectives## Objectives



- Deploy two simple Flask applications (app1 & app2) on GKE clusters- Deploy two simple Flask applications (app1 & app2) on GKE clusters

- Fully automate the deployment process through code push- Fully automate the deployment process through code push

- Implement a dev to prod flow with manual approval before production- Implement a dev to prod flow with manual approval before production

- Use DevOps best practices and cloud-native architecture- Use DevOps best practices and cloud-native architecture



## Project Architecture## Project Architecture



``````

Developer Push → GitHub → Cloud Build TriggerDeveloper Push → GitHub → Cloud Build Trigger

                              ↓                              ↓

                    Build Docker Images                    Build Docker Images

                              ↓                              ↓

                    Push to Artifact Registry                    Push to Artifact Registry

                              ↓                              ↓

                    Cloud Deploy Pipeline                    Cloud Deploy Pipeline

                              ↓                              ↓

                    ┌─────────┴─────────┐                    ┌─────────┴─────────┐

                    ↓                   ↓                    ↓                   ↓

              Dev Cluster         Prod Cluster              Dev Cluster         Prod Cluster

              (cluster-1)         (cluster-2)              (cluster-1)         (cluster-2)

              Auto Deploy         Manual Approval              Auto Deploy         Manual Approval

``````



## Technology Stack## Technology Stack



### Infrastructure and Orchestration### Infrastructure and Orchestration

- **Google Kubernetes Engine (GKE)**: Managed Kubernetes service for running containerized applications- **Google Kubernetes Engine (GKE)**: Managed Kubernetes service for running containerized applications

- **Kubernetes**: Container orchestration with Deployments, Services and LoadBalancers- **Kubernetes**: Container orchestration with Deployments, Services and LoadBalancers

- **Docker**: Application containerization- **Docker**: Application containerization



### CI/CD### CI/CD

- **Google Cloud Build**: Continuous integration pipeline for building and pushing images- **Google Cloud Build**: Continuous integration pipeline for building and pushing images

- **Google Cloud Deploy**: Continuous deployment management with multiple targets- **Google Cloud Deploy**: Continuous deployment management with multiple targets

- **Skaffold**: Tool to automate development and deployment workflow in Kubernetes- **Skaffold**: Tool to automate development and deployment workflow in Kubernetes

- **GitHub Actions**: Automated CI/CD pipeline with testing and security scanning

### Applications

### Applications- **Python 3.x**: Programming language

- **Python 3.x**: Programming language- **Flask**: Minimalist web framework for applications

- **Flask**: Minimalist web framework for applications- **Gunicorn**: WSGI server for production (optional)



### Version Control### Version Control

- **Git/GitHub**: Version control and pipeline triggers- **Git/GitHub**: Version control and pipeline triggers



### Google Cloud Services### Google Cloud Services

- **Artifact Registry**: Docker image storage- **Artifact Registry**: Docker image storage

- **Cloud Logging**: Centralized monitoring and logs- **Cloud Logging**: Centralized monitoring and logs



## Project Structure## Estructura del Proyecto



``````

gke-cicd/gke-cicd/

├── app1/                      # First Flask application├── app1/                      # Primera aplicación Flask

│   ├── app.py                 # Source code (port 8080)│   ├── app.py                 # Código fuente (puerto 8080)

│   ├── Dockerfile             # Docker image configuration│   ├── Dockerfile             # Configuración de imagen Docker

│   ├── requirements.txt       # Python dependencies│   ├── requirements.txt       # Dependencias Python

│   └── templates/│   └── templates/

│       └── index.html│       └── index.html

├── app2/                      # Second Flask application├── app2/                      # Segunda aplicación Flask

│   ├── app.py                 # Source code (port 8081)│   ├── app.py                 # Código fuente (puerto 8081)

│   ├── Dockerfile             # Docker image configuration│   ├── Dockerfile             # Configuración de imagen Docker

│   └── requirements.txt       # Python dependencies│   └── requirements.txt       # Dependencias Python

├── kubernetes/                # Kubernetes manifests├── kubernetes/                # Manifiestos de Kubernetes

│   ├── app1.yaml              # Deployment + Service for app1│   ├── app1.yaml              # Deployment + Service para app1

│   ├── app2.yaml              # Deployment + Service for app2│   └── app2.yaml              # Deployment + Service para app2

│   ├── app1-local.yaml        # Local deployment for app1├── deploy/                    # Configuración Cloud Deploy

│   └── app2-local.yaml        # Local deployment for app2│   ├── pipeline.yaml          # Pipeline dev → prod

├── deploy/                    # Cloud Deploy configuration│   ├── dev.yaml               # Target desarrollo (cluster-1)

│   ├── pipeline.yaml          # Dev to prod pipeline│   └── prod.yaml              # Target producción (cluster-2)

│   ├── dev.yaml               # Development target (cluster-1)├── cloudbuild.yaml            # Pipeline Cloud Build

│   └── prod.yaml              # Production target (cluster-2)├── skaffold.yaml              # Configuración Skaffold

├── .github/workflows/         # GitHub Actions workflows└── README.md                  # Este archivo

│   └── ci-cd.yml              # CI/CD pipeline definition```

├── cloudbuild.yaml            # Cloud Build pipeline

├── docker-compose.yml         # Local deployment configuration## Flujo de Trabajo (Workflow)

├── skaffold.yaml              # Skaffold configuration

└── README.md                  # This file### 1️ **Developer Push**

```El desarrollador hace commit y push al repositorio GitHub:

```bash

## Workflowgit add .

git commit -m "Update application"

### 1. Developer Pushgit push origin main

Developer commits and pushes to GitHub repository:```

```bash

git add .### 2️ **Cloud Build Trigger**

git commit -m "Update application"Automáticamente se activa el pipeline definido en `cloudbuild.yaml`:

git push origin main- **Build app1**: Construye imagen Docker de app1

```- **Push app1**: Sube imagen a `us-central1-docker.pkg.dev/<project>/gke-repo/quickstart-image`

- **Build app2**: Construye imagen Docker de app2

### 2. Automated CI/CD- **Push app2**: Sube imagen a `us-central1-docker.pkg.dev/<project>/gke-repo/flask-image`

GitHub Actions automatically triggers and executes:

- Build and test Python applications### 3️ **Cloud Deploy Pipeline**

- Build Docker imagesSe crea un release con el SHA del commit:

- Run container tests```bash

- Execute health checksgcloud deploy releases create 'app-release-${SHORT_SHA}' \

- Perform security scanning  --delivery-pipeline=gke-cicd-pipeline \

- Test Docker Compose deployment  --region=us-central1 \

  --skaffold-file=skaffold.yaml

### 3. Cloud Build Trigger (Optional - GCP)```

If configured, Cloud Build pipeline activates:

- **Build app1**: Creates Docker image for app1### 4️ **Despliegue en Desarrollo**

- **Push app1**: Uploads image to Artifact Registry- Se despliega automáticamente en `cluster-1` (dev)

- **Build app2**: Creates Docker image for app2- Kubernetes crea 3 réplicas de cada aplicación

- **Push app2**: Uploads image to Artifact Registry- Los Services tipo LoadBalancer exponen las apps públicamente



### 4. Cloud Deploy Pipeline (Optional - GCP)### 5️ **Revisión y Aprobación**

Creates a release with commit SHA:- El equipo revisa el despliegue en desarrollo

```bash- Se aprueba manualmente el pase a producción en Cloud Console

gcloud deploy releases create 'app-release-${SHORT_SHA}' \

  --delivery-pipeline=gke-cicd-pipeline \### 6️ **Despliegue en Producción**

  --region=us-central1 \- Se despliega en `cluster-2` (prod)

  --skaffold-file=skaffold.yaml- Mismo proceso que desarrollo pero con tráfico real

```

## Componentes Detallados

### 5. Development Deployment

- Automatically deploys to `cluster-1` (dev)### **Aplicaciones Flask**

- Kubernetes creates 3 replicas of each application

- LoadBalancer Services expose apps publicly**App1** (`app1/app.py`):

```python

### 6. Review and Approvalfrom flask import Flask

- Team reviews deployment in developmentapp = Flask(__name__)

- Manual approval required for production promotion

@app.route('/')

### 7. Production Deploymentdef hello_world():

- Deploys to `cluster-2` (prod)    return 'Hello, World App 1!'

- Same process as development with production traffic

if __name__ == '__main__':

## Application Components    app.run(debug=True, port=8080, host='0.0.0.0')

```

### Flask Applications

**App2** (`app2/app.py`):

**App1** (`app1/app.py`):```python

- Main dashboard with deployment informationfrom flask import Flask

- Health check endpoint: `/health`app = Flask(__name__)

- Info API endpoint: `/api/info`

- Runs on port 8080@app.route('/')

def hello_world():

**App2** (`app2/app.py`):    return 'Hello from App 2!'

- Main dashboard with deployment information

- Health check endpoint: `/health`if __name__ == '__main__':

- Info API endpoint: `/api/info`    app.run(debug=True, port=8081, host='0.0.0.0')

- Runs on port 8081```



### Kubernetes Manifests### **Kubernetes Manifests**



Each application includes:Cada aplicación tiene:

- **Deployment**: 3 replicas with container configuration- **Deployment**: 3 réplicas con configuración de contenedor

- **Service**: LoadBalancer for external access- **Service**: LoadBalancer para acceso externo

- **Labels and Selectors**: For proper routing- **Labels y Selectors**: Para enrutamiento correcto



### Cloud Deploy Pipeline### **Cloud Deploy Pipeline**



Defines a serial pipeline with two stages:Define un pipeline serial con dos etapas:

1. **dev**: Automatic deployment to cluster-11. **dev**: Despliegue automático en cluster-1

2. **prod**: Deployment with required approval to cluster-22. **prod**: Despliegue con aprobación requerida en cluster-2



### Skaffold Configuration### **Skaffold Configuration**



- Manages build and deploy declaratively- Gestiona el build y deploy de manera declarativa

- Uses GitCommit as tagging strategy- Usa GitCommit como estrategia de tagging

- Reads manifests from `kubernetes/` directory- Lee manifiestos del directorio `kubernetes/`



## Prerequisites## Requisitos Previos



To implement this project you need:Para implementar este proyecto necesitas:



1. **Google Cloud Platform account** with billing enabled (for GCP deployment)1. **Cuenta de Google Cloud Platform** con facturación habilitada

2. **Two GKE clusters** created:2. **Dos clusters GKE** creados:

   - `cluster-1` (development) in `us-central1-c`   - `cluster-1` (desarrollo) en `us-central1-c`

   - `cluster-2` (production) in `us-central1-c`   - `cluster-2` (producción) en `us-central1-c`

3. **Artifact Registry** repository configured3. **Artifact Registry** repositorio configurado

4. **Enabled APIs**:4. **APIs habilitadas**:

   - Kubernetes Engine API   - Kubernetes Engine API

   - Cloud Build API   - Cloud Build API

   - Cloud Deploy API   - Cloud Deploy API

   - Artifact Registry API   - Artifact Registry API

5. **GitHub repository** connected to Cloud Build5. **Repositorio GitHub** conectado a Cloud Build

6. **IAM permissions** configured for Cloud Build and Cloud Deploy6. **Permisos IAM** configurados para Cloud Build y Cloud Deploy



## Setup and Installation## Configuración e Instalación



### Step 1: Clone the Repository### Paso 1: Clonar el Repositorio

```bash```bash

git clone <your-repository>git clone <tu-repositorio>

cd gke-cicdcd gke-cicd

``````



### Step 2: Update Variables### Paso 2: Actualizar Variables

Replace `<your_project_id>` in:Reemplaza `<your_project_id>` en:

- `cloudbuild.yaml`- `cloudbuild.yaml`

- `kubernetes/app1.yaml`- `kubernetes/app1.yaml`

- `kubernetes/app2.yaml`- `kubernetes/app2.yaml`

- `deploy/dev.yaml`- `deploy/dev.yaml`

- `deploy/prod.yaml`- `deploy/prod.yaml`



Or use the configuration script:### Paso 3: Crear Clusters GKE

```powershell```bash

.\configure.ps1 -ProjectId "your-project-id"# Cluster de desarrollo

```gcloud container clusters create cluster-1 \

  --zone=us-central1-c \

### Step 3: Local Testing with Docker Compose  --num-nodes=3

```bash

# Start applications# Cluster de producción

docker compose up -dgcloud container clusters create cluster-2 \

  --zone=us-central1-c \

# View logs  --num-nodes=3

docker compose logs -f```



# Stop applications### Paso 4: Crear Artifact Registry

docker compose down```bash

```gcloud artifacts repositories create gke-repo \

  --repository-format=docker \

### Step 4: Create GKE Clusters (Optional)  --location=us-central1

```bash```

# Development cluster

gcloud container clusters create cluster-1 \### Paso 5: Configurar Cloud Build Trigger

  --zone=us-central1-c \```bash

  --num-nodes=3gcloud builds triggers create github \

  --repo-name=<tu-repo> \

# Production cluster  --repo-owner=<tu-usuario> \

gcloud container clusters create cluster-2 \  --branch-pattern="^main$" \

  --zone=us-central1-c \  --build-config=cloudbuild.yaml

  --num-nodes=3```

```

### Paso 6: Push y Despliegue

### Step 5: Create Artifact Registry (Optional)```bash

```bashgit add .

gcloud artifacts repositories create gke-repo \git commit -m "Initial deployment"

  --repository-format=docker \git push origin main

  --location=us-central1```

```

## Pruebas y Validación

### Step 6: Configure Cloud Build Trigger (Optional)

```bash### Verificar Builds

gcloud builds triggers create github \```bash

  --repo-name=<your-repo> \gcloud builds list --limit=5

  --repo-owner=<your-user> \```

  --branch-pattern="^main$" \

  --build-config=cloudbuild.yaml### Verificar Deploys

``````bash

gcloud deploy releases list \

### Step 7: Push and Deploy  --delivery-pipeline=gke-cicd-pipeline \

```bash  --region=us-central1

git add .```

git commit -m "Initial deployment"

git push origin main### Obtener IPs de los Services

``````bash

# Conectar a dev

## Testing and Validationgcloud container clusters get-credentials cluster-1 --zone=us-central1-c



### Verify Builds# Ver services

```bashkubectl get services

gcloud builds list --limit=5

```# Acceder a las apps

curl http://<EXTERNAL-IP>:8080

### Verify Deployments```

```bash

gcloud deploy releases list \### Aprobar Despliegue en Producción

  --delivery-pipeline=gke-cicd-pipeline \```bash

  --region=us-central1gcloud deploy releases promote \

```  --release=app-release-<SHA> \

  --delivery-pipeline=gke-cicd-pipeline \

### Get Service IPs  --region=us-central1

```bash```

# Connect to dev cluster

gcloud container clusters get-credentials cluster-1 --zone=us-central1-c## Monitoreo y Logs



# View services### Ver Logs de Cloud Build

kubectl get services```bash

gcloud builds log <BUILD_ID>

# Access applications```

curl http://<EXTERNAL-IP>:8080

curl http://<EXTERNAL-IP>:8081### Ver Logs de Pods

``````bash

kubectl logs -l app=my-app

### Approve Production Deployment```

```bash

gcloud deploy releases promote \### Cloud Console

  --release=app-release-<SHA> \- **Cloud Build**: https://console.cloud.google.com/cloud-build

  --delivery-pipeline=gke-cicd-pipeline \- **Cloud Deploy**: https://console.cloud.google.com/deploy

  --region=us-central1- **GKE Workloads**: https://console.cloud.google.com/kubernetes/workload

```

## Mejores Prácticas Implementadas

## Monitoring and Logs**Separación de Ambientes**: Dev y Prod en clusters independientes  

**Aprobación Manual**: Producción requiere aprobación explícita  

### View Cloud Build Logs**GitOps**: Todo el despliegue basado en código versionado  

```bash**Immutable Infrastructure**: Contenedores y deployments declarativos  

gcloud builds log <BUILD_ID>**Tagging Automático**: Versionado basado en Git commits  

```**Alta Disponibilidad**: 3 réplicas por aplicación  

**Logs Centralizados**: Cloud Logging para troubleshooting  

### View Pod Logs

```bash## Referencias

kubectl logs -l app=my-app

```- [Google Cloud Build Documentation](https://cloud.google.com/build/docs)

- [Google Cloud Deploy Documentation](https://cloud.google.com/deploy/docs)

### Cloud Console- [GKE Documentation](https://cloud.google.com/kubernetes-engine/docs)

- **Cloud Build**: https://console.cloud.google.com/cloud-build- [Skaffold Documentation](https://skaffold.dev/docs/)

- **Cloud Deploy**: https://console.cloud.google.com/deploy- [Flask Documentation](https://flask.palletsprojects.com/)

- **GKE Workloads**: https://console.cloud.google.com/kubernetes/workload



## Implemented Best Practices

- Environment Separation: Dev and Prod in independent clusters
- Manual Approval: Production requires explicit approval
- GitOps: All deployment based on versioned code
- Immutable Infrastructure: Containers and declarative deployments
- Automatic Tagging: Versioning based on Git commits
- High Availability: 3 replicas per application
- Centralized Logs: Cloud Logging for troubleshooting
- Automated Testing: CI/CD with GitHub Actions
- Security Scanning: Vulnerability detection with Trivy

## Possible Improvements

- Implement Health Checks (liveness/readiness probes)
- Add automated tests in pipeline
- Implement Horizontal Pod Autoscaling (HPA)
- Add Ingress Controller for advanced routing
- Implement secrets management with Secret Manager
- Add monitoring with Cloud Monitoring/Prometheus
- Implement automatic rollback on failures
- Add staging environment
- Implement canary deployments

## Important Notes

**Costs**: GKE clusters and other services generate costs. Delete resources when not in use.

**Security**: This is an educational project. For production implement:
- Network policies
- More restrictive RBAC
- Pod Security Policies
- Service mesh (Istio/Anthos)

**Scalability**: For real loads, consider:
- Regional clusters for HA
- Node auto-scaling
- Workload Identity
- Binary Authorization

## References

- [Google Cloud Build Documentation](https://cloud.google.com/build/docs)
- [Google Cloud Deploy Documentation](https://cloud.google.com/deploy/docs)
- [GKE Documentation](https://cloud.google.com/kubernetes-engine/docs)
- [Skaffold Documentation](https://skaffold.dev/docs/)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## Contributions

Contributions are welcome. Please:
1. Fork the project
2. Create a branch for your feature (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is open source and available for educational purposes.
