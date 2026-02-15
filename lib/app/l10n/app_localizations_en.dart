// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Statement Insight';

  @override
  String get uploadTitle => 'Upload statement';

  @override
  String get analyzingTitle => 'Analyzing transactions';

  @override
  String get dashboardTitle => 'Financial summary';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get reportPreviewTitle => 'Report preview';

  @override
  String get continueAction => 'Continue';

  @override
  String get viewDashboard => 'View dashboard';

  @override
  String get totalSpent => 'Total spent';

  @override
  String get totalIncome => 'Total income';

  @override
  String get netBalance => 'Net balance';

  @override
  String get noData => 'No data';

  @override
  String get proEnabled => 'Pro enabled';

  @override
  String get proDisabled => 'Pro not enabled';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get restoringPurchases => 'Restoring purchases...';

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get generatingPdf => 'Generating PDF...';

  @override
  String get proRequired => 'This feature requires Pro unlock';

  @override
  String get parserError => 'Could not read the statement';

  @override
  String get genericError => 'Something went wrong, try again';

  @override
  String get importSuccess => 'Statement imported successfully';

  @override
  String get fileTooLarge => 'The file exceeds the 5MB limit';

  @override
  String get dashboardLoadError => 'Could not load financial summary';

  @override
  String get reportGenerateError => 'Could not generate the report';

  @override
  String get restorePurchaseError => 'Could not restore purchases';
}
