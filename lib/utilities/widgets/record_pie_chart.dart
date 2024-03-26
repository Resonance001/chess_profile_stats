import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:chess/utilities/widgets/record_pie_chart/pie_chart_label.dart';
import 'package:chess/utilities/widgets/record_pie_chart/percentage_calculator.dart';

class RecordChart extends StatefulWidget {
  const RecordChart({
    required this.wins,
    required this.draws,
    required this.losses,
    super.key,
  });

  final int wins;
  final int draws;
  final int losses;

  @override
  State<RecordChart> createState() => _RecordChartState();
}

class _RecordChartState extends State<RecordChart> {
  int touchedIndex = -1;

  late double winPercentage;
  late double drawPercentage;
  late double lossPercentage;

  static const slices = <String, Color>{
    'Wins': Color(0xff3dfffc),
    'Draws': Color(0xffa6c646),
    'Losses': Color(0xffff4f38),
  };

  @override
  void initState() {
    super.initState();
    final calculator = PercentageCalculator(
      wins: widget.wins,
      draws: widget.draws,
      losses: widget.losses,
    );
    winPercentage = calculator.winPercentage;
    drawPercentage = calculator.drawPercentage;
    lossPercentage = calculator.lossPercentage;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                mainData(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Wrap(
            direction: Axis.vertical,
            spacing: 4,
            children: <Widget>[
              for (final slice in slices.entries)
                ChartLabel(text: slice.key, color: slice.value),
            ],
          ),
        ],
      ),
    );
  }

  PieChartData mainData() {
    return PieChartData(
      pieTouchData: PieTouchData(
        touchCallback: (FlTouchEvent event, pieTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                pieTouchResponse == null ||
                pieTouchResponse.touchedSection == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
          });
        },
      ),
      borderData: FlBorderData(show: false),
      sectionsSpace: 0,
      centerSpaceRadius: double.infinity,
      sections: sections(),
    );
  }

  List<PieChartSectionData> sections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;

      final radius = isTouched ? 80.0 : 70.0;

      final titleStyle = TextStyle(
        fontSize: isTouched ? 14.0 : 12.0,
        fontWeight: FontWeight.bold,
        shadows: const <Shadow>[
          Shadow(
            color: Colors.black,
            blurRadius: 2,
          ),
        ],
      );

      switch (i) {
        case 1:
          return PieChartSectionData(
            color: slices['Wins'],
            value: widget.wins.toDouble(),
            title: '$winPercentage%',
            radius: radius,
            titleStyle: titleStyle,
          );
        case 2:
          return PieChartSectionData(
            color: slices['Draws'],
            value: widget.draws.toDouble(),
            title: '$drawPercentage%',
            radius: radius,
            titleStyle: titleStyle,
          );
        case 0:
          return PieChartSectionData(
            color: slices['Losses'],
            value: widget.losses.toDouble(),
            title: '$lossPercentage%',
            radius: radius,
            titleStyle: titleStyle,
          );
        default:
          throw Exception('Section does not exist');
      }
    });
  }
}
