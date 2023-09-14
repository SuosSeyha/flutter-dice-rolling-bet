import 'package:flutter/material.dart';
Widget gameText({
  required String text,
  required Color color,
  required double fontSize,
  required FontWeight fontWeight
}){
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontFamily: "GameFont",
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}