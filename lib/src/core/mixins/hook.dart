import 'package:flutter/widgets.dart';

mixin HookMixin<TState extends StatefulWidget> on State<TState> {
  final _hooks = <ChangeNotifier>{};

  TextEditingController useTextEditingController({String? text}) =>
      willDispose(TextEditingController(text: text));

  ScrollController useScrollController() => willDispose(ScrollController());

  FocusNode useFocusNode() => willDispose(FocusNode());

  ValueNotifier<T> useValue<T>(T value) => willDispose(ValueNotifier<T>(value));

  T willDispose<T extends ChangeNotifier>(T notifier) {
    _hooks.add(notifier);
    return notifier;
  }

  @override
  void dispose() {
    for (final hook in _hooks) {
      hook.dispose();
    }
    super.dispose();
  }
}
