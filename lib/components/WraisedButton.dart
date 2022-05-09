// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';


class WidgetRaisedButton extends StatelessWidget {
  final String text;
  final void Function() press;
  final Color color, textColor;
  const WidgetRaisedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FractionallySizedBox(
      widthFactor: 1,

      child: RaisedButton(
        color: color,
        hoverColor: Colors.black,
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),      
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),

        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 16),
        ),
        onPressed: press,
      ),

    );
  }
}