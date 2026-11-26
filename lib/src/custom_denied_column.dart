import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomDeniedColumn extends StatelessWidget {
  const CustomDeniedColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(CupertinoIcons.nosign, color: Colors.red)],
        ),
        gapy12,
        //* Flexible: a bare Text in a Row cannot wrap, so the message overflowed
        //* at phone width (caught by the common-widget gallery test).
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Flexible(child: Text(UiKit.strings.notAllowed, textAlign: TextAlign.center))],
        ),
      ],
    );
  }
}
