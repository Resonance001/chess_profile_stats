import 'package:flutter/material.dart';

const label = <String>[
  'Intro',
  'Bullet',
  'Blitz',
  'Rapid',
  'Puzzles',
];

const size = 24.0;

final icon = <Widget>[
  const Icon(Icons.home),
  Image.asset(
    'assets/images/activity.lichess-bullet.webp',
    height: size,
    width: size,
  ),
  Image.asset(
    'assets/images/activity.lichess-blitz.webp',
    height: size,
    width: size,
  ),
  Image.asset(
    'assets/images/activity.lichess-rapid.webp',
    height: size,
    width: size,
  ),
  Image.asset(
    'assets/images/activity.puzzle-piece.webp',
    height: size,
    width: size,
  ),
];
