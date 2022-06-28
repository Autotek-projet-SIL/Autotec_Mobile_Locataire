// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String? text;
  final VoidCallback? press;
  final Color? color, textColor;
  const CustomRaisedButton({
    Key? key,
    this.text,
    this.press,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: RaisedButton(
        color: color,
        hoverColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text(
          text!,
          style: TextStyle(color: textColor, fontSize: 16),
          maxLines: 1,
          softWrap: false,
        ),
        onPressed: press,
      ),
    );
  }
}