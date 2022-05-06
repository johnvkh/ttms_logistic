import 'package:flutter/material.dart';

Widget TextWidget(
    String content, Color color, double fontSize, FontWeight fontWeight) {
  return Text(
    content,
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}

Widget TextButtonWidget(VoidCallback onPass, String content, Color color,
    double fontSize, FontWeight fontWeight) {
  return TextButton(
    onPressed: onPass,
    child: Text(
      content,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}
