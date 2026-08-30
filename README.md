# Conversor PDF para Word (OCR)

Converte PDFs escaneados em documentos Word (`.docx`) editáveis, usando OCR (reconhecimento óptico de caracteres) para extrair o texto. Funciona com documentos em português e inglês.

## Pré-requisitos

- **Python 3.10** ou superior
- **Tesseract OCR** instalado
  - No Windows, o script usa `C:\Program Files\Tesseract-OCR\tesseract.exe`
- Modelos de idioma `por` e `eng` (já inclusos na pasta `tessdata/`)

## Como instalar as dependências

```bash
pip install pypdfium2 pytesseract python-docx Pillow
```

## Como executar

Edite os caminhos `pdf_path` e `docx_path` em `convert_pdf_to_word.py` e execute:

```bash
python convert_pdf_to_word.py
```

O arquivo `.docx` é gerado no caminho definido em `docx_path`.
