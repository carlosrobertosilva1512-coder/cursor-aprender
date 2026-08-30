@echo off
setlocal
cd /d "%~dp0.."
set "PATH=%ProgramFiles%\Git\bin;%ProgramFiles%\GitHub CLI;%PATH%"

title Cursor Cloud Agent

if not exist .env (
  echo Primeira execucao: finalizando configuracao...
  powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0finalizar-configuracao.ps1"
  if errorlevel 1 exit /b 1
)

python "%~dp0criar_agente.py"
if errorlevel 1 (
  echo.
  echo Erro ao executar. Rode a configuracao manualmente:
  echo   powershell -File cloud-agent\configurar.ps1
)
echo.
pause
