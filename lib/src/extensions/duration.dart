extension DurationExtension on Duration {
  String get format {
    if (inHours > 0) {
      return formatHMS;
    }

    return formatMS;
  }

  /// Returns HH:mm:ss
  String get formatHMS {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = (inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  /// Returns HH:mm
  String get formatHM {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = (inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  /// Returns mm:ss
  String get formatMS {
    final minutes = inMinutes.toString().padLeft(2, '0');
    final seconds = (inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
