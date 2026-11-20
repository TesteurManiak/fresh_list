import 'package:fresh_list/src/core/database/converters/custom_int_converter.dart';
import 'package:fresh_list/src/core/database/converters/custom_text_converter.dart';

class const IntIdColumnConverter<T extends int>(final T Function(int) intParser)
    extends CustomIntTypeConverter<T> {
  @override
  T fromInt(int json) => intParser(json);

  @override
  int toInt(T value) => value;
}

class const StringIdColumnConverter<T extends String>(
  final T Function(String) textParser,
) extends CustomTextTypeConverter<T> {
  @override
  T fromText(String json) => textParser(json);

  @override
  String toText(T value) => value;
}
