import 'package:fl_chart/fl_chart.dart';
import 'package:chess/models/provider/navigation_provider.dart';

class ChartDetails {
  ChartDetails({
    required this.calendar,
    required this.points,
  }) {
    initializeDetails();
  }

  List<List<int>> points;
  Calendar calendar;

  int totalDays = 0;
  int minRating = 3500;
  int maxRating = 600;
  List<FlSpot> spots = [];
  Map<int, String> bottomTitle = {};

  static const _months = <String>[
    'DEC',
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];

  void initializeDetails() {
    final backDate = calendar.backDate;
    final now = DateTime.now();
    final initialDate = DateTime(now.year, now.month - backDate, now.day);

    if (points.isEmpty) {
      minRating = 1350;
      maxRating = 1550;
      spots
        ..add(const FlSpot(0, 1500))
        ..add(const FlSpot(1, 1500));
      return;
    }
    // Find the minimum date just after the starting date
    var left = 0;
    var right = points.length - 1;
    while (left < right) {
      final mid = (left + right) >> 1;

      // DateTime uses 1-12 month format while JSON data uses 0-11 month format
      final thisDate =
          DateTime(points[mid][0], points[mid][1] + 1, points[mid][2]);
      if (thisDate.isAfter(initialDate)) {
        right = mid;
      } else {
        left = mid + 1;
      }
    }
    final subPoints = points.sublist(left);

    var offset = -subPoints[0][2] + 1; // initial value shifts date to day 1

    var previousMonth = subPoints[0][1] + 1;
    var previousDay = subPoints[0][2] + offset - 1;
    var previousRating = subPoints[0][3];
    var daysInPreviousMonth =
        DateTime(subPoints[0][0], previousMonth + 1, 0).day;

    var latestBreak = 0;

    for (final point in subPoints) {
      final currentYear = point[0];
      final currentMonth = point[1] + 1;
      var currentDay = point[2];
      final currentRating = point[3];

      // if month changes, increase offset by days in previous month
      if (currentMonth != previousMonth) {
        offset += daysInPreviousMonth;
        previousMonth = currentMonth;
        daysInPreviousMonth = DateTime(currentYear, currentMonth + 1, 0).day;

        final average = (latestBreak + offset - 1) ~/ 2;
        bottomTitle[average] = _months[currentMonth - 1];
        latestBreak = offset - 1;
      }
      previousDay++;
      currentDay += offset;

      while (previousDay != currentDay) { 
        // if there are days skipped, add spots accordingly
        spots.add(FlSpot(previousDay.toDouble(), previousRating.toDouble()));
        previousDay++;
      }
      spots.add(FlSpot(currentDay.toDouble(), currentRating.toDouble()));

      previousDay = currentDay;
      previousRating = currentRating;
      minRating = currentRating < minRating ? currentRating : minRating;
      maxRating = currentRating > maxRating ? currentRating : maxRating;
    }
    totalDays = spots.length;

    minRating -= (maxRating - minRating) ~/ 2;
    minRating -= minRating % 50;
    maxRating += 50 - maxRating % 50;

    if (totalDays - latestBreak >= 10) {
      final average = (latestBreak + totalDays) ~/ 2;
      bottomTitle[average] = _months[previousMonth];
      latestBreak = 0;
    }

    if (calendar == Calendar.oneYear) {
      var currIndex = 0;
      final keys = <int>[];

      bottomTitle
        ..forEach((key, value) {
          if (currIndex.isOdd) {
            keys.add(key);
          }
          currIndex++;
        })
        ..removeWhere((key, value) => keys.contains(key));
    }
  }
}
