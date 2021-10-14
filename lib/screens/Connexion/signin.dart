import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_app/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn gSignIn = GoogleSignIn();

class Signin extends StatefulWidget {
 Signin({Key? key}) : super(key: key);

  @override
   SigninState createState() =>  SigninState();
}

class  SigninState extends State <Signin> {

bool isSignedIn = false;

void initState() {
  super.initState();

  gSignIn.onCurrentUserChanged.listen((gSigninAccount) {
    ControlSignIn(gSigninAccount!);
   }, onError: (gError) {
     print('Not sign in' + gError.message);
   });

   gSignIn.signInSilently(suppressErrors: false).then((gSignInAccount) {
     ControlSignIn(gSignInAccount!);
     } ).catchError;
}

ControlSignIn(GoogleSignInAccount signInAccount) async {
  if (signInAccount != null) {
     setState(() {
       isSignedIn = true;
     });
  }
  else {
    isSignedIn = false;
  }
}

loginUser() {
gSignIn.signIn();
}

logOutUser() {
  gSignIn.signOut();
}

Widget buildScreen() {
  return Text('Already signed in');
}

Scaffold buildSignInScreen() {
  return Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Text('Welcome to Tasky !', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, fontFamily: "Signatra")),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () => loginUser,
            child: Container(
              width: 270,
              height: 55,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage('assets/images/gs.png'),
                  fit: BoxFit.cover,
                )
              )
            )
          )
        ]
      ),
    )
  );
}

  @override
  Widget build(BuildContext context) {
    if(isSignedIn) {
      return MyApp();
    }

    else {
      return buildSignInScreen();
    }
  }
}