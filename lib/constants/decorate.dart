import 'package:flutter/material.dart';

var richTextDecoration =
InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 3, color: Colors.blue),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 3, color: Colors.teal.shade400),
    borderRadius: BorderRadius.circular(10),
  ),
);

const textInputDecoration =
InputDecoration(
  labelStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 1.2,
      fontSize: 22.0,
      fontWeight: FontWeight.bold
  ),
  filled: true,
  fillColor: Colors.black38,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.indigo, width: 2.0,)
  ),
);


var textButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.blue[600],
    elevation: 1.5,
    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    shadowColor: Colors.black,
    minimumSize: Size(350,50)
);

List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 20))
];


