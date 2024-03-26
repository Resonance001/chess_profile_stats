import 'package:intl/intl.dart';

class DateConverter {
  DateConverter({
    int joinDate = 0,
    int lastOnline = 0,
    int playTime = 0,
  })  : _joinDate = joinDate,
        _lastOnline = lastOnline,
        _playTime = playTime;

  final int _joinDate;
  final int _lastOnline;
  final int _playTime;

  String get joinDate {
    final joined = DateTime.fromMillisecondsSinceEpoch(_joinDate);
    return DateFormat.yMMMMd().format(joined);
  }

  String get lastOnline {
    final last = DateTime.fromMillisecondsSinceEpoch(_lastOnline);

    final diff = DateTime.now().difference(last);
    final hours = diff.inHours;
    final minutes = diff.inMinutes - hours * 60;
    final seconds = diff.inSeconds - hours * 3600 - minutes * 60;

    var hour = '', minute = '', second = '';

    if (hours > 0) {
      hour = hours == 1 ? '$hours hour, ' : '$hours hours, ';
    }
    if (minutes > 0) {
      minute = minutes == 1 ? '$minutes minute, ' : '$minutes minutes, ';
    }
    if (seconds > 0) {
      second = seconds == 1 ? '$seconds second' : '$seconds seconds';
    }
    return '$hour$minute$second ago';
  }

  String get playTime {
    final seconds = Duration(seconds: _playTime);

    final days = seconds.inDays;
    final hours = seconds.inHours % Duration.hoursPerDay;
    final minutes = seconds.inMinutes % Duration.minutesPerHour;

    var day = '', hour = '', minute = '';

    if (days > 0) {
      day = days == 1 ? '$days day, ' : '$days days, ';
    }
    if (hours > 0) {
      hour = hours == 1 ? '$hours hour, ' : '$hours hours, ';
    }
    if (minutes > 0) {
      minute = minutes == 1 ? '$minutes minute' : '$minutes minutes';
    }
    return '$day$hour$minute';
  }
}
