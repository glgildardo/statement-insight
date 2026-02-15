import '../models/transaction_category.dart';

class TransactionAggregate {
  const TransactionAggregate({
    required this.totalSpent,
    required this.totalIncome,
    required this.netBalance,
    required this.byCategory,
  });

  final double totalSpent;
  final double totalIncome;
  final double netBalance;
  final Map<TransactionCategory, double> byCategory;
}

abstract class TransactionRepository {
  Future<TransactionAggregate> aggregateForPeriod({
    required DateTime from,
    required DateTime to,
  });
}
