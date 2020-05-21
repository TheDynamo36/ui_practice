import 'package:flutter/material.dart';
class CurvePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
  Path path = Path();
  Paint paint = Paint();

  path.lineTo(0, size.height*1.3);
  path.quadraticBezierTo(size.width*0.5, size.height*0.60, size.width, size.height*1);
  path.lineTo(size.width, 0);
  path.close();

  paint.color = Color(0xFF5f6b89);
  canvas.drawPath(path, paint);
  
  path = Path();

  path.lineTo(0, size.height*0.5);
  path.quadraticBezierTo(size.width*0.5, size.height*0.30, size.width, size.height*1);
  path.lineTo(size.width, 0);
  path.close();

 
  paint.color = Color(0xFF414a60);
  canvas.drawPath(path, paint);

  // path = Path();

  // path.lineTo(0, size.height*0.5);
  // path.quadraticBezierTo(size.width*0.5, size.height*0.15, size.width, size.height*0.2);
  // path.lineTo(size.width, 0);
  // path.close();

 
  // paint.color = Color(0xFF313849);
  // canvas.drawPath(path, paint);


  // path = Path();
  // path.lineTo(0, size.height*0.2);
  // path.quadraticBezierTo(size.width*0.10, size.height*0.15, size.width*0.22, size.height*0.2);
  // path.quadraticBezierTo(size.width*0.30, size.height*0.25, size.width*0.40, size.height*0.20);
  // path.quadraticBezierTo(size.width*0.52, size.height*0.13, size.width*0.65, size.height*0.12);
  // path.quadraticBezierTo(size.width*0.75, size.height*0.12, size.width, size.height*0.2);
  // path.lineTo(size.width, 0);
  // path.close();

  // paint.color = light;//Color(0xFFDDE7F0);
  // canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 300.0,
      ),
      painter: CurvePainter(),
    );
  }
}
