import 'package:flutter_test/flutter_test.dart';
import 'package:statement_insight/core/categorization/keyword_categorizer.dart';
import 'package:statement_insight/core/models/transaction_category.dart';

void main() {
  group('KeywordCategorizer', () {
    test('categorizes known keywords after normalization', () {
      final categorizer = KeywordCategorizer();

      final result = categorizer.categorize('  uber viaje zona 10  ');

      expect(result.category, TransactionCategory.transporte);
      expect(result.confidence, greaterThan(0.8));
    });

    test('returns otros when no rule matches', () {
      final categorizer = KeywordCategorizer();

      final result = categorizer.categorize('texto sin regla');

      expect(result.category, TransactionCategory.otros);
    });
  });
}
