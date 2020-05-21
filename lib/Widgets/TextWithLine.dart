import 'package:flutter/material.dart';
import 'package:ui_practice/HelperClass/CustomColors.dart';

class TextWithLine extends StatelessWidget {
  const TextWithLine({
    Key key,
    @required this.text, this.fontFamily, this.fontSize, this.color
  }) : super(key: key);

  final String text, fontFamily;
  final fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(text,style: TextStyle(
          color: color ?? whiteText,
          fontWeight: FontWeight.w500,
          fontSize: fontSize ?? 20.0,
          fontFamily: fontFamily ?? "Montserrat",
          ),
          ),
        Flexible(
          flex: 3,
          child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          height: 1.5,
          color: color ?? whiteText,
          ),
        ),
      ],);
  }
}
