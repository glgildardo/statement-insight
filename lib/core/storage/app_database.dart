import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppDatabase extends GeneratedDatabase {
  AppDatabase._(super.executor) {
    _ready = _migrate();
  }

  factory AppDatabase.local() {
    return AppDatabase._(
      LazyDatabase(() async {
        final directory = await getApplicationDocumentsDirectory();
        final file = File(p.join(directory.path, 'statement_insight.sqlite'));
        return NativeDatabase(file);
      }),
    );
  }

  factory AppDatabase.inMemory() {
    return AppDatabase._(NativeDatabase.memory());
  }

  late final Future<void> _ready;

  @override
  int get schemaVersion => 1;

  @override
  Iterable<TableInfo<Table, Object?>> get allTables => const [];

  Future<void> ensureReady() => _ready;

  Future<void> _migrate() async {
    await customStatement('PRAGMA foreign_keys = ON;');

    await customStatement('''
      CREATE TABLE IF NOT EXISTS statements (
        id TEXT PRIMARY KEY NOT NULL,
        bank_code TEXT NOT NULL,
        account_hint TEXT NOT NULL,
        period_start TEXT NOT NULL,
        period_end TEXT NOT NULL,
        imported_at TEXT NOT NULL
      );
    ''');

    await customStatement('''
      CREATE TABLE IF NOT EXISTS transactions (
        id TEXT PRIMARY KEY NOT NULL,
        statement_id TEXT NOT NULL,
        date TEXT NOT NULL,
        description TEXT NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        confidence REAL NOT NULL,
        FOREIGN KEY(statement_id) REFERENCES statements(id) ON DELETE CASCADE
      );
    ''');

    await customStatement('''
      CREATE TABLE IF NOT EXISTS settings (
        key TEXT PRIMARY KEY NOT NULL,
        value TEXT NOT NULL
      );
    ''');

    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_transactions_date ON transactions (date);',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_transactions_category ON transactions (category);',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_statements_bank_code ON statements (bank_code);',
    );
  }

  @override
  Future<void> close() => executor.close();
}
