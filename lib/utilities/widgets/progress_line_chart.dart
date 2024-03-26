import 'package:chess/models/provider/navigation_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chess/utilities/widgets/progress_line_chart/calendar_selector.dart';
import 'package:chess/utilities/widgets/progress_line_chart/line_chart_details.dart';

class ProgressChart extends StatefulWidget {
  const ProgressChart({required this.points, super.key});

  final List<List<int>> points;

  @override
  State<ProgressChart> createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  static const _gradientColors = <Color>[
    Color(0xFF50E4FF),
    Color(0xFF2196F3),
  ];

  final _chartDetails = <Calendar, ChartDetails>{};
  Map<int, String> _bottomTitle = {};

  @override
  void initState() {
    super.initState();
    for (final value in Calendar.values) {
      _chartDetails[value] =
          ChartDetails(calendar: value, points: widget.points);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CalendarSelector(),
        const SizedBox(height: 10),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.7,
            child: Selector<NavigationState, Calendar>(
              selector: (_, provider) => provider.calendar,
              builder: (context, calendar, child) {
                final chartDetail = _chartDetails[calendar]!;
                _bottomTitle = chartDetail.bottomTitle;

                return LineChart(
                  mainData(chartDetail),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(ChartDetails chartDetail) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: null,
        verticalInterval: null,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: 50,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 1,
      maxX: chartDetail.totalDays.toDouble(),
      minY: chartDetail.minRating.toDouble(),
      maxY: chartDetail.maxRating.toDouble(),
      lineBarsData: <LineChartBarData>[
        LineChartBarData(
          spots: chartDetail.spots,
          isCurved: true,
          gradient: const LinearGradient(colors: _gradientColors),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: _gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    final text = _bottomTitle.containsKey(value) ? _bottomTitle[value]! : '';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );

    return Text('$value', style: style, textAlign: TextAlign.left);
  }
}
