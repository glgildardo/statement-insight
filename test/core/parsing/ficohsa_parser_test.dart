import 'package:flutter_test/flutter_test.dart';
import 'package:statement_insight/core/parsing/ficohsa_parser.dart';

void main() {
  group('FicohsaParser', () {
    test('detects bank', () {
      final parser = FicohsaParser();
      expect(parser.canParse('Estado de cuenta FICOHSA'), isTrue);
    });

    test('parses deterministic rows and normalizes amounts', () {
      final parser = FicohsaParser();
      const input = '''
FICOHSA
CUENTA ***1234
01/01/2026|SUPERMERCADO|Q-1,250.50|Q5,000.00
03/01/2026|SALARIO|Q8,000.00|Q13,000.00
''';

      final statement = parser.parse(input);

      expect(statement.bankCode, FicohsaParser.bankCode);
      expect(statement.accountHint, '***1234');
      expect(statement.transactions.length, 2);
      expect(statement.transactions.first.amount, -1250.50);
      expect(statement.transactions.last.amount, 8000.00);
    });
  });
}
