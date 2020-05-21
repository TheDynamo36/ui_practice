import 'package:flutter/material.dart';
import 'package:ui_practice/HelperClass/CustomColors.dart';

class RowText extends StatelessWidget {
  const RowText({
    Key key,
    @required this.text, @required this.imgName
  }) : super(key: key);

  final text, imgName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [new BoxShadow(color: Colors.black12, blurRadius: 6.0)]),
          child: Image(image: AssetImage('assets/$imgName.png'),
          ),
          width: 28.0,
          height: 28.0,
          margin: EdgeInsets.only(right: 10.0),
          ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Playfair",
              color: blackText,
              fontSize: 14,
              fontWeight: FontWeight.w500),),
        ),
      ],
    );
  }
}
