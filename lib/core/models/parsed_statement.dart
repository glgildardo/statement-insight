import 'parsed_transaction.dart';

class ParsedStatement {
  const ParsedStatement({
    required this.bankCode,
    required this.accountHint,
    required this.periodStart,
    required this.periodEnd,
    required this.transactions,
  });

  final String bankCode;
  final String accountHint;
  final DateTime periodStart;
  final DateTime periodEnd;
  final List<ParsedTransaction> transactions;

  ParsedStatement copyWith({
    String? bankCode,
    String? accountHint,
    DateTime? periodStart,
    DateTime? periodEnd,
    List<ParsedTransaction>? transactions,
  }) {
    return ParsedStatement(
      bankCode: bankCode ?? this.bankCode,
      accountHint: accountHint ?? this.accountHint,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      transactions: transactions ?? this.transactions,
    );
  }
}
