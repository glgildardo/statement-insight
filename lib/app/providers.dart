import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/categorization/keyword_categorizer.dart';
import '../core/categorization/transaction_categorizer.dart';
import '../core/parsing/bank_parser_registry.dart';
import '../core/pdf/local_report_pdf_generator.dart';
import '../core/pdf/report_pdf_generator.dart';
import '../core/storage/app_database.dart';
import '../core/storage/drift_settings_repository.dart';
import '../core/storage/drift_statement_repository.dart';
import '../core/storage/drift_transaction_repository.dart';
import '../core/storage/settings_repository.dart';
import '../core/storage/statement_repository.dart';
import '../core/storage/transaction_repository.dart';
import '../features/purchases/in_app_purchase_gateway.dart';
import '../features/purchases/purchase_gateway.dart';

final bankParserRegistryProvider = Provider<BankParserRegistry>((ref) {
  return BankParserRegistry();
});

final transactionCategorizerProvider = Provider<TransactionCategorizer>((ref) {
  return KeywordCategorizer();
});

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase.local();
  ref.onDispose(() {
    database.close();
  });
  return database;
});

final statementRepositoryProvider = Provider<StatementRepository>((ref) {
  return DriftStatementRepository(ref.watch(appDatabaseProvider));
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return DriftTransactionRepository(ref.watch(appDatabaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return DriftSettingsRepository(ref.watch(appDatabaseProvider));
});

final reportPdfGeneratorProvider = Provider<ReportPdfGenerator>((ref) {
  return LocalReportPdfGenerator();
});

const proUnlockProductId = 'statement_insight_pro_unlock';

final purchaseGatewayProvider = Provider<PurchaseGateway>((ref) {
  return InAppPurchaseGateway(productId: proUnlockProductId);
});
