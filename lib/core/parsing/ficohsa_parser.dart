import '../models/parsed_statement.dart';
import '../models/parsed_transaction.dart';
import 'bank_parser.dart';

class FicohsaParser implements BankParser {
  static const String bankCode = 'FICOHSA';

  @override
  bool canParse(String text) {
    return text.toUpperCase().contains(bankCode);
  }

  @override
  ParsedStatement parse(String text) {
    final lines = text.split('\n');
    final tx = <ParsedTransaction>[];

    for (final line in lines) {
      final segments = line.split('|');
      if (segments.length < 3) {
        continue;
      }

      final date = _tryDate(segments[0]);
      final amount = _tryAmount(segments[2]);
      if (date == null || amount == null) {
        continue;
      }

      final balance = segments.length > 3 ? _tryAmount(segments[3]) : null;
      tx.add(
        ParsedTransaction(
          date: date,
          description: segments[1].trim(),
          amount: amount,
          balanceAfter: balance,
        ),
      );
    }

    final now = DateTime.now();
    return ParsedStatement(
      bankCode: bankCode,
      accountHint: _extractAccountHint(text),
      periodStart: tx.isEmpty ? now : tx.first.date,
      periodEnd: tx.isEmpty ? now : tx.last.date,
      transactions: tx,
    );
  }

  DateTime? _tryDate(String value) {
    final clean = value.trim();
    final match = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').firstMatch(clean);
    if (match == null) {
      return null;
    }

    final day = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final year = int.parse(match.group(3)!);
    return DateTime(year, month, day);
  }

  double? _tryAmount(String value) {
    final clean = value
        .replaceAll('Q', '')
        .replaceAll(',', '')
        .replaceAll('\$', '')
        .trim();
    return double.tryParse(clean);
  }

  String _extractAccountHint(String text) {
    final match = RegExp(
      r'CUENTA[: ]+(\*+\d{4})',
      caseSensitive: false,
    ).firstMatch(text);
    if (match == null) {
      return '***0000';
    }
    return match.group(1)!;
  }
}
