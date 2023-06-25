import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/services/shared_preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _sharedPreferences = locator<SharedPreferencesService>();

  Future<UserCredential> signupWithEmailAndPassword(String email, String password) async {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential?> googleSignIn() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    if(googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );

      UserCredential user = await _auth.signInWithCredential(credential);
      return user;
    }
    return null;
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
    await _sharedPreferences.clearData();
  }

}