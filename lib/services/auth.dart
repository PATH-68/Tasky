import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/models/user.dart';

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
}
