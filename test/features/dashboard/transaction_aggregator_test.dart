import 'package:flutter_test/flutter_test.dart';
import 'package:statement_insight/core/models/transaction_category.dart';
import 'package:statement_insight/core/storage/transaction_aggregator.dart';

void main() {
  group('TransactionAggregator', () {
    test('computes totals and net balance', () {
      final aggregator = TransactionAggregator();
      final aggregate = aggregator.aggregate(const <AggregateInput>[
        AggregateInput(amount: -100, category: TransactionCategory.comida),
        AggregateInput(amount: -50, category: TransactionCategory.transporte),
        AggregateInput(
          amount: 300,
          category: TransactionCategory.transferencias,
        ),
      ]);

      expect(aggregate.totalSpent, 150);
      expect(aggregate.totalIncome, 300);
      expect(aggregate.netBalance, 150);
      expect(aggregate.byCategory[TransactionCategory.comida], 100);
    });
  });
}
