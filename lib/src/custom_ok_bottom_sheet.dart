import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';


Future<void> customOkBottomSheet(BuildContext context, String title, String content, IconData iconData) async =>
    showModalBottomSheet<void>(
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: kRadiusCircular)),
      builder: (context) => SafeArea(
        child: CustomBottomSheetBody(
          iconData: iconData,
          title: title,
          content: Text(content, textAlign: TextAlign.center),
          actions: [
            FilledButton.icon(
              style: ButtonStyle(elevation: const WidgetStatePropertyAll(1)),
              icon: const Icon(CupertinoIcons.checkmark, color: Colors.white),
              label: Text(Choice.yes.title, style: context.bodyMediumWhite),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
