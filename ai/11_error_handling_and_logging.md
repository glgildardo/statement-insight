# Error Handling

## Principles

- No silent failures.
- All async operations must return structured error.
- Parsing errors must be informative.

## Logging

Use debug logging in development.
No verbose logging in release mode.

## User Messaging

Errors must be:
- Clear
- Non-technical
- In Spanish