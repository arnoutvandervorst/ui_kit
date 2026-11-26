import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

/// A single adaptive confirm API for important user choices.
///
/// - iOS/macOS: CupertinoAlertDialog
/// - Android/others: Material AlertDialog
Future<Choice?> customConfirmChoice(
  BuildContext context, {
  required String title,
  required String content,
  IconData? iconData,
  Choice confirmChoice = Choice.yes,
  Choice cancelChoice = Choice.no,
  bool isDismissible = false,
  bool useRootNavigator = true,
  bool isDestructive = false,
}) async {
  final platform = Theme.of(context).platform;
  final isCupertino = platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

  if (isCupertino) {
    return showCupertinoDialog<Choice>(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: isDismissible,
      builder: (dialogContext) {
        return CupertinoAlertDialog(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconData != null) ...[Icon(iconData, size: 28), const SizedBox(height: 8)],
              Text(title),
            ],
          ),
          content: Padding(padding: const EdgeInsets.only(top: 8), child: Text(content)),
          actions: [
            CupertinoDialogAction(onPressed: () => Navigator.of(dialogContext).pop(cancelChoice), child: Text(cancelChoice.title)),
            CupertinoDialogAction(
              isDefaultAction: !isDestructive,
              isDestructiveAction: isDestructive,
              onPressed: () => Navigator.of(dialogContext).pop(confirmChoice),
              child: Text(confirmChoice.title),
            ),
          ],
        );
      },
    );
  }

  return showDialog<Choice>(
    context: context,
    useRootNavigator: useRootNavigator,
    barrierDismissible: isDismissible,
    builder: (dialogContext) {
      return AlertDialog(
        icon: iconData != null ? Icon(iconData) : null,
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(cancelChoice), child: Text(cancelChoice.title)),
          FilledButton(
            style: isDestructive
                ? FilledButton.styleFrom(backgroundColor: Theme.of(dialogContext).colorScheme.error)
                : null,
            onPressed: () => Navigator.of(dialogContext).pop(confirmChoice),
            child: Text(confirmChoice.title),
          ),
        ],
      );
    },
  );
}
