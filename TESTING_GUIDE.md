# 🧪 Guía Completa de Pruebas del Proyecto GKE CI/CD

## ✅ Pruebas ya realizadas

### 1. Ejecución local con Python ✅
```powershell
cd app1
python app.py
# http://localhost:8080
```

### 2. Docker Compose ✅
```powershell
docker-compose up --build
# App1: http://localhost:8080
# App2: http://localhost:8081
```

---

## 🎯 Pruebas pendientes que puedes hacer

### 3. Kubernetes Local con Minikube

#### Instalación de Minikube
```powershell
# Instalar con Chocolatey
choco install minikube

# O descargar desde: https://minikube.sigs.k8s.io/docs/start/
```

#### Comandos para probar
```powershell
# 1. Iniciar Minikube
minikube start

# 2. Configurar Docker para usar el daemon de Minikube
minikube docker-env | Invoke-Expression

# 3. Construir imágenes dentro de Minikube
docker build -t quickstart-image:latest ./app1
docker build -t flask-image:latest ./app2

# 4. Desplegar en Kubernetes
kubectl apply -f kubernetes/app1-local.yaml
kubectl apply -f kubernetes/app2-local.yaml

# 5. Ver los pods
kubectl get pods

# 6. Ver los servicios
kubectl get services

# 7. Acceder a las aplicaciones
minikube service my-service --url
minikube service my-service2 --url

# 8. Ver el dashboard de Kubernetes
minikube dashboard

# 9. Ver logs de un pod
kubectl logs -l app=my-app

# 10. Escalar los pods
kubectl scale deployment my-deployment --replicas=5

# 11. Ver detalles del deployment
kubectl describe deployment my-deployment

# 12. Detener
minikube stop
```

---

### 4. Probar Escalabilidad y Load Balancing

#### Con Docker Compose
```powershell
# Escalar app1 a 3 instancias
docker-compose up --scale app1=3

# Ver todas las instancias
docker-compose ps
```

#### Con Kubernetes (Minikube)
```powershell
# Escalar deployment
kubectl scale deployment my-deployment --replicas=5

# Ver estado en tiempo real
kubectl get pods -w

# Ver cómo se distribuye la carga
kubectl describe service my-service
```

---

### 5. Probar Rolling Updates (Actualizaciones sin downtime)

#### Modificar app1/app.py
```python
# Cambiar el título
'app_name': 'App1 - Flask Demo v2.0',
```

#### Aplicar la actualización
```powershell
# Reconstruir imagen
docker build -t quickstart-image:v2 ./app1

# Actualizar en Kubernetes
kubectl set image deployment/my-deployment my-container=quickstart-image:v2

# Ver el rollout
kubectl rollout status deployment/my-deployment

# Ver historial
kubectl rollout history deployment/my-deployment

# Rollback si algo sale mal
kubectl rollout undo deployment/my-deployment
```

---

### 6. Probar Health Checks y Auto-restart

#### Simular fallo de la aplicación
```powershell
# Conectar a un contenedor
docker exec -it gke-demo-app1 bash

# O en Kubernetes
kubectl exec -it <pod-name> -- bash

# Dentro del contenedor, matar el proceso
pkill python

# Observar cómo Kubernetes lo reinicia automáticamente
kubectl get pods -w
```

---

### 7. Probar Networking entre contenedores

#### Crear un script de prueba
```powershell
# Desde app1, hacer request a app2
docker exec gke-demo-app1 curl http://gke-demo-app2:8081/health

# En Kubernetes
kubectl exec <app1-pod> -- curl http://flask-service:8081/health
```

---

### 8. Monitoreo y Logs

#### Ver logs en tiempo real
```powershell
# Docker Compose
docker-compose logs -f app1

# Kubernetes
kubectl logs -f deployment/my-deployment

# Logs de todos los pods de app1
kubectl logs -l app=my-app --all-containers=true
```

#### Ver métricas de recursos
```powershell
# Docker
docker stats

# Kubernetes
kubectl top nodes
kubectl top pods
```

---

### 9. Probar Variables de Entorno

#### Modificar docker-compose.yml
```yaml
services:
  app1:
    environment:
      - CLUSTER_NAME=Mi Cluster Custom
      - ENVIRONMENT=Staging
      - DEBUG=true
```

#### Reiniciar y verificar
```powershell
docker-compose up -d
curl http://localhost:8080/api/info
```

---

### 10. Simular CI/CD completo (sin GKE)

