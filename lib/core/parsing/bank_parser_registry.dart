import 'bank_parser.dart';
import 'ficohsa_parser.dart';

class BankParserRegistry {
  BankParserRegistry({List<BankParser>? parsers})
      : _parsers = parsers ?? <BankParser>[FicohsaParser()];

  final List<BankParser> _parsers;

  BankParser parserForText(String text) {
    for (final parser in _parsers) {
      if (parser.canParse(text)) {
        return parser;
      }
    }
    throw StateError('No parser found for provided statement text');
  }
}
