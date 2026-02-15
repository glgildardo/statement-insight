import '../models/transaction_category.dart';

class CategorizationResult {
  const CategorizationResult({
    required this.category,
    required this.confidence,
  });

  final TransactionCategory category;
  final double confidence;
}
