import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/src/ui_constants.dart';
import 'package:ui_kit/src/ui_tokens.dart';

/// The theme lookups the Custom widgets use.
extension UiContext on BuildContext {
  ThemeData get themeData => Theme.of(this);

  TextTheme get textTheme => themeData.textTheme;

  ColorScheme get colorScheme => themeData.colorScheme;

  TextStyle? get bodyMediumWhite => textTheme.bodyMedium?.apply(color: Colors.white);

  UiTokens get tokens => UiTokens.of(this);

  BorderRadius get cardBorderRadius => BorderRadius.circular(kCardRadius);

  /// The 1 px line border every flat card carries.
  BoxBorder get softOutlineBorder => Border.all(color: tokens.line);

  /// A flat tinted well (icon badges, pills): [tintColor] at [tintOpacity]
  /// over the surface, no border, no shadow. [elevated] is ignored (the look
  /// has no shadows).
  BoxDecoration premiumOverlayDecoration({
    Color? tintColor,
    double tintOpacity = 0.18,
    BorderRadius? borderRadius,
    bool elevated = false,
  }) {
    return BoxDecoration(
      color: tintColor == null
          ? tokens.subtle
          : Color.alphaBlend(tintColor.withValues(alpha: tintOpacity.clamp(0.1, 0.2)), tokens.surface),
      borderRadius: borderRadius ?? BorderRadius.circular(kControlRadius),
    );
  }
}
