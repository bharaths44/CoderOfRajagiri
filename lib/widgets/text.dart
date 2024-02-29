import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const NormalText(
      {Key? key,
      required this.text,
      this.fontSize = 18.0,
      this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize, color: color, fontWeight: FontWeight.w400));
  }
}

class SubHeading extends StatelessWidget {
  final Color color;
  final String text;

  const SubHeading({Key? key, required this.text, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style:
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color));
  }
}
