# Conversor PDF para Word

Converte PDFs digitalizados (escaneados) em documentos Word (`.docx`) editáveis, usando OCR (Tesseract) para extrair o texto. Suporta português e inglês.

## Pré-requisitos

- **Python 3.10+**
- **Tesseract OCR** instalado (o script espera o executável em `C:\Program Files\Tesseract-OCR\tesseract.exe`)

Os arquivos de idioma (`por` e `eng`) devem estar na pasta `tessdata/` na raiz do projeto.

## Como instalar as dependências

```powershell
pip install pypdfium2 pytesseract python-docx Pillow
```

## Como executar

Edite em `convert_pdf_to_word.py` os caminhos do PDF de entrada e do `.docx` de saída (função `main`). Depois execute:

```powershell
python convert_pdf_to_word.py
```

O script gera o arquivo Word no caminho definido.
