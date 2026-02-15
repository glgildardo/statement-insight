# Architecture Rules

## Architecture Pattern
Layered architecture with clear separation:

UI (Presentation)
↓
Controllers (State / Riverpod)
↓
Services (Parsing, Categorization, Reports)
↓
Data Layer (Drift)

## Rules

1. UI must NEVER contain business logic.
2. Parsing logic must be isolated per bank.
3. Categorization must be independent of parsing.
4. Database access must go through repositories.
5. No direct SQLite queries in UI or controllers.
6. No circular dependencies.

## Folder Structure Enforcement

lib/
  core/
  features/
  app/

Agent must never violate this structure.