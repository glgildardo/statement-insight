import '../models/parsed_statement.dart';

abstract class StatementRepository {
  Future<void> saveParsedStatement(ParsedStatement statement);
}
