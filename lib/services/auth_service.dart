import 'package:flutter/cupertino.dart';
import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/services/shared_preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  String? _verificationId;
  int? _resendToken;

  UserCredential? _userCredential;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _sharedPreferences = locator<SharedPreferencesService>();

  AuthService() {
    auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        debugPrint('User is signed out!');
        _sharedPreferences.uid = null;
      } else {
        debugPrint('User got changed');
        _sharedPreferences.uid = user.uid;
      }
    });
  }

  Future<UserCredential> signupWithEmailAndPassword(String email, String password) async {
      return await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    return await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential?> googleSignIn() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    if(googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );

      UserCredential user = await auth.signInWithCredential(credential);
      return user;
    }
    return null;
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
    await _sharedPreferences.clearData();
  }

  Future<void> verifyPhone(String phNumber, Function verFailed, Function verCompleted) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '$phNumber',
      forceResendingToken: _resendToken,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        _userCredential = await auth.signInWithCredential(credential);
        return verCompleted();
      },
      verificationFailed: (FirebaseAuthException e) => verFailed(e),
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        _resendToken = resendToken;
      },
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  Future<void> verifyOTP(String smsCode) async {
    if (_verificationId == null) {
      return Future.error("Please try again after sometime");
    }
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: smsCode);
    // Sign the user in (or link) with the credential
    _userCredential = await auth.signInWithCredential(phoneAuthCredential);
  }

}