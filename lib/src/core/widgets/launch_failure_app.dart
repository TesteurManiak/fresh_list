import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/theme/theme.dart';

class LaunchFailureApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.light(), home: const _Content());
  }
}

class _Content extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      body: Padding(
        padding: const .symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Container(
              width: 104,
              height: 104,
              decoration: ShapeDecoration(
                color: cs.primaryContainer,
                shape: const StarBorder(
                  points: 12,
                  innerRadiusRatio: .8,
                  pointRounding: .7,
                  valleyRounding: .3,
                ),
              ),
              child: Icon(
                Icons.power_off_rounded,
                color: cs.onPrimaryContainer,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "FreshList couldn't start.",
              textAlign: .center,
              style: textTheme.titleLarge?.copyWith(fontWeight: .w600),
            ),
            const SizedBox(height: 12),
            Text(
              "Close it from the app switcher and open it again. We've "
              'been alerted and are fixing it.',
              textAlign: .center,
              style: textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
