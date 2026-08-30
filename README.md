# Cursor Aprender

Conversor de PDF escaneado para documento Word editável, usando OCR (reconhecimento óptico de caracteres).

## Descrição

Este projeto lê PDFs digitalizados (imagens) e gera um arquivo `.docx` com o texto extraído. Útil para digitalizar documentos em português e inglês.

## Pré-requisitos

- **Python 3.10+**
- **Tesseract OCR** instalado em `C:\Program Files\Tesseract-OCR\`
- Pacotes Python: `pypdfium2`, `pytesseract`, `python-docx`, `Pillow`

## Instalação

```powershell
pip install pypdfium2 pytesseract python-docx Pillow
```

Certifique-se de que o Tesseract está instalado. Os arquivos de idioma (`por`, `eng`) já estão na pasta `tessdata/` do projeto.

## Como usar

```powershell
python convert_pdf_to_word.py caminho\do\arquivo.pdf
```

O script gera um arquivo `.docx` no mesmo diretório do PDF.

## Estrutura do projeto

| Arquivo / pasta | Descrição |
|---|---|
| `convert_pdf_to_word.py` | Script principal de conversão |
| `tessdata/` | Modelos de idioma do Tesseract (PT + EN) |
| `cloud-agent/` | Scripts para testar a API de Cloud Agents do Cursor |

## Cloud Agent API

Para criar um agente na nuvem via API:

1. Gere uma chave em [cursor.com/dashboard](https://cursor.com/dashboard) → API Keys
2. Cole no arquivo `.env`
3. Execute o atalho **Cursor Cloud Agent** na área de trabalho

## Repositório

https://github.com/carlosrobertosilva1512-coder/cursor-aprender
