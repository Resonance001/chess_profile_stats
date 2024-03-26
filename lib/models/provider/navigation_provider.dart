import 'package:flutter/material.dart';

enum Calendar {
  threeMonths,
  sixMonths,
  oneYear,
}

extension CalendarExtension on Calendar {
  int get backDate => switch (this) {
        Calendar.threeMonths => 3,
        Calendar.sixMonths => 6,
        Calendar.oneYear => 12,
      };
  String get label => switch (this) {
        Calendar.threeMonths => 'past 3 months',
        Calendar.sixMonths => 'past six months',
        Calendar.oneYear => 'past year',
      };

  IconData get icon => switch (this) {
        Calendar.threeMonths => Icons.calendar_view_day,
        Calendar.sixMonths => Icons.calendar_view_week,
        Calendar.oneYear => Icons.calendar_view_month,
      };
}

class NavigationState extends ChangeNotifier {
  int _currDestination = 0;

  int get currDestination => _currDestination;

  set currDestination(int destination) {
    if (_currDestination != destination) {
      _currDestination = destination;
      notifyListeners();
    }
  }

  void resetDestination() => _currDestination = 0;

  bool _isDestinationChanged = false;

  bool get destinationChanged => _isDestinationChanged;

  void toggleSelection() {
    _isDestinationChanged = !_isDestinationChanged;
    if (_isDestinationChanged) {
      notifyListeners();
    }
  }

  Calendar _calendar = Calendar.values[0];

  Calendar get calendar => _calendar;

  set calendar(Calendar calendar) {
    if (_calendar != calendar) {
      _calendar = calendar;
      notifyListeners();
    }
  }
}
