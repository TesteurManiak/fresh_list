import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Mixin for Riverpod Notifiers that require one-time async initialization
/// (e.g., warming up from SharedPreferences in main() or re-initializing after
/// autoDispose).
mixin InitializableNotifier<T> on Notifier<T> {
  Future<void>? _initFuture;
  bool _initialized = false;

  /// Idempotent initialization method. Safe to call multiple times or
  /// concurrently.
  Future<void> init() {
    if (_initialized) return Future.value();
    return _initFuture ??= _runInit();
  }

  Future<void> _runInit() async {
    try {
      await performInit();
      _initialized = true;
    } catch (e, s) {
      log(
        'Error during initialization of provider $runtimeType',
        error: e,
        stackTrace: s,
        name: 'InitializableNotifier',
      );

      // Reset _initFuture on failure so subsequent calls can retry
      _initFuture = null;
      rethrow;
    }
  }

  /// Implement your async loading logic here (e.g. reading SharedPreferences).
  @protected
  Future<void> performInit();

  /// Helper to safely trigger [init] from inside [build].
  /// Defers execution by a microtask so [state] mutations inside [performInit]
  /// don't collide with Riverpod's synchronous build phase.
  @protected
  void initOnBuild() {
    if (_initialized || _initFuture != null) return;

    // Reset flags when the provider is disposed so a future rebuild
    // re-initializes.
    ref.onDispose(() {
      _initialized = false;
      _initFuture = null;
    });

    Future.microtask(init);
  }
}
