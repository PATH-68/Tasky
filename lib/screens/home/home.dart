import 'package:flutter/material.dart';
import 'package:task_app/screens/home/widgets/tasks.dart';
import 'package:task_app/screens/home/widgets/topcard.dart';

class HomePage extends StatelessWidget {



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: _buildAppBar(),
      body: Column(
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
          Expanded(child: Tasks())
        ],
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
          ),
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
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_rounded, size: 25), backgroundColor: Colors.yellow[900]),
            BottomNavigationBarItem(label: 'Stats', icon: Icon(Icons.auto_graph_rounded, size: 25), backgroundColor: Colors.red[900]),
            BottomNavigationBarItem(label: 'Friends', icon: Icon(Icons.people_rounded, size: 25), backgroundColor: Colors.blue[900]),
            // BottomNavigationBarItem(label: 'FAQ', icon: Icon(Icons.integration_instructions_rounded, size: 25)),
          ],
          // onTap: (index){
          //   SetState(() {
          //     _currentIndex
          //   })
          // },
          )
      )
    );
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
        Icon(Icons.more_vert,
        color: Colors.black,
        size: 30,
        )
      ],
    );
  }
  
}