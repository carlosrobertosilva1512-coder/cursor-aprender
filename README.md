# Conversor PDF para Word (OCR)

Converte PDFs escaneados em documentos Word (`.docx`) editáveis, usando OCR para extrair o texto. Suporta português e inglês.

## Pré-requisitos

- **Python 3.10** ou superior
- **Tesseract OCR** instalado no sistema
  - Windows: [instalador oficial](https://github.com/UB-Mannheim/tesseract/wiki) (o script usa `C:\Program Files\Tesseract-OCR\tesseract.exe`)
  - Linux: `sudo apt install tesseract-ocr tesseract-ocr-por tesseract-ocr-eng`
  - macOS: `brew install tesseract`

## Como instalar as dependências

```bash
pip install -r requirements.txt
```

## Como executar

Edite os caminhos `pdf_path` e `docx_path` em `convert_pdf_to_word.py` e execute:

```bash
python convert_pdf_to_word.py
```

O arquivo `.docx` é gerado no caminho definido em `docx_path`.
