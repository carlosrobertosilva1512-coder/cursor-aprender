# Configuração inicial do teste Cloud Agent API
$ErrorActionPreference = "Stop"
$ProjectRoot = Split-Path $PSScriptRoot -Parent
$EnvFile = Join-Path $ProjectRoot ".env"
$EnvExample = Join-Path $ProjectRoot ".env.example"

function Find-Git {
    $git = Get-Command git -ErrorAction SilentlyContinue
    if ($git) { return $git.Source }
    $candidates = @(
        "${env:ProgramFiles}\Git\bin\git.exe",
        "${env:ProgramFiles(x86)}\Git\bin\git.exe",
        "${env:LocalAppData}\Programs\Git\bin\git.exe"
    )
    foreach ($path in $candidates) {
        if (Test-Path $path) { return $path }
    }
    return $null
}

function Ensure-Git {
    $gitPath = Find-Git
    if ($gitPath) {
        Write-Host "[OK] Git encontrado: $gitPath" -ForegroundColor Green
        return $gitPath
    }

    Write-Host "[!] Git nao encontrado." -ForegroundColor Yellow
    $install = Read-Host "Deseja instalar o Git agora com winget? (S/n)"
    if ($install -eq "" -or $install -match "^[Ss]") {
        winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                    [System.Environment]::GetEnvironmentVariable("Path", "User")
        $gitPath = Find-Git
        if ($gitPath) {
            Write-Host "[OK] Git instalado." -ForegroundColor Green
            return $gitPath
        }
    }

    Write-Host "Instale manualmente: https://git-scm.com/download/win" -ForegroundColor Yellow
    return $null
}

function Ensure-EnvFile {
    if (-not (Test-Path $EnvFile)) {
        Copy-Item $EnvExample $EnvFile
        Write-Host "[*] Arquivo .env criado." -ForegroundColor Cyan
    }

    $lines = Get-Content $EnvFile
    $values = @{}
    foreach ($line in $lines) {
        if ($line -match "^\s*([A-Z_]+)\s*=\s*(.*)$") {
            $values[$Matches[1]] = $Matches[2].Trim()
        }
    }

    if (-not $values["CURSOR_API_KEY"]) {
        Write-Host ""
        Write-Host "Chave de API: https://cursor.com/dashboard -> API Keys" -ForegroundColor Cyan
        $key = Read-Host "Cole sua CURSOR_API_KEY"
        if ($key) { $values["CURSOR_API_KEY"] = $key.Trim() }
    }

    if (-not $values["GITHUB_REPO_URL"]) {
        Write-Host ""
        $url = Read-Host "URL do repo GitHub (ex: https://github.com/usuario/cursor-aprender)"
        if ($url) { $values["GITHUB_REPO_URL"] = $url.Trim() }
    }

    $content = @(
        "# Gerado por cloud-agent/configurar.ps1",
        "CURSOR_API_KEY=$($values['CURSOR_API_KEY'])",
        "GITHUB_REPO_URL=$($values['GITHUB_REPO_URL'])"
    )
    Set-Content -Path $EnvFile -Value $content -Encoding UTF8
    Write-Host "[OK] .env configurado." -ForegroundColor Green
}

function Ensure-GitRepo {
    param([string]$GitPath)

    Push-Location $ProjectRoot
    try {
        if (-not (Test-Path (Join-Path $ProjectRoot ".git"))) {
            & $GitPath init -b main
            Write-Host "[OK] Repositorio git inicializado." -ForegroundColor Green
        }

        $status = & $GitPath status --porcelain 2>$null
        if ($status) {
            & $GitPath add -A
            & $GitPath commit -m "Configuracao Cloud Agent API"
            Write-Host "[OK] Commit criado." -ForegroundColor Green
        }

        $remote = & $GitPath remote get-url origin 2>$null
        if (-not $remote) {
            Write-Host ""
            Write-Host "Crie um repo vazio no GitHub e cole a URL abaixo." -ForegroundColor Cyan
            $remoteUrl = Read-Host "URL do remote origin (Enter para pular)"
            if ($remoteUrl) {
                & $GitPath remote add origin $remoteUrl.Trim()
                Write-Host "[*] Enviando para GitHub..." -ForegroundColor Cyan
                & $GitPath push -u origin main
                Write-Host "[OK] Codigo enviado ao GitHub." -ForegroundColor Green
            }
        } else {
            Write-Host "[OK] Remote origin: $remote" -ForegroundColor Green
        }
    } finally {
        Pop-Location
    }
}

Write-Host "=== Configuracao Cloud Agent ===" -ForegroundColor White
Write-Host "Projeto: $ProjectRoot`n"

$git = Ensure-Git
Ensure-EnvFile
if ($git) { Ensure-GitRepo -GitPath $git }

Write-Host ""
Write-Host "Configuracao concluida. Use o atalho na area de trabalho para criar o agente." -ForegroundColor Green
