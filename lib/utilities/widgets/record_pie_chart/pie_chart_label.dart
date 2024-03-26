import 'package:flutter/material.dart';

class ChartLabel extends StatelessWidget {
  const ChartLabel({
    required this.text,
    required this.color,
    super.key,
  });
  final String text;
  final Color color;

  static const _iconSize = 16.0;
  static const _spacing = 4.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: _iconSize,
          height: _iconSize,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
          ),
        ),
        const SizedBox(
          width: _spacing,
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
