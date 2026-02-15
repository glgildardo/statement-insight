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

class TopExpense {
  const TopExpense({
    required this.description,
    required this.amount,
  });

  final String description;
  final double amount;
}

abstract class TransactionRepository {
  Future<TransactionAggregate> aggregateForPeriod({
    required DateTime from,
    required DateTime to,
  });

  Future<List<TopExpense>> topExpensesForPeriod({
    required DateTime from,
    required DateTime to,
    int limit = 5,
  });
}
