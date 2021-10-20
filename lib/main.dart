import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/screens/home/home.dart';
import 'package:task_app/screens/stats/stats.dart';
import 'package:task_app/screens/localisation/localisation.dart';
import 'package:task_app/screens/my_tasks/my_tasks.dart';
import 'package:task_app/screens/Actus/actus.dart';
import 'package:task_app/screens/Connexion/signin.dart';
import 'package:task_app/screens/Connexion/signup.dart';
import 'package:task_app/screens/Connexion/logpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_app/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<BaseUser?>.value(
      value: AuthService().user,
      initialData: BaseUser(uid: '0'),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Handler',
        home: const TheApp(),
        routes: <String, WidgetBuilder>{
          "signin": (BuildContext context) => Login(),
          "signup": (BuildContext context) => SignUp(),
          "logpage": (BuildContext context) => Logs(),
        },
      ),
    );
  }
}

class TheApp extends StatefulWidget {
  const TheApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TheApp> {
  int _currentIndex = 0;

  final tabs = [
    const HomePage(),
    Actus(),
    const MyTasks(),
    Stats(),
    MyLoc(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.grey[900],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.yellow[700],
          unselectedItemColor: Colors.grey[200],
          items: [
            const BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_rounded, size: 25),
                backgroundColor: Colors.black),
            const BottomNavigationBarItem(
                label: 'Actus',
                icon: Icon(Icons.new_releases_rounded, size: 25),
                backgroundColor: Colors.purple),
            const BottomNavigationBarItem(
                label: 'My Tasks',
                icon: Icon(Icons.integration_instructions_rounded, size: 25),
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                label: 'Stats',
                icon: const Icon(Icons.auto_graph_rounded, size: 25),
                backgroundColor: Colors.red[900]),
            BottomNavigationBarItem(
                label: 'Localisation',
                icon: const Icon(Icons.location_searching_rounded, size: 25),
                backgroundColor: Colors.blue[900]),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ));
  }
}
