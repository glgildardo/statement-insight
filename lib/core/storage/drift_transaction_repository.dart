import 'package:drift/drift.dart';

import '../models/transaction_category.dart';
import 'app_database.dart';
import 'transaction_repository.dart';

class DriftTransactionRepository implements TransactionRepository {
  DriftTransactionRepository(this._db);

  final AppDatabase _db;

  @override
  Future<TransactionAggregate> aggregateForPeriod({
    required DateTime from,
    required DateTime to,
  }) async {
    await _db.ensureReady();

    final totals = await _db.customSelect(
      '''
      SELECT
        COALESCE(SUM(CASE WHEN amount < 0 THEN ABS(amount) ELSE 0 END), 0) AS spent,
        COALESCE(SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END), 0) AS income
      FROM transactions
      WHERE date BETWEEN ? AND ?;
      ''',
      variables: <Variable<Object>>[
        Variable<String>(from.toIso8601String()),
        Variable<String>(to.toIso8601String()),
      ],
    ).getSingle();

    final rows = await _db.customSelect(
      '''
      SELECT category, COALESCE(SUM(ABS(amount)), 0) AS total
      FROM transactions
      WHERE date BETWEEN ? AND ?
      GROUP BY category;
      ''',
      variables: <Variable<Object>>[
        Variable<String>(from.toIso8601String()),
        Variable<String>(to.toIso8601String()),
      ],
    ).get();

    final breakdown = <TransactionCategory, double>{};
    for (final row in rows) {
      final raw = row.read<String>('category');
      final category = TransactionCategory.values.firstWhere(
        (value) => value.name == raw,
        orElse: () => TransactionCategory.otros,
      );

      final total = row.read<double>('total');
      breakdown[category] = total;
    }

    final spent = totals.read<double>('spent');
    final income = totals.read<double>('income');
    return TransactionAggregate(
      totalSpent: spent,
      totalIncome: income,
      netBalance: income - spent,
      byCategory: breakdown,
    );
  }

  @override
  Future<List<TopExpense>> topExpensesForPeriod({
    required DateTime from,
    required DateTime to,
    int limit = 5,
  }) async {
    await _db.ensureReady();

    final rows = await _db.customSelect(
      '''
      SELECT description, ABS(amount) AS total
      FROM transactions
      WHERE date BETWEEN ? AND ? AND amount < 0
      ORDER BY ABS(amount) DESC
      LIMIT ?;
      ''',
      variables: <Variable<Object>>[
        Variable<String>(from.toIso8601String()),
        Variable<String>(to.toIso8601String()),
        Variable<int>(limit),
      ],
    ).get();

    return rows
        .map(
          (row) => TopExpense(
            description: row.read<String>('description'),
            amount: row.read<double>('total'),
          ),
        )
        .toList();
  }
}
