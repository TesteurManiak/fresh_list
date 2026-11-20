import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/extensions/build_context_extensions.dart';
import 'package:fresh_list/src/core/mixins/showable.dart';
import 'package:fresh_list/src/core/theme/color_preset.dart';
import 'package:fresh_list/src/core/theme/color_scheme_seed_controller.dart';
import 'package:fresh_list/src/core/widgets/app_sheet.dart';
import 'package:material_ui/material_ui.dart';

class ColorPresetSheet extends ConsumerWidget
    with ShowableBottomSheetMixin<ColorPreset> {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;
    final cs = ColorScheme.of(context);
    final currentPreset = ref.watch(colorPresetControllerProvider);

    return AppSheet(
      child: ListView.separated(
        itemCount: ColorPreset.values.length,
        shrinkWrap: true,
        separatorBuilder: (_, _) => const SizedBox(height: 4),
        itemBuilder: (context, index) {
          final preset = ColorPreset.values[index];
          return ListTile(
            leading: Icon(Icons.color_lens, color: cs.primary),
            title: Text(preset.label(strings)),
            selected: currentPreset == preset,
            trailing: currentPreset == preset
                ? Icon(Icons.check, color: cs.primary)
                : null,
            onTap: () => Navigator.pop(context, preset),
          );
        },
      ),
    );
  }
}
