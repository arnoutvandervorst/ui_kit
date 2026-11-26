import 'package:material_ui/material_ui.dart';

/// The design tokens every Custom widget reads (via `context.tokens`). An app
/// puts its own set on the theme as a `ThemeExtension`; without one, widgets
/// pumped in a plain theme (tests) get the defaults below.
///
//* The semantic accents carry meaning: primary = actions, clay = warm accent,
//* amber = what you earn, plum = the reflective part. Never a hardcoded hex
//* in a widget.
@immutable
class UiTokens extends ThemeExtension<UiTokens> {
  /// Page background (warm off-white in light).
  final Color ground;

  /// Cards, bars, inputs.
  final Color surface;

  /// Primary text.
  final Color ink;

  /// Secondary text.
  final Color muted;

  /// Borders and dividers.
  final Color line;

  /// Segmented-control track, progress tracks, quiet fills.
  final Color subtle;

  final UiAccent primary;
  final UiAccent clay;
  final UiAccent amber;
  final UiAccent plum;

  /// Secondary avatar hue.
  final Color avatarAlt;

  const UiTokens({
    required this.ground,
    required this.surface,
    required this.ink,
    required this.muted,
    required this.line,
    required this.subtle,
    required this.primary,
    required this.clay,
    required this.amber,
    required this.plum,
    required this.avatarAlt,
  });

  static const UiTokens light = UiTokens(
    ground: Color(0xFFF6F4EF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1B2421),
    muted: Color(0xFF5B6661),
    line: Color(0xFFE4E0D6),
    subtle: Color(0xFFEFEBE2),
    primary: UiAccent(
      color: Color(0xFF0F6E6A),
      onColor: Color(0xFFFFFFFF),
      strong: Color(0xFF0F6E6A),
      tint: Color(0xFFDDEEEB),
      line: Color(0xFFCFE3DF),
    ),
    clay: UiAccent(
      color: Color(0xFF8A3620),
      onColor: Color(0xFFFFFFFF),
      strong: Color(0xFFE0674A),
      tint: Color(0xFFFBE3DA),
      line: Color(0xFFF0D5CB),
    ),
    amber: UiAccent(
      color: Color(0xFF7A520C),
      onColor: Color(0xFFFFFFFF),
      strong: Color(0xFFB07A17),
      tint: Color(0xFFF4E8CF),
      line: Color(0xFFEBDDBE),
    ),
    plum: UiAccent(
      color: Color(0xFF5B3F7A),
      onColor: Color(0xFFFFFFFF),
      strong: Color(0xFF5B3F7A),
      tint: Color(0xFFE9E2F1),
      line: Color(0xFFDCD2E8),
    ),
    avatarAlt: Color(0xFF2F5D8A),
  );

  //* Dark is derived from the same hues, not inverted: a deep green-black
  //* ground (the live player's family), raised surfaces a step lighter, and
  //* each accent lifted in lightness so text on the ground keeps >= 4.5:1.
  //* Tints become low-lightness washes of the hue instead of pastels.
  static const UiTokens dark = UiTokens(
    ground: Color(0xFF111816),
    surface: Color(0xFF19221F),
    ink: Color(0xFFEDEFEA),
    muted: Color(0xFFA3AEA8),
    line: Color(0xFF2C3632),
    subtle: Color(0xFF232D2A),
    primary: UiAccent(
      color: Color(0xFF63C7BD),
      onColor: Color(0xFF062624),
      strong: Color(0xFF63C7BD),
      tint: Color(0xFF173B38),
      line: Color(0xFF24504B),
    ),
    clay: UiAccent(
      color: Color(0xFFF2A488),
      onColor: Color(0xFF3A1206),
      strong: Color(0xFFFF8A66),
      tint: Color(0xFF3B231B),
      line: Color(0xFF5A3426),
    ),
    amber: UiAccent(
      color: Color(0xFFE6BA67),
      onColor: Color(0xFF2E1F02),
      strong: Color(0xFFE0A93E),
      tint: Color(0xFF362B15),
      line: Color(0xFF4F3F1E),
    ),
    plum: UiAccent(
      color: Color(0xFFC9AEEA),
      onColor: Color(0xFF26163A),
      strong: Color(0xFFC9AEEA),
      tint: Color(0xFF2D2440),
      line: Color(0xFF443759),
    ),
    avatarAlt: Color(0xFF7FA8D4),
  );

  /// The tokens for [brightness]; widgets pumped without the app theme (plain
  /// ThemeData in tests) still get a coherent set.
  static UiTokens of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<UiTokens>() ?? (theme.brightness == Brightness.dark ? dark : light);
  }

  /// The accent for a semantic [kind].
  UiAccent accent(UiAccentKind kind) => switch (kind) {
    UiAccentKind.primary => primary,
    UiAccentKind.clay => clay,
    UiAccentKind.amber => amber,
    UiAccentKind.plum => plum,
  };

  @override
  UiTokens copyWith({
    Color? ground,
    Color? surface,
    Color? ink,
    Color? muted,
    Color? line,
    Color? subtle,
    UiAccent? primary,
    UiAccent? clay,
    UiAccent? amber,
    UiAccent? plum,
    Color? avatarAlt,
  }) {
    return UiTokens(
      ground: ground ?? this.ground,
      surface: surface ?? this.surface,
      ink: ink ?? this.ink,
      muted: muted ?? this.muted,
      line: line ?? this.line,
      subtle: subtle ?? this.subtle,
      primary: primary ?? this.primary,
      clay: clay ?? this.clay,
      amber: amber ?? this.amber,
      plum: plum ?? this.plum,
      avatarAlt: avatarAlt ?? this.avatarAlt,
    );
  }

  @override
  UiTokens lerp(ThemeExtension<UiTokens>? other, double t) {
    if (other is! UiTokens) return this;
    return UiTokens(
      ground: Color.lerp(ground, other.ground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      line: Color.lerp(line, other.line, t)!,
      subtle: Color.lerp(subtle, other.subtle, t)!,
      primary: UiAccent.lerp(primary, other.primary, t),
      clay: UiAccent.lerp(clay, other.clay, t),
      amber: UiAccent.lerp(amber, other.amber, t),
      plum: UiAccent.lerp(plum, other.plum, t),
      avatarAlt: Color.lerp(avatarAlt, other.avatarAlt, t)!,
    );
  }
}

/// The four semantic accents.
enum UiAccentKind { primary, clay, amber, plum }

/// One semantic accent: [color] for text/icons/fills, [onColor] on a
/// [color] fill, [strong] for bars and borders that need more punch, [tint]
/// for soft fills and [line] for the card border in that accent. [ink] is a
/// word in the accent on its tint or on the surface (a pill, a status, a price):
/// [strong] unless that is too light to read (the light look's yellow).
@immutable
class UiAccent {
  final Color color;
  final Color onColor;
  final Color strong;
  final Color tint;
  final Color line;
  final Color ink;

  const UiAccent({
    required this.color,
    required this.onColor,
    required this.strong,
    required this.tint,
    required this.line,
    Color? ink,
  }) : ink = ink ?? strong;

  static UiAccent lerp(UiAccent a, UiAccent b, double t) => UiAccent(
    color: Color.lerp(a.color, b.color, t)!,
    onColor: Color.lerp(a.onColor, b.onColor, t)!,
    strong: Color.lerp(a.strong, b.strong, t)!,
    tint: Color.lerp(a.tint, b.tint, t)!,
    line: Color.lerp(a.line, b.line, t)!,
    ink: Color.lerp(a.ink, b.ink, t)!,
  );
}
