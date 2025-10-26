# CI/CD Pipeline for Deploying Applications on Google Kubernetes Engine (GKE)

![CI/CD Pipeline](https://github.com/alecacerestel/CI-CD_tests_mini_project/actions/workflows/ci-cd.yml/badge.svg)

## Descripción del Proyecto

Este proyecto implementa un pipeline completo de **CI/CD (Integración Continua/Despliegue Continuo)** para desplegar automáticamente aplicaciones Flask en **Google Kubernetes Engine (GKE)**. El sistema automatiza todo el proceso desde el push de código hasta el despliegue en producción, pasando por un ambiente de desarrollo para validación.

## Objetivos

- Desplegar dos aplicaciones Flask simples (app1 & app2) en clusters de GKE
- Automatizar completamente el proceso de despliegue mediante código push
- Implementar un flujo dev → prod con aprobación manual antes de producción
- Usar las mejores prácticas de DevOps y arquitectura cloud-native

## Arquitectura del Proyecto

```
Developer Push → GitHub → Cloud Build Trigger
                              ↓
                    Build Docker Images
                              ↓
                    Push to Artifact Registry
                              ↓
                    Cloud Deploy Pipeline
                              ↓
                    ┌─────────┴─────────┐
                    ↓                   ↓
              Dev Cluster         Prod Cluster
              (cluster-1)         (cluster-2)
              Auto Deploy         Manual Approval
```

## Stack Tecnológico

### **Infraestructura y Orquestación**
- **Google Kubernetes Engine (GKE)**: Servicio administrado de Kubernetes para ejecutar aplicaciones containerizadas
- **Kubernetes**: Orquestación de contenedores con Deployments, Services y LoadBalancers
- **Docker**: Containerización de aplicaciones

### **CI/CD**
- **Google Cloud Build**: Pipeline de integración continua para construir y pushear imágenes
- **Google Cloud Deploy**: Gestión de despliegues continuos con múltiples targets
- **Skaffold**: Herramienta para automatizar el flujo de desarrollo y despliegue en Kubernetes

### **Aplicaciones**
- **Python 3.x**: Lenguaje de programación
- **Flask**: Framework web minimalista para las aplicaciones
- **Gunicorn**: Servidor WSGI para producción (opcional)

### **Control de Versiones**
- **Git/GitHub**: Control de versiones y trigger de pipelines

### **Google Cloud Services**
- **Artifact Registry**: Almacenamiento de imágenes Docker
- **Cloud Logging**: Monitoreo y logs centralizados

## Estructura del Proyecto

```
gke-cicd/
├── app1/                      # Primera aplicación Flask
│   ├── app.py                 # Código fuente (puerto 8080)
│   ├── Dockerfile             # Configuración de imagen Docker
│   ├── requirements.txt       # Dependencias Python
│   └── templates/
│       └── index.html
├── app2/                      # Segunda aplicación Flask
│   ├── app.py                 # Código fuente (puerto 8081)
│   ├── Dockerfile             # Configuración de imagen Docker
│   └── requirements.txt       # Dependencias Python
├── kubernetes/                # Manifiestos de Kubernetes
│   ├── app1.yaml              # Deployment + Service para app1
│   └── app2.yaml              # Deployment + Service para app2
├── deploy/                    # Configuración Cloud Deploy
│   ├── pipeline.yaml          # Pipeline dev → prod
│   ├── dev.yaml               # Target desarrollo (cluster-1)
│   └── prod.yaml              # Target producción (cluster-2)
├── cloudbuild.yaml            # Pipeline Cloud Build
├── skaffold.yaml              # Configuración Skaffold
└── README.md                  # Este archivo
```

## Flujo de Trabajo (Workflow)

### 1️ **Developer Push**
El desarrollador hace commit y push al repositorio GitHub:
```bash
git add .
git commit -m "Update application"
git push origin main
```

### 2️ **Cloud Build Trigger**
Automáticamente se activa el pipeline definido en `cloudbuild.yaml`:
- **Build app1**: Construye imagen Docker de app1
- **Push app1**: Sube imagen a `us-central1-docker.pkg.dev/<project>/gke-repo/quickstart-image`
- **Build app2**: Construye imagen Docker de app2
- **Push app2**: Sube imagen a `us-central1-docker.pkg.dev/<project>/gke-repo/flask-image`

### 3️ **Cloud Deploy Pipeline**
Se crea un release con el SHA del commit:
```bash
gcloud deploy releases create 'app-release-${SHORT_SHA}' \
  --delivery-pipeline=gke-cicd-pipeline \
  --region=us-central1 \
  --skaffold-file=skaffold.yaml
```

### 4️ **Despliegue en Desarrollo**
- Se despliega automáticamente en `cluster-1` (dev)
- Kubernetes crea 3 réplicas de cada aplicación
- Los Services tipo LoadBalancer exponen las apps públicamente

### 5️ **Revisión y Aprobación**
- El equipo revisa el despliegue en desarrollo
- Se aprueba manualmente el pase a producción en Cloud Console

### 6️ **Despliegue en Producción**
- Se despliega en `cluster-2` (prod)
- Mismo proceso que desarrollo pero con tráfico real

## Componentes Detallados

### **Aplicaciones Flask**

**App1** (`app1/app.py`):
```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World App 1!'

if __name__ == '__main__':
    app.run(debug=True, port=8080, host='0.0.0.0')
```

**App2** (`app2/app.py`):
```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello from App 2!'

if __name__ == '__main__':
    app.run(debug=True, port=8081, host='0.0.0.0')
```

### **Kubernetes Manifests**

Cada aplicación tiene:
- **Deployment**: 3 réplicas con configuración de contenedor
- **Service**: LoadBalancer para acceso externo
- **Labels y Selectors**: Para enrutamiento correcto

### **Cloud Deploy Pipeline**

Define un pipeline serial con dos etapas:
1. **dev**: Despliegue automático en cluster-1
2. **prod**: Despliegue con aprobación requerida en cluster-2

### **Skaffold Configuration**

- Gestiona el build y deploy de manera declarativa
- Usa GitCommit como estrategia de tagging
- Lee manifiestos del directorio `kubernetes/`

## Requisitos Previos

Para implementar este proyecto necesitas:

1. **Cuenta de Google Cloud Platform** con facturación habilitada
2. **Dos clusters GKE** creados:
   - `cluster-1` (desarrollo) en `us-central1-c`
   - `cluster-2` (producción) en `us-central1-c`
3. **Artifact Registry** repositorio configurado
4. **APIs habilitadas**:
   - Kubernetes Engine API
   - Cloud Build API
   - Cloud Deploy API
   - Artifact Registry API
5. **Repositorio GitHub** conectado a Cloud Build
6. **Permisos IAM** configurados para Cloud Build y Cloud Deploy

## Configuración e Instalación

### Paso 1: Clonar el Repositorio
```bash
git clone <tu-repositorio>
cd gke-cicd
```

### Paso 2: Actualizar Variables
Reemplaza `<your_project_id>` en:
- `cloudbuild.yaml`
- `kubernetes/app1.yaml`
- `kubernetes/app2.yaml`
- `deploy/dev.yaml`
- `deploy/prod.yaml`

### Paso 3: Crear Clusters GKE
```bash
# Cluster de desarrollo
gcloud container clusters create cluster-1 \
  --zone=us-central1-c \
  --num-nodes=3

# Cluster de producción
gcloud container clusters create cluster-2 \
  --zone=us-central1-c \
  --num-nodes=3
```

### Paso 4: Crear Artifact Registry
```bash
gcloud artifacts repositories create gke-repo \
  --repository-format=docker \
  --location=us-central1
```

### Paso 5: Configurar Cloud Build Trigger
```bash
gcloud builds triggers create github \
  --repo-name=<tu-repo> \
  --repo-owner=<tu-usuario> \
  --branch-pattern="^main$" \
  --build-config=cloudbuild.yaml
```

### Paso 6: Push y Despliegue
```bash
git add .
git commit -m "Initial deployment"
git push origin main
```

## Pruebas y Validación

### Verificar Builds
```bash
gcloud builds list --limit=5
```

### Verificar Deploys
```bash
gcloud deploy releases list \
  --delivery-pipeline=gke-cicd-pipeline \
  --region=us-central1
```

### Obtener IPs de los Services
```bash
# Conectar a dev
gcloud container clusters get-credentials cluster-1 --zone=us-central1-c

# Ver services
kubectl get services

# Acceder a las apps
curl http://<EXTERNAL-IP>:8080
```

### Aprobar Despliegue en Producción
```bash
gcloud deploy releases promote \
  --release=app-release-<SHA> \
  --delivery-pipeline=gke-cicd-pipeline \
  --region=us-central1
```

## Monitoreo y Logs

### Ver Logs de Cloud Build
```bash
gcloud builds log <BUILD_ID>
```

### Ver Logs de Pods
```bash
kubectl logs -l app=my-app
```

### Cloud Console
- **Cloud Build**: https://console.cloud.google.com/cloud-build
- **Cloud Deploy**: https://console.cloud.google.com/deploy
- **GKE Workloads**: https://console.cloud.google.com/kubernetes/workload

## Mejores Prácticas Implementadas
**Separación de Ambientes**: Dev y Prod en clusters independientes  
**Aprobación Manual**: Producción requiere aprobación explícita  
**GitOps**: Todo el despliegue basado en código versionado  
**Immutable Infrastructure**: Contenedores y deployments declarativos  
**Tagging Automático**: Versionado basado en Git commits  
**Alta Disponibilidad**: 3 réplicas por aplicación  
**Logs Centralizados**: Cloud Logging para troubleshooting  

## Referencias

- [Google Cloud Build Documentation](https://cloud.google.com/build/docs)
- [Google Cloud Deploy Documentation](https://cloud.google.com/deploy/docs)
- [GKE Documentation](https://cloud.google.com/kubernetes-engine/docs)
- [Skaffold Documentation](https://skaffold.dev/docs/)
- [Flask Documentation](https://flask.palletsprojects.com/)


