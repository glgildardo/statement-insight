import 'categorization_result.dart';

abstract class TransactionCategorizer {
  CategorizationResult categorize(String description);
}
