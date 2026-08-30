"""Cria um Cloud Agent via API do Cursor e acompanha a primeira execução."""

from __future__ import annotations

import json
import os
import sys
import time
import urllib.error
import urllib.request
from base64 import b64encode
from pathlib import Path

API_BASE = "https://api.cursor.com/v1"
POLL_INTERVAL_SEC = 5
MAX_WAIT_SEC = 600


def load_env() -> tuple[str, str]:
    env_path = Path(__file__).resolve().parent.parent / ".env"
    if env_path.exists():
        for line in env_path.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if not line or line.startswith("#") or "=" not in line:
                continue
            key, value = line.split("=", 1)
            os.environ.setdefault(key.strip(), value.strip())

    api_key = os.environ.get("CURSOR_API_KEY", "").strip()
    repo_url = os.environ.get("GITHUB_REPO_URL", "").strip()

    missing = []
    if not api_key:
        missing.append("CURSOR_API_KEY")
    if not repo_url:
        missing.append("GITHUB_REPO_URL")
    if missing:
        print("Variáveis ausentes no .env:", ", ".join(missing))
        print("Copie .env.example para .env e preencha os valores.")
        sys.exit(1)

    return api_key, repo_url


def api_request(
    api_key: str,
    method: str,
    path: str,
    body: dict | None = None,
) -> dict:
    url = f"{API_BASE}{path}"
    data = json.dumps(body).encode("utf-8") if body is not None else None
    auth = b64encode(f"{api_key}:".encode()).decode()

    request = urllib.request.Request(
        url,
        data=data,
        method=method,
        headers={
            "Authorization": f"Basic {auth}",
            "Content-Type": "application/json",
            "Accept": "application/json",
        },
    )

    try:
        with urllib.request.urlopen(request, timeout=60) as response:
            return json.loads(response.read().decode("utf-8"))
    except urllib.error.HTTPError as exc:
        detail = exc.read().decode("utf-8", errors="replace")
        print(f"Erro HTTP {exc.code} em {method} {path}")
        print(detail)
        sys.exit(1)


def wait_for_run(api_key: str, agent_id: str, run_id: str) -> dict:
    terminal = {"COMPLETED", "FAILED", "CANCELLED", "ERROR", "FINISHED"}
    elapsed = 0

    while elapsed < MAX_WAIT_SEC:
        run = api_request(api_key, "GET", f"/agents/{agent_id}/runs/{run_id}")
        status = run.get("status", "UNKNOWN")
        print(f"  status: {status}")

        if status in terminal:
            return run

        time.sleep(POLL_INTERVAL_SEC)
        elapsed += POLL_INTERVAL_SEC

    print("Tempo limite atingido. Acompanhe manualmente pela URL do agente.")
    return run


def main() -> None:
    api_key, repo_url = load_env()

    prompt = (
        "Adicione um README.md na raiz do repositório com:\n"
        "1. Descrição breve do projeto (conversor PDF para Word com OCR)\n"
        "2. Pré-requisitos (Python, Tesseract)\n"
        "3. Como instalar dependências\n"
        "4. Como executar convert_pdf_to_word.py\n"
        "Mantenha o texto em português e seja objetivo."
    )

    payload = {
        "prompt": {"text": prompt},
        "repos": [{"url": repo_url, "startingRef": "main"}],
        "autoCreatePR": True,
        "mode": "agent",
    }

    print("Criando Cloud Agent...")
    result = api_request(api_key, "POST", "/agents", payload)

    agent = result["agent"]
    run = result["run"]
    agent_id = agent["id"]
    run_id = run["id"]

    print()
    print("Agente criado com sucesso!")
    print(f"  ID:     {agent_id}")
    print(f"  Nome:   {agent.get('name', '(auto)')}")
    print(f"  URL:    {agent.get('url')}")
    print(f"  Run ID: {run_id}")
    print()
    print("Aguardando conclusão da primeira execução...")

    final_run = wait_for_run(api_key, agent_id, run_id)
    print()
    print("Execução finalizada:", final_run.get("status"))

    git_info = final_run.get("git") or agent.get("git")
    if git_info:
        print("Git:", json.dumps(git_info, indent=2, ensure_ascii=False))

    if final_run.get("result"):
        print()
        print("Resposta do agente:")
        text = str(final_run["result"])[:2000]
        sys.stdout.buffer.write((text + "\n").encode("utf-8", errors="replace"))


if __name__ == "__main__":
    main()
