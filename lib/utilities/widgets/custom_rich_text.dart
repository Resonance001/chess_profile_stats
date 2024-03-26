import 'package:flutter/material.dart';

import 'package:chess/constants/breakpoints.dart';
import 'package:chess/models/provider/breakpoint_provider.dart';
import 'package:provider/provider.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    required this.lines,
    super.key,
  });

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    final theme = switch (context.watch<DeviceState>().windowSize) {
      WindowSize.extended => Theme.of(context).textTheme.bodyMedium,
      WindowSize.medium => Theme.of(context).textTheme.bodySmall,
      WindowSize.compact => Theme.of(context).textTheme.bodySmall,
    };

    return RichText(
      maxLines: 5,
      textAlign: TextAlign.center,
      text: TextSpan(
        style: theme,
        children: List.generate(
          lines.length,
          (index) => TextSpan(
            text: lines[index],
            style: index.isOdd
                ? theme?.copyWith(fontWeight: FontWeight.bold)
                : null,
          ),
        ),
      ),
    );
  }
}
