import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/app/app.router.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/shared_preferences_service.dart';

class PhoneAuthViewModel extends BaseViewModel {
  int start = 30;
  String sendButtonName = 'Send';
  bool otpSent = false;
  final _snackbarService = locator<SnackbarService>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _sharedPreferences = locator<SharedPreferencesService>();
  String pin = '';

  void setPin(String otp) {
    pin = otp;
    notifyListeners();
  }

  void startTimer() {
    sendButtonName = "Resend";
    otpSent = true;
    notifyListeners();
    const onsec = Duration(seconds: 1);
    Timer.periodic(onsec, (timer) {
      if(start == 0) {
        timer.cancel();
        start = 30;
        otpSent = false;
        notifyListeners();
      }
      else {
        start--;
        notifyListeners();
      }
    });
  }

  void verFailed(FirebaseAuthException e) {
    print('inside verfailed of otpvoewmodel, exception = $e');
    if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
      _snackbarService.showSnackbar(message: e.toString());
    } else {
      print('The error for FirebaseAuth: code = ${e.code}, msg = ${e.message!}');
      _snackbarService.showSnackbar(message: e.toString());
    }
  }

  Future<void> verCompleted() async {
    try {
      _sharedPreferences.token = await _authService.auth.currentUser?.getIdToken();
      await _navigationService.clearStackAndShow(Routes.homeView);
    }
    catch(err) {
      _snackbarService.showSnackbar(message: err.toString());
    }
  }

  Future<void> verifyPhoneNumber(String phNumber) async {
    try {
      await _authService.verifyPhone('+91 $phNumber', verFailed, verCompleted);
    }
    catch(err) {
      _snackbarService.showSnackbar(message: err.toString());
    }
  }

  Future<void> verifyOtpOnSubmit() async {
    String smsCode = pin;

    if (smsCode.length != 6) {
      _snackbarService.showSnackbar(message: 'Invalid OTP');
    } else {
      try {
        notifyListeners();
        await _authService.verifyOTP(smsCode);
      } catch (e) {
        notifyListeners();
        debugPrint('The error for FirebaseAuth: msg - $e');
        _snackbarService.showSnackbar(message: e.toString());
        return;
      }
      return verCompleted();
    }
  }
}