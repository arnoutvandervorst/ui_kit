# Changelog

All notable changes to this package. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the package uses [semantic versioning](https://semver.org/) (pre-1.0: a minor bump may break the API). Each version is a git tag (`vX.Y.Z`) with a GitHub release.

## [0.2.1] - 2026-11-27
### Fixed
- `PageBody` declares the page gutter as applied only when its `padding` has a horizontal part; with a vertical-only padding its children apply the gutter themselves.
### Changed
- The four list widgets share one fade-in hook; the fade's animation is made once instead of on every build.
### Removed
- The unused `email_validator` dependency.

## [0.2.0] - 2026-11-26
### Added
- `CustomIconBlock`: an icon on a rounded square in a `UiAccent`'s colour (default 44 px, radius `kControlRadius`), decorative for screen readers.

## [0.1.1] - 2026-11-26
### Fixed
- The enum picker opens on the chosen row also when it lies far below the fold: the list jumps near it first (the rows are built lazily), then brings it in view.
- A search mark never runs past the title: folding (for example `İ`) can lengthen the folded text, which could throw while building the row.
### Added
- In debug, `UiKit.strings` says once when it was never set (the widgets then show the English defaults).

## [0.1.0] - 2026-11-26
### Added
- `UiTokens` / `UiAccent` / `UiAccentKind`: the design tokens every widget reads through `context.tokens`, with defaults for a plain theme.
- `UiStrings` and `UiKit.strings`: the widgets' words, filled by the app from its own translations.
- `EnumItem` (with `pickerGroup`) and `Choice`.
- Spacing, padding and radius constants; `GutterScope`, `PageBody`, `CustomSpacedColumn`; the `UiContext` lookups.
- Widgets: animated list, grid and page views; empty, error, denied and loading columns; empty state; bottom-sheet body, help and OK sheets; confirm choice; choice chip; segmented control and segment button; filled icon button and icon badge; busy label; progress indicator; keyboard unfocus; null container; text body.
- The enum picker (`customEnumPicker`, `CustomEnumPickerSheet`, `CustomEnumOption`, `CustomEnumPickerTile`): every choice as a row with a line of explanation; up to 7 choices the sheet fits the list, from 8 it grows up to 90% and scrolls to the chosen row, from 15 it adds search with a match count and group headings.

[0.2.0]: https://github.com/arnoutvandervorst/ui_kit/releases/tag/v0.2.0
[0.1.1]: https://github.com/arnoutvandervorst/ui_kit/releases/tag/v0.1.1
[0.1.0]: https://github.com/arnoutvandervorst/ui_kit/releases/tag/v0.1.0
