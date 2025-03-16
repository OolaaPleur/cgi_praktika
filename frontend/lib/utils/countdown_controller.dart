import 'dart:async';

import 'package:flutter/material.dart';

class CountdownController extends ChangeNotifier {
  int _secondsLeft = 3;
  Timer? _timer;
  VoidCallback? _onFinish;

  int get secondsLeft => _secondsLeft;

  void startCountdown(int duration, VoidCallback onFinish) {
    _secondsLeft = duration;
    _onFinish = onFinish;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 1) {
        _secondsLeft--;
        notifyListeners(); // Notify UI that time has been updated
      } else {
        timer.cancel();
        _onFinish?.call();
      }
    });

    notifyListeners(); // Notify that the timer has started
  }

  void cancelCountdown() {
    _timer?.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
