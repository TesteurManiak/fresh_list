import 'package:drift/drift.dart';

abstract class const CustomTextType<T extends Object>(
  final CustomTextTypeConverter<T> converter,
) implements CustomSqlType<T> {
  @override
  String mapToSqlLiteral(T dartValue) => converter.toText(dartValue);

  @override
  Object mapToSqlParameter(T dartValue) => converter.toText(dartValue);

  @override
  T read(Object fromSql) => converter.fromText(fromSql as String);

  @override
  String sqlTypeName(GenerationContext context) => context.dialect.textType;
}

abstract class const CustomTextTypeConverter<T extends Object>() {
  T fromText(String json);
  String toText(T value);
}
