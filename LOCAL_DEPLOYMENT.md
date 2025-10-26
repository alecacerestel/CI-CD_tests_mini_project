# 🆓 Despliegue Local Gratuito - Alternativas a GKE

## Opción 1: Minikube (Kubernetes Local) ⭐ RECOMENDADO

### Instalación de Minikube en Windows
```powershell
# Instalar con Chocolatey
choco install minikube

# O descargar directamente
# https://minikube.sigs.k8s.io/docs/start/
```

### Comandos para usar el proyecto
```powershell
# 1. Iniciar Minikube
minikube start

# 2. Configurar Docker para usar el registry de Minikube
minikube docker-env | Invoke-Expression

# 3. Construir las imágenes localmente
cd app1
docker build -t quickstart-image:latest .

cd ../app2
docker build -t flask-image:latest .

# 4. Actualizar los manifiestos de Kubernetes (ver abajo)

# 5. Aplicar los manifiestos
kubectl apply -f kubernetes/app1-local.yaml
kubectl apply -f kubernetes/app2-local.yaml

# 6. Ver los servicios
kubectl get services

# 7. Acceder a las aplicaciones
minikube service my-service --url
minikube service my-service2 --url

# 8. Dashboard de Kubernetes
minikube dashboard
```

---

## Opción 2: Docker Compose (Más Simple) ⭐⭐ MÁS FÁCIL

### Sin Kubernetes, solo Docker
```yaml
# docker-compose.yml (ver archivo creado)
version: '3.8'
services:
  app1:
    build: ./app1
    ports:
      - "8080:8080"
    environment:
      - CLUSTER_NAME=Local Docker
      - ENVIRONMENT=Development
  
  app2:
    build: ./app2
    ports:
      - "8081:8081"
    environment:
      - CLUSTER_NAME=Local Docker
      - ENVIRONMENT=Development
```

### Comandos
```powershell
# Construir y ejecutar
docker-compose up --build

# Detener
docker-compose down

# Ver en:
# http://localhost:8080
# http://localhost:8081
```

---

## Opción 3: GitHub Actions + GitHub Pages (CI/CD Gratuito)

### Pipeline gratuito con GitHub
```yaml
# .github/workflows/deploy.yml
name: CI/CD Pipeline
on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build App1
        run: |
          cd app1
          docker build -t app1:latest .
      - name: Build App2
        run: |
          cd app2
          docker build -t app2:latest .
```

---

## Opción 4: Render.com (Despliegue Gratuito en la Nube)

### Pros
- ✅ Completamente gratuito (con límites)
- ✅ Despliegue automático desde GitHub
- ✅ SSL gratis
- ✅ No necesitas tarjeta de crédito

### Pasos
1. Ir a https://render.com
2. Conectar tu repositorio GitHub
3. Crear 2 "Web Services"
4. Configurar:
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `python app.py`

---

## Opción 5: Railway.app (Alternativa a Render)

### Similar a Render pero con $5 gratis al mes
- https://railway.app
- Conectar GitHub
- Despliegue automático

---

## Opción 6: Kind (Kubernetes in Docker)

### Similar a Minikube pero más ligero
```powershell
# Instalar Kind
choco install kind

# Crear cluster
kind create cluster --name gke-demo

# Cargar imágenes
kind load docker-image quickstart-image:latest --name gke-demo
kind load docker-image flask-image:latest --name gke-demo

# Aplicar manifiestos
kubectl apply -f kubernetes/
```

---

## 🎯 Mi Recomendación

Para **aprender CI/CD localmente**:
1. **Docker Compose** (lo más simple)
2. **Minikube** (experiencia completa de Kubernetes)

Para **despliegue gratuito en la nube**:
1. **Render.com** (más fácil, no requiere tarjeta)
2. **Railway.app** (más flexible)

Para **CI/CD completo gratuito**:
1. **GitHub Actions** (pipeline automático)
2. **GitLab CI/CD** (incluye runners gratuitos)

---

## Comparación Rápida

| Opción | Gratis | Kubernetes | CI/CD | Dificultad | Nube |
|--------|--------|-----------|-------|-----------|------|
| Minikube | ✅ | ✅ | ❌ | Media | ❌ |
| Docker Compose | ✅ | ❌ | ❌ | Fácil | ❌ |
| Render.com | ✅ | ❌ | ✅ | Fácil | ✅ |
| Railway.app | ⚠️ $5/mes | ❌ | ✅ | Fácil | ✅ |
| GitHub Actions | ✅ | ❌ | ✅ | Media | ✅ |
| Kind | ✅ | ✅ | ❌ | Media | ❌ |

---

## ¿Cuál prefieres probar primero?
