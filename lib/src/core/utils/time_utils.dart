class TimeUtils {
  static String getTimeInHMS({int? milliseconds, int? seconds}) {
    int totalSeconds = (milliseconds != null) ? (milliseconds ~/ 1000) : (seconds ?? 0);

    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int remainingSeconds = totalSeconds % 60;

    List<String> parts = [];

    if (hours > 0) {
      parts.add('${hours}h');
    }
    if (minutes > 0) {
      parts.add('${minutes}m');
    }
    if (remainingSeconds > 0 || parts.isEmpty) {
      parts.add('${remainingSeconds}s');
    }

    return parts.join(' ');
  }

  static String getTime(
    Duration duration, {
    int padLeft = 1,
    bool showSuffix = true,
    bool showMilliseconds = false,
    bool showMinutes = true,
    bool showSeconds = true,
  }) {
    int years = duration.inDays ~/ 365;
    int days = duration.inDays % 365;
    int hours = duration.inHours % 24;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);
    int milliseconds = duration.inMilliseconds - (duration.inSeconds * 1000);

    // Adjust for edge cases
    if (seconds == 60) {
      seconds = 0;
      minutes += 1;
    }
    if (minutes == 60) {
      minutes = 0;
      hours += 1;
    }
    if (hours == 24) {
      hours = 0;
      days += 1;
    }
    if (days == 365) {
      days = 0;
      years += 1;
    }

    final parts = [
      if (years > 0) "${padTime(years, padLeft)}${showSuffix ? " yr" : ":"}",
      if (days > 0 || (years > 0 && !showSuffix)) "${padTime(days, padLeft)}${showSuffix ? " day" : ":"}",
      if (hours > 0 || (days > 0 && !showSuffix)) "${padTime(hours, padLeft)}${showSuffix ? " hr" : ":"}",
      if (showMinutes && (minutes > 0 || (hours > 0 && !showSuffix))) "${padTime(minutes, padLeft)}${showSuffix ? " min" : ":"}",
      if (showSeconds && (seconds > 0 || minutes > 0)) "${padTime(seconds, padLeft)}${showSuffix ? " sec" : ""}",
      if (showMilliseconds) ":${(padTime(milliseconds, 2)).substring(0, 2)}",
    ];

    return parts.join(
      showSuffix //
          ? ' '
          : '',
    );
  }

  static String padTime(int value, int padLeft) {
    return value.toString().padLeft(padLeft, "0");
  }

  static String formatDate(DateTime date, bool isImperial) {
    final yearShort = date.year.toString().substring(2);

    if (isImperial) {
      return "${date.month}/${date.day}/$yearShort";
    }

    return "${date.day}/${date.month}/$yearShort";
  }

  static String calculateAge(DateTime birthDate, {String? suffix}) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }

    double daysNorm = (currentDate.difference(birthDate).inDays % 365) / 365;

    int days = (daysNorm * 365).toInt();

    int decimalAge = age;

    String suffixText = suffix != null ? " $suffix" : "";

    return "${decimalAge != 0 ? ("$decimalAge years & ") : ""}$days days$suffixText";
  }
}
