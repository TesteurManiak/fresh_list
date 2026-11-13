import 'package:drift/drift.dart';

abstract class const CustomIntType<T extends Object>(
  final CustomIntTypeConverter<T> converter,
) implements CustomSqlType<T> {
  @override
  String mapToSqlLiteral(T dartValue) => converter.toInt(dartValue).toString();

  @override
  Object mapToSqlParameter(T dartValue) => converter.toInt(dartValue);

  @override
  T read(Object fromSql) => converter.fromInt(fromSql as int);

  @override
  String sqlTypeName(GenerationContext context) => context.dialect.integerType;
}

abstract class const CustomIntTypeConverter<T extends Object>() {
  T fromInt(int json);
  int toInt(T value);
}
