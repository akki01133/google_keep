import 'package:flutter/material.dart';

class BottomBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xff2d2e32)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);
    path.lineTo(size.width * 0.76, 0);
    path.quadraticBezierTo(
        size.width * 0.78, 0, size.width * 0.78, size.width * 0.02);
    path.quadraticBezierTo(size.width * 0.78, size.width * 0.07,
        size.width * 0.83, size.width * 0.07);
    path.lineTo(size.width * 0.88, size.width * 0.07);
    path.quadraticBezierTo(size.width * 0.93, size.width * 0.07,
        size.width * 0.93, size.width * 0.03);
    path.quadraticBezierTo(
        size.width * 0.93, size.width * 0.00, size.width * 0.96, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, 50);
    path.lineTo(0, 50);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
