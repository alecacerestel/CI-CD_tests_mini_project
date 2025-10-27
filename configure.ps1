# Project Configuration Script
# This script updates all files with your Google Cloud Project ID

# INSTRUCTIONS:
# 1. Replace YOUR_PROJECT_ID_HERE with your actual Project ID
# 2. Run this script: .\configure.ps1

param(
    [Parameter(Mandatory=$false)]
    [string]$ProjectId = "YOUR_PROJECT_ID_HERE"
)

Write-Host "Configuring GKE CI/CD project..." -ForegroundColor Cyan
Write-Host ""

if ($ProjectId -eq "YOUR_PROJECT_ID_HERE") {
    Write-Host "WARNING: You must specify your Project ID" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor White
    Write-Host "  .\configure.ps1 -ProjectId 'my-gcp-project'" -ForegroundColor Green
    Write-Host ""
    Write-Host "Or edit this file and replace 'YOUR_PROJECT_ID_HERE' with your Project ID" -ForegroundColor White
    Write-Host ""
    exit 1
}

Write-Host "Project ID: $ProjectId" -ForegroundColor Green
Write-Host ""

# Function to replace text in files
function Update-ProjectId {
    param(
        [string]$FilePath,
        [string]$OldValue,
        [string]$NewValue
    )
    
    if (Test-Path $FilePath) {
        Write-Host "  Updating: $FilePath" -ForegroundColor Gray
        (Get-Content $FilePath -Raw) -replace $OldValue, $NewValue | Set-Content $FilePath -NoNewline
    } else {
        Write-Host "  WARNING: Not found: $FilePath" -ForegroundColor Yellow
    }
}

Write-Host "Updating files..." -ForegroundColor Cyan

# Update cloudbuild.yaml
Update-ProjectId -FilePath ".\cloudbuild.yaml" `
    -OldValue "<your_project_id>" `
    -NewValue $ProjectId

Update-ProjectId -FilePath ".\cloudbuild.yaml" `
    -OldValue "prj-poc-001" `
    -NewValue $ProjectId

# Update kubernetes/app1.yaml
Update-ProjectId -FilePath ".\kubernetes\app1.yaml" `
    -OldValue "prj-poc-001" `
    -NewValue $ProjectId

# Update kubernetes/app2.yaml
Update-ProjectId -FilePath ".\kubernetes\app2.yaml" `
    -OldValue "prj-poc-001" `
    -NewValue $ProjectId

# Update deploy/dev.yaml
Update-ProjectId -FilePath ".\deploy\dev.yaml" `
    -OldValue "prj-poc-001" `
    -NewValue $ProjectId

# Update deploy/prod.yaml
Update-ProjectId -FilePath ".\deploy\prod.yaml" `
    -OldValue "prj-poc-001" `
    -NewValue $ProjectId

Write-Host ""
Write-Host "Configuration completed!" -ForegroundColor Green
Write-Host ""
Write-Host "Updated files:" -ForegroundColor Cyan
Write-Host "  - cloudbuild.yaml" -ForegroundColor White
Write-Host "  - kubernetes/app1.yaml" -ForegroundColor White
Write-Host "  - kubernetes/app2.yaml" -ForegroundColor White
Write-Host "  - deploy/dev.yaml" -ForegroundColor White
Write-Host "  - deploy/prod.yaml" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Verify the updated files" -ForegroundColor White
Write-Host "  2. Create GKE clusters in Google Cloud Console" -ForegroundColor White
Write-Host "  3. Create Artifact Registry" -ForegroundColor White
Write-Host "  4. Configure Cloud Build Trigger" -ForegroundColor White
Write-Host "  5. Push to GitHub to activate the pipeline" -ForegroundColor White
Write-Host ""
