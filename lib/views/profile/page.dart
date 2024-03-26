import 'package:flutter/material.dart';

import 'package:chess/constants/breakpoints.dart';
import 'package:chess/models/provider/breakpoint_provider.dart';
import 'package:chess/utilities/widgets/custom_rich_text.dart';
import 'package:provider/provider.dart';

class Page extends StatelessWidget {
  const Page({required this.texts, required this.icon, super.key});

  final List<List<String>> texts;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final windowSize = Provider.of<DeviceState>(context).windowSize;

    final padding = switch (windowSize) {
      WindowSize.extended => const EdgeInsets.fromLTRB(30, 120, 30, 120),
      WindowSize.medium => const EdgeInsets.fromLTRB(60, 60, 60, 60),
      WindowSize.compact => const EdgeInsets.fromLTRB(30, 60, 30, 60),
    };

    return Padding(
      padding: padding,
      child: windowSize == WindowSize.extended
          ? Row(
              children: <Widget>[
                Expanded(
                  child: _IconImage(icon: icon),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: _TextBody(lines: texts),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                const Spacer(),
                _IconImage(icon: icon),
                const Spacer(),
                _TextBody(lines: texts),
                const Spacer(),
              ],
            ),
    );
  }
}

class _IconImage extends StatelessWidget {
  const _IconImage({required this.icon});

  final Widget icon;

  static const _iconSize = 200.0;

  @override
  Widget build(BuildContext context) {
    final windowSize = Provider.of<DeviceState>(context).windowSize;

    return icon is Icon
        ? SizedBox(
            height: _iconSize,
            width: _iconSize,
            child: FittedBox(child: icon),
          )
        : windowSize == WindowSize.extended
            ? SizedBox.expand(child: icon)
            : SizedBox(height: _iconSize, width: double.infinity, child: icon);
  }
}

class _TextBody extends StatelessWidget {
  const _TextBody({required this.lines});

  final List<List<String>> lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (final line in lines)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CustomRichText(lines: line),
          ),
      ],
    );
  }
}
