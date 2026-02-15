# PDF Processing

## Rules

- All PDF extraction must happen locally.
- Never upload PDF to external services.
- Text extraction must be abstracted behind PdfTextExtractor interface.

## Flow

PDF file
→ Extract raw text
→ Detect bank
→ Send to BankParser

## Constraints

- Max 5MB per file
- Multiple files supported
- If extraction fails, return structured error