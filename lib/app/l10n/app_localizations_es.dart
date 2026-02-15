// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Statement Insight';

  @override
  String get uploadTitle => 'Subir estado de cuenta';

  @override
  String get analyzingTitle => 'Analizando movimientos';

  @override
  String get dashboardTitle => 'Resumen financiero';

  @override
  String get settingsTitle => 'Configuracion';

  @override
  String get reportPreviewTitle => 'Vista previa del reporte';

  @override
  String get continueAction => 'Continuar';

  @override
  String get viewDashboard => 'Ver Dashboard';

  @override
  String get totalSpent => 'Gasto total';

  @override
  String get totalIncome => 'Ingreso total';

  @override
  String get netBalance => 'Balance neto';

  @override
  String get noData => 'Sin datos';

  @override
  String get proEnabled => 'Pro activado';

  @override
  String get proDisabled => 'Pro no activado';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get restoringPurchases => 'Restaurando compras...';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get generatingPdf => 'Generando PDF...';

  @override
  String get proRequired => 'Esta funcion requiere desbloqueo Pro';

  @override
  String get parserError => 'No se pudo leer el estado de cuenta';

  @override
  String get genericError => 'Ocurrio un error, intenta de nuevo';

  @override
  String get importSuccess => 'Estado de cuenta importado correctamente';

  @override
  String get fileTooLarge => 'El archivo supera el limite de 5MB';

  @override
  String get dashboardLoadError => 'No se pudo cargar el resumen financiero';

  @override
  String get reportGenerateError => 'No se pudo generar el reporte';

  @override
  String get restorePurchaseError => 'No se pudieron restaurar las compras';
}
