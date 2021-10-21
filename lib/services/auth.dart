import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  BaseUser? _userFromFirebaseUser(User? user) {
    return user != null ? BaseUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<BaseUser?> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //signup
  signUp(
      String _email, String _password, String _name, Function showError) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      await _auth.currentUser!.updateDisplayName(_name);

      User? user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData(_name, 'Parent', "+225 01 02 03 04 05");
      return _userFromFirebaseUser(user);
    } catch (e) {
      showError(e.toString());
      return null;
    }
  }

  //signing out
  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}
