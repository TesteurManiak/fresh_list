import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/extensions/iterable_extensions.dart';

/// {@template separated_row}
/// Creates a horizontal array of [children] separated by a [separator].
/// {@endtemplate}
class SeparatedRow extends StatelessWidget {
  /// {@macro separated_row}
  const SeparatedRow({
    required this.separator,
    required this.children,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.crossAxisAlignment,
    this.textDirection,
    this.verticalDirection,
    this.textBaseline,
    super.key,
  });

  /// Defaults to [MainAxisAlignment.start].
  final MainAxisAlignment? mainAxisAlignment;

  /// Defaults to [MainAxisSize.max].
  final MainAxisSize? mainAxisSize;

  /// Defaults to [CrossAxisAlignment.center].
  final CrossAxisAlignment? crossAxisAlignment;

  final TextDirection? textDirection;

  /// Defaults to [VerticalDirection.down].
  final VerticalDirection? verticalDirection;

  final TextBaseline? textBaseline;

  final Widget separator;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      textDirection: textDirection,
      verticalDirection: verticalDirection ?? VerticalDirection.down,
      textBaseline: textBaseline,
      children: [...children.separatedWith(separator)],
    );
  }
}
