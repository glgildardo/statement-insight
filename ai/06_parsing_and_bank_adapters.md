# Bank Parsing Architecture

## Pattern

Each bank must implement:

abstract class BankParser

## Requirements

- canParse(text)
- parse(text)
- return normalized ParsedStatement

## Parsing Rules

- Parsing must be deterministic.
- No UI logic inside parser.
- No categorization inside parser.
- Amount parsing must normalize commas and currency symbols.
- All dates must be DateTime objects.

## Extensibility

Adding a new bank must not modify existing parsers.