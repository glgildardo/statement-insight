import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'message_key.dart';

extension MessageKeyLocalization on AppLocalizations {
  String message(MessageKey key) {
    switch (key) {
      case MessageKey.proRequired:
        return proRequired;
      case MessageKey.reportGenerateError:
        return reportGenerateError;
      case MessageKey.restorePurchaseError:
        return restorePurchaseError;
      case MessageKey.parserError:
        return parserError;
      case MessageKey.fileTooLarge:
        return fileTooLarge;
      case MessageKey.importSuccess:
        return importSuccess;
      case MessageKey.dashboardLoadError:
        return dashboardLoadError;
    }
  }
}
