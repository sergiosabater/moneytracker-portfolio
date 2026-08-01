import 'package:intl/intl.dart';

/// Formats a [DateTime] as a short, human-friendly relative date label
/// for grouping/display purposes — "Today", "Yesterday", "Mon, Mar 8",
/// or "Mon, Mar 8, 2025" once the date is more than a year old.
///
/// Pure Dart, no Flutter dependencies: [todayLabel] and [yesterdayLabel]
/// are injected by the caller (from [AppLocalizations]) rather than
/// resolved internally, so this class has no knowledge of the widget
/// tree and can be unit tested in isolation. [now] defaults to the real
/// current time but can be overridden for deterministic tests.
class RelativeDateFormatter {
  RelativeDateFormatter._();

  static String format(
    DateTime date, {
    required String todayLabel,
    required String yesterdayLabel,
    required String locale,
    DateTime? now,
  }) {
    final reference = now ?? DateTime.now();
    final today = _dateOnly(reference);
    final target = _dateOnly(date);

    final dayDifference = today.difference(target).inDays;

    if (dayDifference == 0) return todayLabel;
    if (dayDifference == 1) return yesterdayLabel;

    final pattern = target.year == today.year ? 'E, d MMMM' : 'E, d MMMM y';
    final formatted = DateFormat(pattern, locale).format(target);

    // DateFormat capitalizes neither the weekday abbreviation nor the
    // month name for every locale by default; normalizing the first
    // letter keeps the result visually consistent across languages.
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  /// Strips the time-of-day component so date comparisons ("is this
  /// today?") aren't affected by the hour/minute a transaction was
  /// recorded at.
  static DateTime _dateOnly(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}
