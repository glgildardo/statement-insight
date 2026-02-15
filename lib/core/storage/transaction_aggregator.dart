import '../models/transaction_category.dart';
import 'transaction_repository.dart';

class AggregateInput {
  const AggregateInput({required this.amount, required this.category});

  final double amount;
  final TransactionCategory category;
}

class TransactionAggregator {
  TransactionAggregate aggregate(List<AggregateInput> values) {
    var totalSpent = 0.0;
    var totalIncome = 0.0;
    final byCategory = <TransactionCategory, double>{};

    for (final item in values) {
      if (item.amount < 0) {
        totalSpent += item.amount.abs();
      } else {
        totalIncome += item.amount;
      }

      final current = byCategory[item.category] ?? 0.0;
      byCategory[item.category] = current + item.amount.abs();
    }

    return TransactionAggregate(
      totalSpent: totalSpent,
      totalIncome: totalIncome,
      netBalance: totalIncome - totalSpent,
      byCategory: byCategory,
    );
  }
}
