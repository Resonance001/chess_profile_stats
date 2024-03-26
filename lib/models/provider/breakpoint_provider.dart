import 'package:flutter/material.dart';

import 'package:chess/constants/breakpoints.dart';

class DeviceState extends ChangeNotifier {
  WindowSize _windowSize = WindowSize.compact;

  WindowSize get windowSize => _windowSize;

  set windowSize(WindowSize device) {
    if (_windowSize != device) {
      _windowSize = device;
      notifyListeners();
    }
  }
}
