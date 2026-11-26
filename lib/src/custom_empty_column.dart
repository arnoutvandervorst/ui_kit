import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomEmptyColumn extends StatelessWidget {
  const CustomEmptyColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(CupertinoIcons.question)]),
        gapy12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Flexible(child: Text(UiKit.strings.empty, textAlign: TextAlign.center))],
        ),
      ],
    );
  }
}
