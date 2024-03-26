import 'package:flutter/material.dart';

import 'package:chess/models/api/user_data_model.dart' hide TimeControl;
import 'package:chess/utilities/epoch_converter.dart';
import 'package:chess/utilities/widgets/record_pie_chart.dart';

List<List<List<String>>> userLines(UserData data) {
  final date = DateConverter(playTime: data.playTime.total);

  final joined = DateTime.fromMillisecondsSinceEpoch(data.createdAt);

  final currDate = DateTime.now();
  final daysSinceJoined = currDate.difference(joined).inDays;

  return [
    [
      ['Welcome ', data.username, ' !'],
    ],
    [
      ["Let's take a look at your profile."],
    ],
    if (data.count['all']! > 0)
      [
        [
          'You have played a total of ',
          data.count['all']!.toString(),
          ' games.',
        ],
        [
          'You have won ',
          (100 * data.count['winH']! ~/ data.count['all']!).toString(),
          '% of them',
        ],
      ]
    else
      [
        ["You haven't played any games yet."],
      ],
    [
      if (date.playTime.isNotEmpty)
        ['You have spent a total of ', date.playTime, ' on Lichess!']
      else
        ['You have not spent any time playing on Lichess.'],
    ],
    [
      [
        'It has been ',
        daysSinceJoined.toString(),
        ' days since you joined Lichess',
      ]
    ]
  ];
}

List<Widget> userIcons(UserData data) {
  return [
    const Icon(Icons.switch_account),
    const Icon(Icons.menu_book),
    if (data.count['all']! > 0)
      RecordChart(
        wins: data.count['win']!,
        draws: data.count['draw']!,
        losses: data.count['loss']!,
      )
    else
      const Icon(Icons.home),
    const Icon(Icons.hourglass_bottom),
    const Icon(Icons.history_edu),
  ];
}
