# Statement Insight

Mobile app that analyzes PDF bank statements from Guatemalan banks, categorizes transactions, and generates financial analytics.

## Features

- **PDF Analysis** — Upload statements from Ficohsa, BAC, BI, Nexa
- **Transaction Categorization** — Rules-based auto-categorization
- **Financial Dashboard** — Visual breakdown of spending/income
- **PDF Reports** — Export analytics as PDF (Pro feature)
- **Offline-first** — All processing happens locally
- **Privacy** — No accounts, no cloud, no data leaves your device

## Platforms

- iOS
- Android

## Architecture

Detailed specs in `/ai`:

| File | Purpose |
|------|---------|
| `00_project_overview.md` | App purpose, flow, non-goals |
| `01_architecture_rules.md` | Layered architecture |
| `02_state_management_riverpod.md` | Riverpod patterns |
| `03_navigation_go_router.md` | Routing structure |
| `04_database_drift.md` | Local database schema |
| `05_pdf_processing.md` | PDF extraction flow |
| `06_parsing_and_bank_adapters.md` | Bank parser interface |
| `07_categorization_engine.md` | Categorization logic |
| `08_ui_design_system.md` | UI components, theming |
| `09_pdf_report_generation.md` | PDF export feature |
| `10_monetization_iap.md` | One-time unlock model |
| `11_error_handling_and_logging.md` | Error patterns |
| `12_testing_strategy.md` | Test requirements |
| `13_code_style_and_conventions.md` | Code style guide |

## Tech Stack

- **Framework:** Flutter
- **State Management:** Riverpod
- **Navigation:** go_router
- **Database:** Drift (SQLite)
- **Charts:** fl_chart
- **PDF:** pdf + printing packages
- **Monetization:** in_app_purchase

## Getting Started

```bash
# Clone
git clone <repo-url>
cd statement-insight

# Install dependencies
flutter pub get

# Run
flutter run
```

## License

Private project — All rights reserved.