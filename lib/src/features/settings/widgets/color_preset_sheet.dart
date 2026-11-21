import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/extensions/build_context_extensions.dart';
import 'package:fresh_list/src/core/mixins/showable.dart';
import 'package:fresh_list/src/core/theme/color_preset.dart';
import 'package:fresh_list/src/core/theme/color_preset_notifier.dart';
import 'package:fresh_list/src/core/theme/dynamic_color_notifier.dart';
import 'package:fresh_list/src/core/widgets/app_sheet.dart';
import 'package:fresh_list/src/core/widgets/sheet_tile.dart';
import 'package:material_ui/material_ui.dart';

class ColorPresetSheet extends ConsumerWidget
    with ShowableBottomSheetMixin<ColorPreset> {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;
    final dynamicColorSupported = ref.watch(isDynamicColorSupportedProvider);
    final currentPreset = ref.watch(colorPresetNotifierProvider);
    final cs = ColorScheme.of(context);

    final availablePresets = ColorPreset.values.toList();
    if (!dynamicColorSupported) availablePresets.remove(ColorPreset.dynamic);

    return AppSheet(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: availablePresets.length,
        separatorBuilder: (_, _) => const SizedBox(height: SheetTile.gap),
        itemBuilder: (context, index) {
          final preset = availablePresets[index];

          return SheetTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: preset.color,
                borderRadius: .circular(8),
                border: .all(color: cs.outlineVariant, width: 1.5),
              ),
            ),
            title: preset.label(strings),
            selected: currentPreset == preset,
            borderRadius: SheetTile.radiusFor(
              index,
              availablePresets.length,
              currentPreset == preset,
            ),
            onTap: () => Navigator.pop(context, preset),
          );
        },
      ),
    );
  }
}
