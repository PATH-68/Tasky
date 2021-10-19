import 'package:flutter/material.dart';
import 'package:task_app/screens/home/widgets/tasks.dart';
import 'package:task_app/screens/home/widgets/topcard.dart';
import 'package:task_app/screens/Connexion/logpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:authentification/Start.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("logpage");
      }
    });
  }

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        user = firebaseUser!;
        isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    checkAuthentification();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Container(
      child: !isloggedin
          ? CircularProgressIndicator()
          // : Column(
          //     children: <Widget>[
          //       SizedBox(height: 40.0),
          //       Container(
          //         height: 300,
          //         child: Image(
          //           image: AssetImage("assets/images/avatar.png"),
          //           fit: BoxFit.contain,
          //         ),
          //       ),
          
      : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopCard(),
          Container(
            padding: EdgeInsets.all(15),
            child: Text('Tasks',
            style: TextStyle(
              fontSize:24,
              fontWeight:FontWeight.bold,
            )),
          ),
          Expanded(child: Tasks()),

           RaisedButton(
                  padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                  onPressed: signOut,
                  child: Text('Signout',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                )
        ],
      )
      // bottomNavigationBar: _buildBottomNavigationBar(),
               ));
              //  ] )));
  }

  Widget _buildBottomNavigationBar() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          // boxShadow: [BoxShadow(
          //   color: Colors.grey.withOpacity(0.5),
          //   spreadRadius: 5,
          //   blurRadius: 10,
          // )]
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: BottomNavigationBar(
              // currentIndex: _currentIndex,
              // backgroundColor: Colors.grey[900],
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.yellow[700],
              unselectedItemColor: Colors.grey[200],
              items: [
                BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(Icons.home_rounded, size: 25),
                    backgroundColor: Colors.yellow[900]),
                BottomNavigationBarItem(
                    label: 'Stats',
                    icon: Icon(Icons.auto_graph_rounded, size: 25),
                    backgroundColor: Colors.red[900]),
                BottomNavigationBarItem(
                    label: 'Friends',
                    icon: Icon(Icons.people_rounded, size: 25),
                    backgroundColor: Colors.blue[900]),
                // BottomNavigationBarItem(label: 'FAQ', icon: Icon(Icons.integration_instructions_rounded, size: 25)),
              ],
              // onTap: (index){
              //   SetState(() {
              //     _currentIndex
              //   })
              // },
            )));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white70,
      elevation: 5,
      title: Row(
        children: [
          Container(
              height: 45,
              width: 45,
              // margin: EdgeInsets.all(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/images/avatar.png'),
              )),
          SizedBox(width: 10),
          Text('Hi  ${user.displayName} !',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
      actions: [
        Icon(
          Icons.more_vert,
          color: Colors.black,
          size: 30,
        )
      ],
    );
  }
}
