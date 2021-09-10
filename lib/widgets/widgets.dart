import 'package:flutter/material.dart';

Widget blueButton({BuildContext context, String text, buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
      color: Color(0XFF494EC9),
      borderRadius: BorderRadius.circular(30),
    ),
    alignment: Alignment.center,
    width: buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width - 48,
    child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
  );
}
