import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Statement Insight'**
  String get appTitle;

  /// No description provided for @uploadTitle.
  ///
  /// In es, this message translates to:
  /// **'Subir estado de cuenta'**
  String get uploadTitle;

  /// No description provided for @analyzingTitle.
  ///
  /// In es, this message translates to:
  /// **'Analizando movimientos'**
  String get analyzingTitle;

  /// No description provided for @dashboardTitle.
  ///
  /// In es, this message translates to:
  /// **'Resumen financiero'**
  String get dashboardTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Configuracion'**
  String get settingsTitle;

  /// No description provided for @reportPreviewTitle.
  ///
  /// In es, this message translates to:
  /// **'Vista previa del reporte'**
  String get reportPreviewTitle;

  /// No description provided for @continueAction.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get continueAction;

  /// No description provided for @viewDashboard.
  ///
  /// In es, this message translates to:
  /// **'Ver Dashboard'**
  String get viewDashboard;

  /// No description provided for @totalSpent.
  ///
  /// In es, this message translates to:
  /// **'Gasto total'**
  String get totalSpent;

  /// No description provided for @totalIncome.
  ///
  /// In es, this message translates to:
  /// **'Ingreso total'**
  String get totalIncome;

  /// No description provided for @netBalance.
  ///
  /// In es, this message translates to:
  /// **'Balance neto'**
  String get netBalance;

  /// No description provided for @noData.
  ///
  /// In es, this message translates to:
  /// **'Sin datos'**
  String get noData;

  /// No description provided for @proEnabled.
  ///
  /// In es, this message translates to:
  /// **'Pro activado'**
  String get proEnabled;

  /// No description provided for @proDisabled.
  ///
  /// In es, this message translates to:
  /// **'Pro no activado'**
  String get proDisabled;

  /// No description provided for @restorePurchases.
  ///
  /// In es, this message translates to:
  /// **'Restaurar compras'**
  String get restorePurchases;

  /// No description provided for @restoringPurchases.
  ///
  /// In es, this message translates to:
  /// **'Restaurando compras...'**
  String get restoringPurchases;

  /// No description provided for @exportPdf.
  ///
  /// In es, this message translates to:
  /// **'Exportar PDF'**
  String get exportPdf;

  /// No description provided for @generatingPdf.
  ///
  /// In es, this message translates to:
  /// **'Generando PDF...'**
  String get generatingPdf;

  /// No description provided for @proRequired.
  ///
  /// In es, this message translates to:
  /// **'Esta funcion requiere desbloqueo Pro'**
  String get proRequired;

  /// No description provided for @parserError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo leer el estado de cuenta'**
  String get parserError;

  /// No description provided for @genericError.
  ///
  /// In es, this message translates to:
  /// **'Ocurrio un error, intenta de nuevo'**
  String get genericError;

  /// No description provided for @importSuccess.
  ///
  /// In es, this message translates to:
  /// **'Estado de cuenta importado correctamente'**
  String get importSuccess;

  /// No description provided for @fileTooLarge.
  ///
  /// In es, this message translates to:
  /// **'El archivo supera el limite de 5MB'**
  String get fileTooLarge;

  /// No description provided for @dashboardLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar el resumen financiero'**
  String get dashboardLoadError;

  /// No description provided for @reportGenerateError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo generar el reporte'**
  String get reportGenerateError;

  /// No description provided for @restorePurchaseError.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron restaurar las compras'**
  String get restorePurchaseError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
