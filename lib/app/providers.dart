import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/categorization/keyword_categorizer.dart';
import '../core/categorization/transaction_categorizer.dart';
import '../core/parsing/bank_parser_registry.dart';
import '../core/storage/app_database.dart';
import '../core/storage/drift_settings_repository.dart';
import '../core/storage/drift_statement_repository.dart';
import '../core/storage/drift_transaction_repository.dart';
import '../core/storage/settings_repository.dart';
import '../core/storage/statement_repository.dart';
import '../core/storage/transaction_repository.dart';

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
