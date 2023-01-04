import 'package:flutter/material.dart';

class BottomBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xff2d2e32)
      ..style = PaintingStyle.fill;
    double x = size.width, y  = 0;
    Path path = Path()..moveTo(x, 0);
    path.lineTo(x-24, y);
    x-=28;
    path.quadraticBezierTo(
        x-4, y, x - 4, y+6);
    y+=6;
    x-=4;
    path.quadraticBezierTo(
        x-2, y+10, x - 10, y+13);
    y+=13;
    x-=10;
    path.lineTo(x-44, y);
    x-=44;

    path.quadraticBezierTo(
        x-10+2, y-3, x - 10, y-13);
    y-=13;
    x-=10;
    path.quadraticBezierTo(
        x, y-6, x - 4, y-6);
    y-=6;
    x-=4;

    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
