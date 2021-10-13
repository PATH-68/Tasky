import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class Task{
  IconData? iconData;
  String? title;
  Color? bgColor;
  Color? darkColor;
  Color? lightColor;
  Color? iconColor;
  num? left;
  num? done;
  bool islast;
  Task({this.iconData, this.title, this.bgColor, this.darkColor, this.iconColor, this.lightColor, this.left, this.done, this.islast = false});
  static List<Task> generateTasks() {
    return [
      Task(
        iconData: Icons.person_rounded,
        title: 'Personal',
        bgColor: Colors.blue[100],
        iconColor: Colors.blue[900],
        darkColor: Colors.blue[300],
        left:3,
        done: 4,
        ),

      Task(
        iconData: Icons.cases_rounded,
        title: 'Work',
        bgColor: Colors.red[100],
        iconColor: Colors.red[900],
        darkColor: Colors.red[300],
        left: 0,
        done: 4,
        ),

      Task(
        iconData: Icons.favorite_rounded,
        title: 'Health',
        bgColor: Colors.yellow[100],
        iconColor: Colors.yellow[900],
        darkColor: Colors.yellow[300],
        left: 2,
        done: 1,
        ),

      Task(islast: true)
    ];
  }
}