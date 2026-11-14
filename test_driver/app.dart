import 'package:flutter_driver/driver_extension.dart';
import 'package:todo_list/main.dart' as app;

Future<void> main() async {
  enableFlutterDriverExtension();
  await app.main();
}
