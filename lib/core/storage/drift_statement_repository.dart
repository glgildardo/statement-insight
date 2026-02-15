import 'package:drift/drift.dart';

import '../models/parsed_statement.dart';
import '../models/transaction_category.dart';
import 'app_database.dart';
import 'statement_repository.dart';

class DriftStatementRepository implements StatementRepository {
  DriftStatementRepository(this._db);

  final AppDatabase _db;

  @override
  Future<void> saveParsedStatement(ParsedStatement statement) async {
    await _db.ensureReady();

    final statementId = _newId('stmt');
    await _db.transaction(() async {
      await _db.customStatement(
        '''
        INSERT INTO statements (
          id, bank_code, account_hint, period_start, period_end, imported_at
        ) VALUES (?, ?, ?, ?, ?, ?);
        ''',
        <Object>[
          statementId,
          statement.bankCode,
          statement.accountHint,
          statement.periodStart.toIso8601String(),
          statement.periodEnd.toIso8601String(),
          DateTime.now().toIso8601String(),
        ],
      );

      for (final tx in statement.transactions) {
        await _db.customStatement(
          '''
          INSERT INTO transactions (
            id, statement_id, date, description, amount, category, confidence
          ) VALUES (?, ?, ?, ?, ?, ?, ?);
          ''',
          <Object>[
            _newId('tx'),
            statementId,
            tx.date.toIso8601String(),
            tx.description,
            tx.amount,
            (tx.category ?? TransactionCategory.otros).name,
            tx.confidence ?? 0.3,
          ],
        );
      }
    });
  }

  String _newId(String prefix) {
    final now = DateTime.now().microsecondsSinceEpoch;
    return '$prefix-$now-${now.remainder(100000)}';
  }
}
