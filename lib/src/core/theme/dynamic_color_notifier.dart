import 'package:dynamic_color_ffi/dynamic_color_ffi.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/mixins/initializable_notifier.dart';

final dynamicColorNotifierProvider =
    NotifierProvider<DynamicColorNotifier, DynamicSchemeFactory?>(
      DynamicColorNotifier.new,
    );

class DynamicColorNotifier extends Notifier<DynamicSchemeFactory?>
    with InitializableNotifier {
  final plugin = DynamicColorFfi();
  @override
  DynamicSchemeFactory? build() {
    initOnBuild();
    return null;
  }

  @override
  Future<void> performInit() async {
    try {
      final palettes = plugin.getTonalPalettes();
      if (palettes == null) return;

      state = ColorPaletteSchemeFactory(tonalPalettes: palettes);
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
