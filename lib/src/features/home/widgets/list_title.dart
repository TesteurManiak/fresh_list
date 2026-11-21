import 'package:fresh_list/src/core/constants/consts.dart';
import 'package:fresh_list/src/core/mixins/hook.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class ListTitle extends StatefulWidget {
  const new({super.key});

  @override
  State<ListTitle> createState() => _ListTitleState();
}

class _ListTitleState extends State<ListTitle> with HookMixin {
  late final editionNotifier = useValue(false);
  late final titleNotifier = useValue(AppConstants.appName);
  late final controller = useTextEditingController(text: AppConstants.appName);
  late final focusNode = useFocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        editionNotifier.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final textStyle = GoogleFonts.unbounded(
      textStyle: textTheme.titleLarge,
      fontWeight: .w600,
      letterSpacing: -.3,
    );

    return ValueListenableBuilder(
      valueListenable: editionNotifier,
      builder: (context, isEditing, child) {
        if (isEditing) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            decoration: const InputDecoration(border: .none),
            onSubmitted: (value) {
              titleNotifier.value = value;
              editionNotifier.value = false;
            },
            style: textStyle,
          );
        }
        return child!;
      },
      child: InkWell(
        onTap: () => editionNotifier.value = true,
        child: ValueListenableBuilder(
          valueListenable: titleNotifier,
          builder: (context, title, _) {
            return Text(
              title,
              style: textStyle,
              maxLines: 1,
              overflow: .ellipsis,
            );
          },
        ),
      ),
    );
  }
}
