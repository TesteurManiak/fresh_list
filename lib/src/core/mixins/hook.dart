import 'package:flutter/widgets.dart';

mixin HookMixin<T extends StatefulWidget> on State<T> {
  final _hooks = <ChangeNotifier>{};

  ScrollController useScrollController() {
    final controller = ScrollController();
    _hooks.add(controller);
    return controller;
  }

  TNotifier willDispose<TNotifier extends ChangeNotifier>(TNotifier notifier) {
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
