# Teste da API Cloud Agent

Script para criar um agente na nuvem que adiciona um `README.md` ao repositório.

## Pré-requisitos

1. **Conta Cursor** com acesso à API (beta)
2. **Chave de API** em [cursor.com/dashboard](https://cursor.com/dashboard) → API Keys
3. **Repositório no GitHub** com este código publicado na branch `main`
4. **Git** instalado (para enviar o código ao GitHub)

## Configuração rápida

### Opção fácil (recomendada)

1. Dê duplo clique no atalho **Cursor Cloud Agent** na área de trabalho
2. Na primeira execução, o assistente de configuração vai pedir:
   - Chave de API do Cursor
   - URL do repositório no GitHub
   - Instalação do Git (se necessário)
3. Depois disso, o agente é criado automaticamente

### Configuração manual

Baixe em [git-scm.com/download/win](https://git-scm.com/download/win) e reinicie o terminal.

### 2. Criar repositório no GitHub

No GitHub: **New repository** → nome `cursor-aprender` → crie sem README (já temos arquivos locais).

### 3. Enviar o código

No PowerShell, na pasta do projeto:

```powershell
cd C:\Projetos\Cursor-Aprender
git init -b main
git add .
git commit -m "Projeto inicial para teste Cloud Agent"
git remote add origin https://github.com/SEU-USUARIO/cursor-aprender.git
git push -u origin main
```

Substitua `SEU-USUARIO` pelo seu usuário do GitHub.

### 4. Configurar variáveis

```powershell
copy .env.example .env
notepad .env
```

Preencha:

```
CURSOR_API_KEY=sua_chave_aqui
GITHUB_REPO_URL=https://github.com/SEU-USUARIO/cursor-aprender
```

### 5. Executar

```powershell
python cloud-agent\criar_agente.py
```

## O que o script faz

1. Chama `POST /v1/agents` com um prompt para criar o README
2. Aponta para o seu repo no GitHub (`main`)
3. Pede `autoCreatePR: true` (abre PR ao terminar)
4. Consulta o status da execução até concluir
5. Mostra a URL do agente para acompanhar no navegador

## Documentação

- [Criar um agente](https://cursor.com/pt-BR/docs/cloud-agent/api/endpoints#criar-um-agente)
- [Visão geral da API](https://cursor.com/pt-BR/docs/cloud-agent/api)
