# Conversor PDF para Word (OCR)

Converte PDFs digitalizados (imagens) em documentos Word (`.docx`) editáveis, usando OCR (Tesseract) para extrair o texto em português e inglês.

## Pré-requisitos

- **Python 3.10** ou superior
- **Tesseract OCR** instalado. No Windows, o script espera o executável em:
  `C:\Program Files\Tesseract-OCR\tesseract.exe`

Baixe o Tesseract em: https://github.com/UB-Mannheim/tesseract/wiki

## Instalação das dependências

```powershell
pip install pypdfium2 pytesseract python-docx Pillow
```

## Como executar

Edite em `convert_pdf_to_word.py` os caminhos do PDF de entrada e do `.docx` de saída (função `main`). Em seguida:

```powershell
python convert_pdf_to_word.py
```

O arquivo Word é gerado no caminho definido no script.
