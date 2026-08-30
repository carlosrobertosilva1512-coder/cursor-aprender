@echo off
setlocal
cd /d "%~dp0.."

title Cursor Cloud Agent

if not exist .env (
  echo Primeira execucao: configurando...
  powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0configurar.ps1"
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
