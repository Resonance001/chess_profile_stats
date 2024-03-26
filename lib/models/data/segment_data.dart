import 'package:flutter/material.dart';

import 'package:chess/models/api/performance_stat_model.dart';
import 'package:chess/models/provider/data_provider.dart';
import 'package:chess/utilities/widgets/progress_line_chart.dart';
import 'package:chess/utilities/widgets/record_pie_chart.dart';

import 'package:intl/intl.dart';

List<List<List<String>>> segmentLines(PerformanceStat perf) {
  final type = perf.stat.perfType.name;

  var rating = perf.perf.glicko.rating.floor().toString();
  
  final provisional = perf.perf.glicko.provisional;
  if (provisional) rating = '$rating?';

  final rank = perf.rank;
  final suffix = switch (rank % 10) {
    1 => 'st',
    2 => 'nd',
    3 => 'rd',
    _ => 'th',
  };

  final percentile = perf.percentile.toString();

  final games = <String, int>{
    'all': perf.stat.count.all,
    'win': perf.stat.count.win,
    'draw': perf.stat.count.draw,
    'loss': perf.stat.count.loss,
  };

  final hasBestWin = perf.stat.bestWins.results.isNotEmpty;

  final bestWin = hasBestWin
      ? {
          'name': perf.stat.bestWins.results[0].opId.name,
          'rating': perf.stat.bestWins.results[0].opRating.toString(),
          'date': DateFormat(DateFormat.YEAR_MONTH_DAY)
              .format(perf.stat.bestWins.results[0].at),
        }
      : <String, String>{};

  final highest = perf.stat.highest.estInt.toString();

  var highestDate = perf.stat.highest.at.toString();
  if (highestDate != 'null') {
    highestDate = DateFormat(DateFormat.YEAR_MONTH_DAY)
        .format(DateTime.parse(highestDate));
  }

  final currWinStreak = perf.stat.resultStreak.win.cur.v.toString();
  final maxWinStreak = perf.stat.resultStreak.win.max.v.toString();

  final currLossStreak = perf.stat.resultStreak.loss.cur.v.toString();
  final maxLossStreak = perf.stat.resultStreak.loss.max.v.toString();

  return [
    [
      ["Let's check out your performance in the ", type, ' segment.'],
      ['Your ', type, ' rating is ', rating, '.'],
    ],
    if (rank > 0)
      [
        ['You are ranked ', '$rank$suffix', ' in the world.'],
        ['You are better than ', percentile, '% of the players!'],
      ]
    else
      [
        ['Looks like you have not played enough games'],
        ['Play more ', type, ' games to get into the leaderboard!'],
      ],
    if (highest != '0')
      [
        ['Your highest rating is ', highest, '.'],
        ['You achieved this on ', highestDate],
      ]
    else
      [
        ['Unfortunately, we cannot tell your highest rating'],
        ['Keep playing ', type, ' games to get one'],
      ],
    if (games['all']! > 0)
      [
        ['You have played ', '${games["all"]}', ' games.'],
        [
          "You've won ",
          (100 * games['win']! ~/ games['all']!).toString(),
          '% of them!',
        ],
      ]
    else
      [
        ['You have no record of ', type, ' games in the database.'],
      ],
    [
      ['Explore your rating progress in ', type, ' over a time period.'],
    ],
    if (hasBestWin)
      [
        [
          'Your best win was against ',
          bestWin['name']!,
          ' in ${bestWin["date"]}.',
        ],
        ['Your opponent was rated ', bestWin['rating']!, ' back then!'],
      ]
    else
      [
        if (games['all']! > 0)
          ["You haven't won a ", type, ' game yet']
        else
          [
            "Can't have a best win if you haven't played a ",
            type,
            ' game yet!',
          ],
        [
          'Play a ',
          type,
          ' game now to see the strongest opponent you can beat',
        ]
      ],
    [
      ['Your current win streak is ', currWinStreak, '.'],
      ['Your max win streak is ', maxWinStreak, '.'],
    ],
    [
      ['Your current lose streak is ', currLossStreak, '.'],
      ['Your max lose streak is ', maxLossStreak, '.'],
    ],
  ];
}

List<Widget> segmentIcons(DataModel data, TimeControl timeControl) {
  final wins = data.performance[timeControl]!.stat.count.win;
  final draws = data.performance[timeControl]!.stat.count.draw;
  final losses = data.performance[timeControl]!.stat.count.loss;

  return [
    switch (timeControl) {
      TimeControl.bullet => const Icon(Icons.flash_on_sharp),
      TimeControl.blitz => const Icon(Icons.electric_bolt),
      TimeControl.rapid => const Icon(Icons.timer),
    },
    const Icon(Icons.travel_explore),
    const Icon(Icons.terrain),
    if (wins + draws + losses > 0)
      RecordChart(wins: wins, draws: draws, losses: losses)
    else
      const Icon(Icons.home),
    ProgressChart(points: data.ratingHistory[timeControl]?.points ?? []),
    const Icon(Icons.gavel),
    const Icon(Icons.fireplace),
    const Icon(Icons.severe_cold),
  ];
}
