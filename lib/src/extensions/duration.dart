extension DurationExtension on Duration {
  String format({String hoursTrailing = '', String minutesTrailing = ''}) {
    if (inHours > 0) {
      return formatHMS(trailing: hoursTrailing);
    }

    return formatMS(trailing: minutesTrailing);
  }

  /// Returns HH:mm:ss
  String formatHMS({String trailing = ''}) {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = (inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds${trailing.isNotEmpty ? ' $trailing' : ''}';
  }

  /// Returns HH:mm
  String formatHM({String trailing = ''}) {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = (inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes${trailing.isNotEmpty ? ' $trailing' : ''}';
  }

  /// Returns mm:ss
  String formatMS({String trailing = ''}) {
    final minutes = inMinutes.toString().padLeft(2, '0');
    final seconds = (inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds${trailing.isNotEmpty ? ' $trailing' : ''}';
  }
}
