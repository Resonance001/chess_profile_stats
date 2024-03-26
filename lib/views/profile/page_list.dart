import 'package:flutter/material.dart' hide Page;

import 'package:chess/models/data/puzzle_data.dart';
import 'package:chess/models/data/segment_data.dart';
import 'package:chess/models/data/user_data.dart';
import 'package:chess/models/provider/data_provider.dart';
import 'package:chess/views/profile/page.dart';
import 'package:collection/collection.dart';

class PageList {
  PageList({required this.data});

  final DataModel data;

  List<Page> getPages() {
    final userData = IterableZip([
      userLines(data.userData),
      userIcons(data.userData),
    ]);

    final segmentData = <IterableZip<Object>>[
      for (final value in TimeControl.values)
        IterableZip(
          [
            segmentLines(data.performance[value]!),
            segmentIcons(data, value),
          ],
        ),
    ];

    final puzzleData = IterableZip([
      puzzleLines(data.userData),
      puzzleIcons,
    ]);

    return <Page>[
      for (final pair in userData)
        Page(texts: pair[0] as List<List<String>>, icon: pair[1] as Widget),
      for (final segment in segmentData)
        for (final pair in segment)
          Page(texts: pair[0] as List<List<String>>, icon: pair[1] as Widget),
      for (final pair in puzzleData)
        Page(texts: pair[0] as List<List<String>>, icon: pair[1] as Widget),
    ];
  }

  List<int> getPartition() {
    final partition = <int>[];
    partition
      ..add(0)
      ..add(partition.last + userIcons(data.userData).length)
      ..add(partition.last + segmentIcons(data, TimeControl.bullet).length)
      ..add(partition.last + segmentIcons(data, TimeControl.blitz).length)
      ..add(partition.last + segmentIcons(data, TimeControl.rapid).length)
      ..add(partition.last + puzzleIcons.length)
      ..first -= 1
      ..last += 1;
    return partition;
  }
}
