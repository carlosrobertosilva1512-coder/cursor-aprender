# Conversor PDF para Word (OCR)

Converte PDFs digitalizados (imagens) em documentos Word (`.docx`) editáveis, usando OCR (Tesseract) em português e inglês.

## Pré-requisitos

- **Python 3.10+**
- **Tesseract OCR** instalado. No Windows, o script usa o executável em `C:\Program Files\Tesseract-OCR\tesseract.exe`
- Idiomas `por` e `eng` do Tesseract (o script lê a pasta `tessdata/` na raiz do projeto)

## Como instalar as dependências

```bash
pip install pypdfium2 pytesseract python-docx Pillow
```

## Como executar

Os caminhos do PDF de entrada e do Word de saída estão definidos na função `main()` de `convert_pdf_to_word.py`. Ajuste-os se necessário e execute:

```bash
python convert_pdf_to_word.py
```

O arquivo `.docx` é gerado no caminho indicado no script.
