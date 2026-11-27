# ui_kit

The Custom widget layer for Flutter apps built on `material_ui` / `cupertino_ui`, kept in one place so every app gets the same building blocks. The kit holds the widgets; each app gives them its look through tokens and its words through strings.

- **Tokens** (`UiTokens`, a `ThemeExtension`): ground, surface, ink, muted, line, subtle and four semantic accents (`UiAccent`: primary, clay, amber, plum). Put your own set on the theme; widgets read it with `context.tokens`. Without one (a plain test theme) they get coherent defaults.
- **Strings** (`UiStrings`): the few words the widgets show (retry, back, empty, busy, search, "3 of 34"…). Set `UiKit.strings` once at start-up, and in `test/flutter_test_config.dart`, to a function that reads your translations, so a language switch shows at the next build. Defaults are English.
- **Enums** (`EnumItem`): a mixin for enums the pickers show (`title`, `description`, `iconData`, `color`, `pickerGroup`). `Choice` is the answer of a confirm sheet.
- **Spacing** (`gapy8`, `p16`, `px12`, `kPageGutter`…) and `GutterScope` / `PageBody` / `CustomSpacedColumn`: widgets own no outer space, parents own the rhythm.
- **Widgets**: lists and grids with an entry animation, empty / error / denied / loading columns, sheets and help sheets, confirm and OK choices, chips, segmented controls, icon badges, a progress indicator, and the enum picker.

## The enum picker

`customEnumPicker(context, title, icon, items, selected, onTap, question: …)` opens a sheet with every choice as a row: the title, the item's `description` as a line of explanation, and a ring that turns into a check. A tap picks and closes. The sheet grows with the list:

| Choices | Layout |
|---|---|
| up to 7 | the sheet is as tall as the list |
| 8 to 14 | the sheet grows up to 90% of the screen and the list scrolls, opening on the chosen row |
| 15 or more | a search field (title and description, ignoring case and accents) with a match count, and the items' `pickerGroup` as headings |

The thresholds live in the widget (`enumPickerLayoutFor`), so a caller never chooses a layout. The caller decides the order of `items`. `CustomEnumPickerTile` is a row that shows the current value and opens the picker.

## Use

```yaml
dependencies:
  ui_kit:
    git:
      url: https://github.com/arnoutvandervorst/ui_kit.git
      ref: v0.2.1
```

```dart
void main() {
  UiKit.strings = () => UiStrings(retry: t.error.retry, search: t.picker.search /* … */);
  runApp(const App());
}
```

No native code: the kit depends only on Flutter, `material_ui`, `cupertino_ui` and `flutter_hooks`.

## Changes

See [CHANGELOG.md](CHANGELOG.md). Versions are git tags (`vX.Y.Z`) with a GitHub release.
