import 'package:flutter/foundation.dart' show debugPrint;

/// The words the Custom widgets show. The app fills them from its own
/// translations ([UiKit.strings]); the defaults are English.
class UiStrings {
  final String warning;
  final String emailInvalid;
  final String notAllowed;
  final String empty;
  final String busy;
  final String errorTitle;
  final String errorDescription;
  final String retry;
  final String back;
  final String yes;
  final String no;
  final String cancel;
  final String unknown;
  final String search;
  final String clearSearch;

  /// "3 of 34": what a search left of a picker's choices.
  final String Function(int shown, int total) matchCount;

  /// The line when a search finds nothing.
  final String Function(String query) noMatch;

  const UiStrings({
    this.warning = 'Warning',
    this.emailInvalid = 'This e-mail address is not valid.',
    this.notAllowed = 'You are not allowed to see this.',
    this.empty = 'Nothing here yet.',
    this.busy = 'Busy',
    this.errorTitle = 'Something went wrong',
    this.errorDescription = 'Something went wrong. Please try again.',
    this.retry = 'Try again',
    this.back = 'Back',
    this.yes = 'Yes',
    this.no = 'No',
    this.cancel = 'Cancel',
    this.unknown = 'Unknown',
    this.search = 'Search',
    this.clearSearch = 'Clear search',
    this.matchCount = _matchCount,
    this.noMatch = _noMatch,
  });
}

/// Where the kit gets its words. Set [strings] once at start-up (and in the
/// test config) to a function that reads the app's current locale, so a
/// language switch shows at the next build.
String _matchCount(int shown, int total) => '$shown of $total';

String _noMatch(String query) => 'Nothing found for "$query".';

abstract final class UiKit {
  static UiStrings Function() _strings = () => const UiStrings();
  static bool _configured = false;
  static bool _warned = false;

  static UiStrings get strings {
    //* In debug, say once that nobody set the words: the English defaults show.
    assert(() {
      if (!_configured && !_warned) {
        _warned = true;
        debugPrint('ui_kit: UiKit.strings was never set; the widgets show the English defaults.');
      }
      return true;
    }());
    return _strings();
  }

  static set strings(UiStrings Function() resolve) {
    _strings = resolve;
    _configured = true;
  }
}
