import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_app/main.dart';

class Signin extends StatefulWidget {
 Signin({Key? key}) : super(key: key);

  @override
   SigninState createState() =>  SigninState();
}

class  SigninState extends State <Signin> {

bool isSignedIn = false;

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
            onTap: () => "Toc Toc",
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