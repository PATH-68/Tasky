import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
  focusColor: Colors.amber[600],
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: Colors.purple[600]!, width: 1.5)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: Colors.purple[600]!, width: 1.5)),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: Colors.purple[600]!, width: 1.5)),
);

var customButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(15.0),
  border: Border.all(color: Colors.black, width: 0.3),
  gradient: LinearGradient(
      colors: [Colors.yellow[600]!, Colors.yellow[800]!],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.1, 1]),
);
