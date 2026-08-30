# Cursor Aprender

Conversor de PDF escaneado para documento Word (`.docx`) com OCR. O script lê PDFs digitalizados (imagens), extrai o texto com Tesseract e gera um arquivo editável.

## Pré-requisitos

- **Python 3.10** ou superior
- **Tesseract OCR** instalado no sistema
  - No Windows, o script usa o executável em `C:\Program Files\Tesseract-OCR\tesseract.exe`
  - Os modelos de idioma `por` e `eng` já estão na pasta `tessdata/`

## Instalação das dependências

```bash
pip install pypdfium2 pytesseract python-docx Pillow
```

## Como executar

1. Em `convert_pdf_to_word.py`, ajuste em `main()` o caminho do PDF de entrada e do `.docx` de saída.
2. Execute:

```bash
python convert_pdf_to_word.py
```

O arquivo Word é gerado no caminho definido no script.
