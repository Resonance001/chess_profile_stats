import 'package:flutter/material.dart';

import 'package:chess/models/api/user_data_model.dart' hide TimeControl;

List<List<List<String>>> puzzleLines(UserData data) => [
      [
        ['You have completed ', '${data.perfs.puzzle.games}', ' puzzles!'],
        if (data.perfs.puzzle.games > 0)
          ['You are rated ', '${data.perfs.puzzle.rating}']
        else
          ['You are unrated.'],
      ],
      [
        [
          'You have attempted Puzzle Streak around ',
          '${data.perfs.streak.runs}',
          ' times.',
        ],
        ['Your highest streak is ', '${data.perfs.streak.score}', '.'],
      ],
      [
        [
          'You have cruised through Puzzle Storm around ',
          '${data.perfs.storm.runs}',
          ' times.',
        ],
        ['Your best result is ', '${data.perfs.storm.score}', '.'],
      ],
      [
        [
          'You have raced with others in Puzzle Racer around ',
          '${data.perfs.racer.runs}',
          ' times.',
        ],
        ['Your highest score is ', '${data.perfs.racer.score}', '.'],
      ]
    ];

const List<Widget> puzzleIcons = [
  Icon(Icons.extension),
  Icon(Icons.query_stats),
  Icon(Icons.thunderstorm),
  Icon(Icons.rocket_launch),
];
