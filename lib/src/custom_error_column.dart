import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

/// A failed load, always with a way forward: **Try again** when the caller
/// can re-subscribe ([onRetry]) and **Go back** when the route can pop.
class CustomErrorColumn extends StatelessWidget {
  final Object? error;

  /// Re-subscribes the failed source; hides the button when null.
  final VoidCallback? onRetry;

  const CustomErrorColumn({super.key, this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.maybeOf(context)?.canPop() ?? false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(CupertinoIcons.exclamationmark_circle, color: Theme.of(context).colorScheme.error)],
        ),
        gapy12,
        //* Flexible: a bare Text in a Row cannot wrap, so the message overflowed
        //* at phone width (caught by the common-widget gallery test).
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Flexible(child: Text(UiKit.strings.errorDescription, textAlign: TextAlign.center))],
        ),
        if (error != null && kDebugMode) ...[gapy12, Text(error.toString(), textAlign: TextAlign.center)],
        if (onRetry != null || canPop) ...[
          gapy12,
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              if (onRetry != null)
                FilledButton.tonalIcon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(UiKit.strings.retry),
                ),
              if (canPop)
                TextButton.icon(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: Text(UiKit.strings.back),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
