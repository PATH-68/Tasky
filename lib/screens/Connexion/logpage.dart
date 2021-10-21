import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Logs extends StatefulWidget {
  const Logs({Key? key}) : super(key: key);

  @override
  LogsState createState() => LogsState();
}

class LogsState extends State<Logs> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else {
      throw StateError('Sign in Aborted');
    }
  }

  navigateToLogin() async {
    Navigator.pushNamed(context, "signin");
  }

  navigateToRegister() async {
    Navigator.pushNamed(context, "signup");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Welcome to Tasky !',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 45,
              fontFamily: "Signatra")),
      const SizedBox(height: 80),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: navigateToLogin,
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: const Text('LOGIN',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.black,
          ),
          const SizedBox(width: 15),
          RaisedButton(
            onPressed: navigateToRegister,
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: const Text('REGISTER',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.black,
          ),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        const SizedBox(height: 30),
        SignInButton(
          Buttons.Google,
          // padding: EdgeInsets.all(5),
          text: "Sign up with Google",
          onPressed: googleSignIn,
        ),
        const SizedBox(height: 20),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        const SizedBox(height: 30),

        // Container(

        SignInButton(
          Buttons.Apple,
          mini: true,
          // padding: EdgeInsets.all(5),
          text: "Sign up with Google",
          onPressed: googleSignIn,
        ),
        const SizedBox(width: 10),

        SignInButton(
          Buttons.LinkedIn,
          mini: true,
          // padding: EdgeInsets.all(5),
          text: "Sign up with Google",
          onPressed: googleSignIn,
        ),
        const SizedBox(width: 10),

        SignInButton(
          Buttons.GitHub,
          mini: true,
          // padding: EdgeInsets.all(5),
          text: "Sign up with Google",
          onPressed: googleSignIn,
        ),
        const SizedBox(width: 10),

        SignInButton(
          Buttons.Facebook,
          mini: true,
          // padding: EdgeInsets.all(5),
          text: "Sign up with Google",
          onPressed: googleSignIn,
        ),
        const SizedBox(width: 10),

        SignInButton(
          Buttons.Twitter,
          mini: true,
          // padding: EdgeInsets.all(5),
          text: "Sign up with Google",
          onPressed: googleSignIn,
        ),
        const SizedBox(width: 10),
      ])
    ])));
  }
}
