# Local Database - Drift

## Rules

- Drift is the only database layer.
- No raw SQLite calls.
- All database access must go through repositories.
- Migrations must be versioned.

## Tables

Statements
Transactions
Settings (Pro flag)

## Data Integrity

- No nullable critical fields
- Use enums stored as text
- Transactions must reference a Statement

## Performance

- Use indexes for:
  - date
  - category
  - bank