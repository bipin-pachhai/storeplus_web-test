// @dart=2.9
import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String text;
  final Color color;
  final FontWeight weight;
  final double size;

  const TextWidget({Key key, this.text, this.color, this.weight, this.size})
      : super(key: key);
  @override
  _TextWidgetState createState() => _TextWidgetState(text, color, weight, size);
}

class _TextWidgetState extends State<TextWidget> {
  String text;
  final Color color;
  final FontWeight weight;
  final double size;

  _TextWidgetState(this.text, this.color, this.weight, this.size);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1,
      style: TextStyle(color: color, fontWeight: weight, fontSize: size),
    );
  }
}
