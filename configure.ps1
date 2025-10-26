# 🔧 Script de Configuración del Proyecto
# Este script actualiza todos los archivos con tu Project ID de Google Cloud

# INSTRUCCIONES:
# 1. Reemplaza YOUR_PROJECT_ID_HERE con tu Project ID real
# 2. Ejecuta este script: .\configure.ps1

param(
    [Parameter(Mandatory=$false)]
    [string]$ProjectId = "YOUR_PROJECT_ID_HERE"
)

Write-Host "🔧 Configurando el proyecto GKE CI/CD..." -ForegroundColor Cyan
Write-Host ""

if ($ProjectId -eq "YOUR_PROJECT_ID_HERE") {
    Write-Host "⚠️  ADVERTENCIA: Debes especificar tu Project ID" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Uso:" -ForegroundColor White
    Write-Host "  .\configure.ps1 -ProjectId 'mi-proyecto-gcp'" -ForegroundColor Green
    Write-Host ""
    Write-Host "O edita este archivo y reemplaza 'YOUR_PROJECT_ID_HERE' con tu Project ID" -ForegroundColor White
    Write-Host ""
    exit 1
}

Write-Host "📋 Project ID: $ProjectId" -ForegroundColor Green
Write-Host ""

# Función para reemplazar texto en archivos
function Update-ProjectId {
    param(
        [string]$FilePath,
        [string]$OldValue,
        [string]$NewValue
    )
    
    if (Test-Path $FilePath) {
        Write-Host "  Actualizando: $FilePath" -ForegroundColor Gray
        (Get-Content $FilePath -Raw) -replace $OldValue, $NewValue | Set-Content $FilePath -NoNewline
    } else {
        Write-Host "  ⚠️  No encontrado: $FilePath" -ForegroundColor Yellow
    }
}

Write-Host "🔄 Actualizando archivos..." -ForegroundColor Cyan

# Actualizar cloudbuild.yaml
Update-ProjectId -FilePath ".\cloudbuild.yaml" `
    -OldValue "<your_project_id>" `
    -NewValue $ProjectId

Update-ProjectId -FilePath ".\cloudbuild.yaml" `
    -OldValue "prj-poc-001" `
    -NewValue $ProjectId

# Actualizar kubernetes/app1.yaml
Update-ProjectId -FilePath ".\kubernetes\app1.yaml" `
    -OldValue "prj-poc-001" `
    -NewValue $ProjectId

# Actualizar kubernetes/app2.yaml
Update-ProjectId -FilePath ".\kubernetes\app2.yaml" `
    -OldValue "prj-poc-001" `
    -NewValue $ProjectId

# Actualizar deploy/dev.yaml
Update-ProjectId -FilePath ".\deploy\dev.yaml" `
    -OldValue "prj-poc-001" `
    -NewValue $ProjectId

# Actualizar deploy/prod.yaml
Update-ProjectId -FilePath ".\deploy\prod.yaml" `
    -OldValue "prj-poc-001" `
    -NewValue $ProjectId

Write-Host ""
Write-Host "✅ Configuración completada!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Archivos actualizados:" -ForegroundColor Cyan
Write-Host "  - cloudbuild.yaml" -ForegroundColor White
Write-Host "  - kubernetes/app1.yaml" -ForegroundColor White
Write-Host "  - kubernetes/app2.yaml" -ForegroundColor White
Write-Host "  - deploy/dev.yaml" -ForegroundColor White
Write-Host "  - deploy/prod.yaml" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Próximos pasos:" -ForegroundColor Cyan
Write-Host "  1. Verifica los archivos actualizados" -ForegroundColor White
Write-Host "  2. Crea los clusters GKE en Google Cloud Console" -ForegroundColor White
Write-Host "  3. Crea el Artifact Registry" -ForegroundColor White
Write-Host "  4. Configura el Cloud Build Trigger" -ForegroundColor White
Write-Host "  5. Push a GitHub para activar el pipeline" -ForegroundColor White
Write-Host ""
