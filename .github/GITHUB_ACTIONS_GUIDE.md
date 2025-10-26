# 🚀 GitHub Actions CI/CD Pipeline - Guía de Uso

## ✨ ¿Qué hace este pipeline?

Este pipeline de GitHub Actions ejecuta automáticamente cuando haces push al repositorio y realiza:

1. **Build y Test** - Compila y prueba las aplicaciones Python
2. **Docker Build** - Construye las imágenes Docker
3. **Container Tests** - Prueba los contenedores en ejecución
4. **Docker Compose Test** - Valida el deployment completo
5. **Security Scan** - Escanea vulnerabilidades con Trivy
6. **Report** - Genera reporte del estado

## 🎯 Ventajas

✅ **100% GRATIS** - GitHub Actions es gratis para repositorios públicos  
✅ **Automático** - Se ejecuta en cada push  
✅ **Completo** - Tests, builds, security scans  
✅ **Visible** - Ver resultados en GitHub  
✅ **Sin configuración adicional** - Solo hacer push  

## 📋 Requisitos

- Repositorio en GitHub (público o privado)
- Archivo `.github/workflows/ci-cd.yml` (✅ ya creado)

## 🚀 Cómo activarlo

### Paso 1: Crear repositorio en GitHub

```powershell
# Si aún no tienes repo remoto
git init
git add .
git commit -m "Initial commit with CI/CD pipeline"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/gke-cicd.git
git push -u origin main
```

### Paso 2: Ver el pipeline en acción

1. Ve a tu repositorio en GitHub
2. Click en la pestaña **"Actions"**
3. Verás el workflow ejecutándose automáticamente

### Paso 3: Ver resultados

- ✅ **Verde**: Todo funcionó correctamente
- ❌ **Rojo**: Hay errores (click para ver detalles)
- 🟡 **Amarillo**: En progreso

## 📊 Stages del Pipeline

### 1️⃣ Build and Test
- Instala dependencias de Python
- Valida que las apps se importan correctamente

### 2️⃣ Build Docker
- Construye imágenes Docker de App1 y App2
- Usa cache para builds más rápidos

### 3️⃣ Test Docker
- Ejecuta contenedores
- Prueba endpoints:
  - `/health` (health check)
  - `/api/info` (API info)
  - `/` (página principal)
- Muestra logs

### 4️⃣ Deploy Compose
- Ejecuta `docker-compose up`
- Valida que ambas apps funcionan juntas
- Prueba networking entre servicios

### 5️⃣ Security Scan
- Escanea imágenes con Trivy
- Busca vulnerabilidades CRITICAL y HIGH
- No bloquea el pipeline (informativo)

### 6️⃣ Report
- Resume el estado de todos los jobs
- Muestra mensaje de éxito o error

## 🔧 Personalización

### Cambiar rama que activa el pipeline

Edita `.github/workflows/ci-cd.yml`:

```yaml
on:
  push:
    branches: [ main, develop ]  # Agrega más ramas
```

### Agregar tests propios

Agrega un nuevo step en el job `build-and-test`:

```yaml
- name: Run my custom tests
  run: |
    cd app1
    pytest tests/
```

### Desactivar security scan

Comenta o elimina el job `security-scan` en el workflow.

### Agregar notificaciones

Agrega al final del workflow:

```yaml
- name: Send notification
  if: always()
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

## 📈 Badges

Agrega badges al README.md:

```markdown
![CI/CD Pipeline](https://github.com/TU_USUARIO/gke-cicd/actions/workflows/ci-cd.yml/badge.svg)
```

## 🐛 Troubleshooting

### Pipeline falla en "Build and Test"
- Verifica que `requirements.txt` esté completo
- Revisa sintaxis de Python

### Pipeline falla en "Test Docker"
- Las apps tardan en iniciar, aumenta `sleep`
- Verifica que los puertos estén correctos

### Pipeline falla en "Deploy Compose"
- Verifica `docker-compose.yml`
- Revisa conflictos de puertos

## 💡 Tips

- El pipeline tarda ~5-10 minutos
- Usa cache para acelerar builds
- Los logs completos están en GitHub Actions
- Puedes re-ejecutar jobs que fallan

## 🎓 Próximos pasos

1. **Agregar tests unitarios** con pytest
2. **Integrar SonarQube** para análisis de código
3. **Desplegar automáticamente** a Render/Railway
4. **Agregar badges** al README
5. **Configurar notificaciones** (Slack/Discord)

## 📚 Referencias

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Build Push Action](https://github.com/docker/build-push-action)
- [Trivy Security Scanner](https://github.com/aquasecurity/trivy-action)