#### Usando GitHub Actions (gratis)

Crear `.github/workflows/ci-cd.yml`:

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main ]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Build App1
      run: docker build -t app1:latest ./app1
    
    - name: Build App2
      run: docker build -t app2:latest ./app2
    
    - name: Test App1
      run: |
        docker run -d -p 8080:8080 --name test-app1 app1:latest
        sleep 5
        curl http://localhost:8080/health
    
    - name: Test App2
      run: |
        docker run -d -p 8081:8081 --name test-app2 app2:latest
        sleep 5
        curl http://localhost:8081/health
```

---

### 11. Pruebas de Carga (Load Testing)

#### Instalar herramienta
```powershell
# Instalar Apache Bench
choco install apachebench

# O usar curl en loop
```

#### Ejecutar pruebas
```powershell
# 1000 requests, 10 concurrentes
ab -n 1000 -c 10 http://localhost:8080/

# O con PowerShell
1..100 | ForEach-Object -Parallel {
    Invoke-WebRequest http://localhost:8080/api/info
} -ThrottleLimit 10
```

---

### 12. Debugging y Troubleshooting

#### Entrar a un contenedor
```powershell
# Docker Compose
docker exec -it gke-demo-app1 bash

# Kubernetes
kubectl exec -it <pod-name> -- bash
```

#### Inspeccionar configuración
```powershell
# Docker
docker inspect gke-demo-app1

# Kubernetes
kubectl describe pod <pod-name>
```

#### Ver eventos
```powershell
kubectl get events --sort-by=.metadata.creationTimestamp
```

---

### 13. Backup y Restore

#### Exportar configuración de Kubernetes
```powershell
kubectl get all -o yaml > backup.yaml
```

#### Exportar imágenes Docker
```powershell
docker save gke-cicd-app1 > app1-backup.tar
docker save gke-cicd-app2 > app2-backup.tar

# Restaurar
docker load < app1-backup.tar
```

---

### 14. Seguridad - Escaneo de vulnerabilidades

```powershell
# Escanear imagen con Docker Scout
docker scout cves gke-cicd-app1

# O con Trivy
trivy image gke-cicd-app1
```

---

### 15. Performance Profiling

#### Agregar endpoint de profiling
```python
# En app.py
from werkzeug.middleware.profiler import ProfilerMiddleware

app.wsgi_app = ProfilerMiddleware(app.wsgi_app)
```

---

## 🎓 Ejercicios Prácticos

### Ejercicio 1: Modificar y redesplegar
1. Cambia el color del tema en `app1/templates/index.html`
2. Reconstruye: `docker-compose up --build`
3. Verifica el cambio

### Ejercicio 2: Agregar nueva funcionalidad
1. Agrega un endpoint `/api/stats` que retorne estadísticas
2. Prueba con curl
3. Actualiza el README

### Ejercicio 3: Simular fallo y recuperación
1. Detén manualmente un contenedor
2. Observa cómo se reinicia automáticamente
3. Verifica que no hubo pérdida de servicio

### Ejercicio 4: Multi-ambiente
1. Crea `docker-compose.prod.yml`
2. Configura variables diferentes
3. Ejecuta: `docker-compose -f docker-compose.prod.yml up`

---

## 📊 Checklist de pruebas completas

- [ ] Ejecución local con Python
- [ ] Docker Compose básico
- [ ] Escalado con Docker Compose
- [ ] Kubernetes con Minikube
- [ ] Rolling updates
- [ ] Health checks
- [ ] Load balancing
- [ ] Logs y monitoreo
- [ ] Variables de entorno
- [ ] Networking entre servicios
- [ ] Pruebas de carga
- [ ] Debugging
- [ ] Rollback
- [ ] Backup y restore
- [ ] Escaneo de seguridad

---

## 🚀 Próximos pasos (Avanzado)

1. **Implementar CI/CD con GitHub Actions**
2. **Agregar base de datos (PostgreSQL/MongoDB)**
3. **Implementar Redis para caché**
4. **Agregar Ingress Controller**
5. **Configurar TLS/SSL**
6. **Implementar Prometheus + Grafana**
7. **Agregar Helm Charts**
8. **Implementar Service Mesh (Istio)**

---

## 💡 Tips

- Siempre revisa logs cuando algo falle
- Usa `kubectl describe` para debugging en Kubernetes
- Guarda backups antes de cambios importantes
- Documenta cada cambio que hagas
- Usa tags de versión en las imágenes Docker
