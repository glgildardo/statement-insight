import 'transaction_category.dart';

class ParsedTransaction {
  const ParsedTransaction({
    required this.date,
    required this.description,
    required this.amount,
    this.balanceAfter,
    this.category,
    this.confidence,
  });

  final DateTime date;
  final String description;
  final double amount;
  final double? balanceAfter;
  final TransactionCategory? category;
  final double? confidence;

  ParsedTransaction copyWith({
    DateTime? date,
    String? description,
    double? amount,
    double? balanceAfter,
    TransactionCategory? category,
    double? confidence,
  }) {
    return ParsedTransaction(
      date: date ?? this.date,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      category: category ?? this.category,
      confidence: confidence ?? this.confidence,
    );
  }
}
