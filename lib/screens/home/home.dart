import 'package:flutter/material.dart';
import 'package:task_app/screens/home/widgets/tasks.dart';
import 'package:task_app/screens/home/widgets/topcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/services/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
                ? const CircularProgressIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopCard(),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: const Text('Tasks',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Expanded(child: Tasks()),
                      RaisedButton(
                        padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
                        onPressed: () => AuthService().signOut(),
                        child: const Text('Signout',
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
                  )));
  }

  Widget _buildBottomNavigationBar() {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.yellow[700],
              unselectedItemColor: Colors.grey[200],
              items: [
                BottomNavigationBarItem(
                    label: 'Home',
                    icon: const Icon(Icons.home_rounded, size: 25),
                    backgroundColor: Colors.yellow[900]),
                BottomNavigationBarItem(
                    label: 'Stats',
                    icon: const Icon(Icons.auto_graph_rounded, size: 25),
                    backgroundColor: Colors.red[900]),
                BottomNavigationBarItem(
                    label: 'Friends',
                    icon: const Icon(Icons.people_rounded, size: 25),
                    backgroundColor: Colors.blue[900]),
              ],
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/images/avatar.png'),
              )),
          const SizedBox(width: 10),
          Text('Hi  ${user.displayName} !',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
      actions: const [
        Icon(
          Icons.more_vert,
          color: Colors.black,
          size: 30,
        )
      ],
    );
  }
}
