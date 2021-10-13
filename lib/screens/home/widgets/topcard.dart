import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(25),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                  color: Colors.grey[800],
                  shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.timelapse,
                    color: Colors.white,
                    size: 30
                    ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Today's advice",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),),
                    SizedBox(height:10),
                    Container(
                      margin: EdgeInsets.all(3),
                      child: Text('Go get yourself a wife!  \nAnd grab some money \non the way too...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      )),
                    )
                  ],
                )
              ],
            )
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(Icons.note_sharp,
              color: Colors.white70,)
            ),
          )
        ],
      ),
    );
  }
}