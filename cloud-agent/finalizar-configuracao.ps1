# Finaliza configuracao: GitHub + .env + Cloud Agent
$ErrorActionPreference = "Stop"
$ProjectRoot = Split-Path $PSScriptRoot -Parent
$EnvFile = Join-Path $ProjectRoot ".env"
$git = "${env:ProgramFiles}\Git\bin\git.exe"
$gh = "${env:ProgramFiles}\GitHub CLI\gh.exe"

Set-Location $ProjectRoot

Write-Host "=== Finalizando configuracao Cloud Agent ===" -ForegroundColor White

# 1. GitHub
$auth = & $gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[!] Login no GitHub necessario. Abrindo navegador..." -ForegroundColor Yellow
    & $gh auth login --hostname github.com --git-protocol https --web
}

$user = & $gh api user --jq .login
Write-Host "[OK] GitHub: $user" -ForegroundColor Green

$remote = & $git remote get-url origin 2>$null
if (-not $remote) {
    $repoName = "cursor-aprender"
    Write-Host "[*] Criando repositorio github.com/$user/$repoName ..." -ForegroundColor Cyan
    & $gh repo create $repoName --public --source=. --remote=origin --push
    $remote = "https://github.com/$user/$repoName"
} else {
    Write-Host "[OK] Remote: $remote" -ForegroundColor Green
    & $git push -u origin main 2>$null
}

# 2. API Key
$apiKey = $env:CURSOR_API_KEY
if (-not $apiKey -and (Test-Path $EnvFile)) {
    foreach ($line in Get-Content $EnvFile) {
        if ($line -match "^CURSOR_API_KEY=(.+)$") { $apiKey = $Matches[1].Trim() }
    }
}

if (-not $apiKey) {
    Write-Host ""
    Write-Host "Abra: https://cursor.com/dashboard -> API Keys" -ForegroundColor Cyan
    Start-Process "https://cursor.com/dashboard"
    $apiKey = Read-Host "Cole sua CURSOR_API_KEY"
}

$repoUrl = if ($remote -match "github\.com[:/](.+?)(?:\.git)?$") {
    "https://github.com/$($Matches[1])"
} else { $remote }

@"
CURSOR_API_KEY=$apiKey
GITHUB_REPO_URL=$repoUrl
"@ | Set-Content -Path $EnvFile -Encoding UTF8

Write-Host "[OK] .env salvo." -ForegroundColor Green

# 3. Executar agente
Write-Host ""
Write-Host "[*] Criando Cloud Agent..." -ForegroundColor Cyan
python (Join-Path $PSScriptRoot "criar_agente.py")
