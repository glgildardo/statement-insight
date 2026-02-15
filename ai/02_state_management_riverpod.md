# State Management - Riverpod

## Mandatory Pattern

Use StateNotifier or AsyncNotifier for all async flows.

Controllers must:
- Expose immutable state
- Never mutate models directly
- Never access UI context

## Example Structure

ImportController
DashboardController
ProController

## Rules

- No Provider.of
- No setState in complex flows
- No global mutable state
- Controllers must be testable

State classes must be immutable.