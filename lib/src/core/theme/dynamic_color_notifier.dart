import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/mixins/initializable_notifier.dart';
import 'package:material_ui/material_ui.dart';

typedef DynamicColorRecord = ({
  ColorScheme lightDynamic,
  ColorScheme darkDynamic,
});

final dynamicColorNotifierProvider =
    NotifierProvider<DynamicColorNotifier, DynamicColorRecord?>(
      DynamicColorNotifier.new,
    );

class DynamicColorNotifier extends Notifier<DynamicColorRecord?>
    with InitializableNotifier {
  @override
  DynamicColorRecord? build() {
    initOnBuild();
    return null;
  }

  @override
  Future<void> performInit() async {
    try {
      final corePalette = await DynamicColorPlugin.getCorePalette();
      if (corePalette == null) return;

      state = (
        lightDynamic: corePalette.toColorScheme(),
        darkDynamic: corePalette.toColorScheme(brightness: .dark),
      );
    } on PlatformException {
      // Platform does not support dynamic color; leave state as null.
    } on MissingPluginException {
      // Running on a platform without a native implementation (e.g. Web).
    }
  }
}

final isDynamicColorSupportedProvider = Provider<bool>(
  (ref) => ref.watch(dynamicColorNotifierProvider.select((c) => c != null)),
);
