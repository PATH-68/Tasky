import 'package:flutter/material.dart';

class MyTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('My Tasks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,))
    );
  }
}