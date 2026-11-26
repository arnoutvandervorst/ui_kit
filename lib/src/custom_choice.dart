import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';


Future<Choice?> customChoice(BuildContext context, String title, String content, IconData iconData) async =>
    customConfirmChoice(
      context,
      title: title,
      content: content,
      iconData: iconData,
      confirmChoice: Choice.yes,
      cancelChoice: Choice.no,
      isDismissible: false,
    );
