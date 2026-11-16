import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RefExtensions on Ref {
  /// When invoked, keeps the provider alive for [duration] after the last
  /// rebuild.
  void cacheFor(Duration duration) {
    final link = keepAlive();
    final timer = Timer(duration, link.close);
    onDispose(timer.cancel);
  }

  Future<void> debounce(Duration duration) {
    final completer = Completer<void>();
    final timer = Timer(duration, () {
      if (!completer.isCompleted) completer.complete();
    });

    onDispose(() {
      timer.cancel();
      if (!completer.isCompleted) {
        completer.completeError(
          StateError('Debounce for provider $hashCode cancelled'),
        );
      }
    });

    return completer.future;
  }
}
