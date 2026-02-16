import 'package:drift/drift.dart';

import '../models/transaction_category.dart';

class Statements extends Table {
  TextColumn get id => text()();

  TextColumn get bankCode => text()();

  TextColumn get accountHint => text()();

  DateTimeColumn get periodStart => dateTime()();

  DateTimeColumn get periodEnd => dateTime()();

  DateTimeColumn get importedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Transactions extends Table {
  TextColumn get id => text()();

  TextColumn get statementId => text().references(Statements, #id)();

  DateTimeColumn get date => dateTime()();

  TextColumn get description => text()();

  RealColumn get amount => real()();

  TextColumn get category => text().map(const TransactionCategoryConverter())();

  RealColumn get confidence => real()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Settings extends Table {
  TextColumn get key => text()();

  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class TransactionCategoryConverter
    extends TypeConverter<TransactionCategory, String> {
  const TransactionCategoryConverter();

  @override
  TransactionCategory fromSql(String fromDb) {
    return TransactionCategory.values.firstWhere(
      (item) => item.name == fromDb,
      orElse: () => TransactionCategory.otros,
    );
  }

  @override
  String toSql(TransactionCategory value) {
    return value.name;
  }
}
