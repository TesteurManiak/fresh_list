import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/extensions/build_context_extensions.dart';
import 'package:fresh_list/src/core/mixins/showable.dart';
import 'package:fresh_list/src/core/theme/color_preset.dart';
import 'package:fresh_list/src/core/theme/color_scheme_seed_controller.dart';
import 'package:fresh_list/src/core/widgets/app_sheet.dart';
import 'package:fresh_list/src/core/widgets/sheet_tile.dart';
import 'package:material_ui/material_ui.dart';

class ColorPresetSheet extends ConsumerWidget
    with ShowableBottomSheetMixin<ColorPreset> {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;
    final currentPreset = ref.watch(colorPresetControllerProvider);
    final cs = ColorScheme.of(context);

    return AppSheet(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: ColorPreset.values.length,
        separatorBuilder: (_, _) => const SizedBox(height: SheetTile.gap),
        itemBuilder: (context, index) {
          final preset = ColorPreset.values[index];
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
              ColorPreset.values.length,
              currentPreset == preset,
            ),
            onTap: () => Navigator.pop(context, preset),
          );
        },
      ),
    );
  }
}
