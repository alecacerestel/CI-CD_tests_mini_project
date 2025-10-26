# ⚙️ Configuración Rápida del Proyecto

## 🎯 Para actualizar el Project ID de Google Cloud

### Opción 1: Script Automático (Recomendado)

```powershell
# Ejecutar el script de configuración
.\configure.ps1 -ProjectId "tu-project-id-aqui"
```

### Opción 2: Manual

Reemplaza manualmente en estos archivos:

1. **cloudbuild.yaml**
   - Busca: `<your_project_id>` o `prj-poc-001`
   - Reemplaza con: Tu Project ID

2. **kubernetes/app1.yaml**
   - Busca: `prj-poc-001`
   - Reemplaza con: Tu Project ID

3. **kubernetes/app2.yaml**
   - Busca: `prj-poc-001`
   - Reemplaza con: Tu Project ID

4. **deploy/dev.yaml**
   - Busca: `prj-poc-001`
   - Reemplaza con: Tu Project ID

5. **deploy/prod.yaml**
   - Busca: `prj-poc-001`
   - Reemplaza con: Tu Project ID

## 🚀 Configuración de GitHub Actions

### Ya está listo! Solo necesitas:

1. **Subir el código a GitHub**:
```powershell
git init
git add .
git commit -m "Add CI/CD pipeline"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/gke-cicd.git
git push -u origin main
```

2. **Ver el pipeline ejecutándose**:
   - Ve a tu repo en GitHub
   - Click en "Actions"
   - Mira el workflow en acción 🎉

## 📋 Checklist de Configuración

- [ ] Ejecutar `configure.ps1` con tu Project ID (si usas GCP)
- [ ] Verificar que los archivos se actualizaron
- [ ] Crear repositorio en GitHub
- [ ] Push del código
- [ ] Verificar que GitHub Actions funciona
- [ ] (Opcional) Crear clusters GKE
- [ ] (Opcional) Crear Artifact Registry
- [ ] (Opcional) Configurar Cloud Build Trigger

## 🆓 Configuraciones Gratuitas

### GitHub Actions ✅ Ya configurado
- Pipeline completo de CI/CD
- Tests automatizados
- Security scanning
- 100% gratis para repos públicos

### Docker Compose ✅ Ya funcionando
```powershell
docker-compose up -d
```

### Minikube (Kubernetes local)
```powershell
# Instalar
choco install minikube

# Usar
minikube start
kubectl apply -f kubernetes/app1-local.yaml
kubectl apply -f kubernetes/app2-local.yaml
```

## 💰 Configuraciones de Pago (GCP)

Solo si quieres usar Google Cloud:

1. **Crear proyecto en GCP**
2. **Habilitar APIs**:
   - Kubernetes Engine API
   - Cloud Build API
   - Cloud Deploy API
   - Artifact Registry API

3. **Crear recursos**:
```bash
# Clusters GKE
gcloud container clusters create cluster-1 --zone=us-central1-c --num-nodes=3
gcloud container clusters create cluster-2 --zone=us-central1-c --num-nodes=3

# Artifact Registry
gcloud artifacts repositories create gke-repo \
  --repository-format=docker \
  --location=us-central1
```

4. **Conectar GitHub a Cloud Build**
   - Cloud Console → Cloud Build → Triggers
   - Conectar repositorio
   - Crear trigger en `cloudbuild.yaml`

## 🎓 Orden Recomendado de Pruebas

1. ✅ **Local con Python** (ya probado)
2. ✅ **Docker Compose** (ya funcionando)
3. 🆕 **GitHub Actions** (push para activar)
4. 🆕 **Minikube** (Kubernetes local gratis)
5. 💰 **GKE** (Google Cloud - de pago)

## 📞 ¿Necesitas ayuda?

- GitHub Actions: Ver `.github/GITHUB_ACTIONS_GUIDE.md`
- Testing: Ver `TESTING_GUIDE.md`
- Deployment: Ver `LOCAL_DEPLOYMENT.md`
- General: Ver `README.md`
