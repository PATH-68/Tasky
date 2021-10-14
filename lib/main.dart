import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_app/screens/home/home.dart';
import 'package:task_app/screens/home/widgets/tasks.dart';
import 'package:task_app/screens/stats/stats.dart';
import 'package:task_app/screens/Friends/friends.dart';
import 'package:task_app/screens/my_tasks/my_tasks.dart';
import 'package:task_app/screens/Actus/actus.dart';
import 'package:task_app/screens/Connexion/signin.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Task Handler',
//       home: HomePage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Handler',
      home: TheApp(),
    );
  }
}

class TheApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TheApp> {

  int _currentIndex = 0;

  final tabs = [
    HomePage(),
    Actus(),
    MyTasks(),
    Stats(),
    Signin(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
              backgroundColor: Colors.white70,
      elevation: 5,
      title: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            margin: EdgeInsets.all(30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('assets/images/avatar.png'),
            )
          ),
          SizedBox(width: 10),
          Text('Hi Pikachu !', style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ))
        ],
      ),
      actions: [
        Icon(Icons.message_rounded,
        color: Colors.black,
        size: 30,
        )
      ],
      ),

      body: tabs[_currentIndex],

    bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: Colors.grey[900],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.yellow[700],
            unselectedItemColor: Colors.grey[200],
            items: [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_rounded, size: 25), backgroundColor: Colors.black),
            BottomNavigationBarItem(label: 'Actus', icon: Icon(Icons.new_releases_rounded, size: 25), backgroundColor: Colors.purple),
            BottomNavigationBarItem(label: 'My Tasks', icon: Icon(Icons.integration_instructions_rounded, size: 25), backgroundColor: Colors.grey),
            BottomNavigationBarItem(label: 'Stats', icon: Icon(Icons.auto_graph_rounded, size: 25), backgroundColor: Colors.red[900]),
            BottomNavigationBarItem(label: 'Friends', icon: Icon(Icons.people_rounded, size: 25), backgroundColor: Colors.blue[900]),
          ],
           onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          )
    );
  }
}
