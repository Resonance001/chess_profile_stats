import 'package:chess/models/models_api.dart';

enum TimeControl {
  bullet,
  blitz,
  rapid,
}

class DataModel {
  late UserData userData;
  Map<TimeControl, RatingHistory> ratingHistory = {};
  Map<TimeControl, PerformanceStat> performance = {};
}
