import 'dart:async';

import 'package:stacked/stacked.dart';

class PhoneAuthViewModel extends BaseViewModel {
  int start = 10;
  String sendButtonName = 'Send';
  bool otpSent = false;
  void startTimer() {
    sendButtonName = "Resend";
    otpSent = true;
    notifyListeners();
    const onsec = Duration(seconds: 1);
    Timer.periodic(onsec, (timer) {
      if(start == 0) {
        timer.cancel();
        start = 10;
        otpSent = false;
        notifyListeners();
      }
      else {
        start--;
        notifyListeners();
      }
    });
  }
}