import '../models/transaction_category.dart';
import 'categorization_result.dart';
import 'transaction_categorizer.dart';

class KeywordCategorizer implements TransactionCategorizer {
  KeywordCategorizer({Map<TransactionCategory, List<String>>? rules})
      : _rules = rules ?? _defaultRules;

  final Map<TransactionCategory, List<String>> _rules;

  static const Map<TransactionCategory, List<String>> _defaultRules = {
    TransactionCategory.comida: <String>[
      'RESTAURANTE',
      'PIZZA',
      'BURGER',
      'CAFE',
      'SUPERMERCADO',
    ],
    TransactionCategory.transporte: <String>[
      'UBER',
      'GASOLINERA',
      'COMBUSTIBLE',
      'TAXI',
      'PEAJE',
    ],
    TransactionCategory.transferencias: <String>[
      'TRANSFERENCIA',
      'ACH',
      'ENVIO',
      'REMITENCIA',
    ],
    TransactionCategory.comisionesImpuestos: <String>[
      'COMISION',
      'IMPUESTO',
      'ISV',
      'CARGO ADMINISTRATIVO',
    ],
    TransactionCategory.efectivo: <String>[
      'CAJERO',
      'ATM',
      'RETIRO',
      'EFECTIVO',
    ],
    TransactionCategory.compras: <String>[
      'AMAZON',
      'TIENDA',
      'DEPARTAMENTO',
      'MERCADO LIBRE',
    ],
  };

  @override
  CategorizationResult categorize(String description) {
    final normalized = _normalize(description);
    if (normalized.isEmpty) {
      return const CategorizationResult(
        category: TransactionCategory.otros,
        confidence: 0.1,
      );
    }

    for (final entry in _rules.entries) {
      for (final keyword in entry.value) {
        if (normalized.contains(keyword)) {
          return CategorizationResult(category: entry.key, confidence: 0.85);
        }
      }
    }

    return const CategorizationResult(
      category: TransactionCategory.otros,
      confidence: 0.3,
    );
  }

  String _normalize(String value) {
    return value.toUpperCase().trim().replaceAll(RegExp(r'\s+'), ' ');
  }
}
