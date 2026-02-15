import '../models/parsed_statement.dart';

abstract class BankParser {
  bool canParse(String text);

  ParsedStatement parse(String text);
}
