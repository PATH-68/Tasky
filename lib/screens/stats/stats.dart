import 'package:flutter/material.dart';
import 'package:task_app/screens/stats/widgets/pieChart.dart';
import 'package:task_app/screens/home/home.dart';

class Stats extends StatelessWidget {

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PieChart(),
          Container(
            padding: EdgeInsets.all(15),
          ),
        ],
      ),
    );
  }
}