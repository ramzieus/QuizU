import 'package:flutter/material.dart';

class ResultShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.color = Colors.white;
    path = Path();
    path.lineTo(size.width * 0.87, size.height);
    path.cubicTo(size.width * 0.87, size.height, size.width * 0.15, size.height,
        size.width * 0.15, size.height);
    path.cubicTo(size.width * 0.07, size.height, size.width * 0.02,
        size.height * 0.96, size.width * 0.01, size.height * 0.91);
    path.cubicTo(size.width * 0.01, size.height * 0.91, 0, size.height * 0.1, 0,
        size.height * 0.1);
    path.cubicTo(0, size.height * 0.03, size.width * 0.1, -0.02,
        size.width * 0.19, size.height * 0.01);
    path.cubicTo(size.width * 0.43, size.height * 0.1, size.width * 0.68,
        size.height * 0.18, size.width * 0.93, size.height * 0.27);
    path.cubicTo(size.width * 0.97, size.height * 0.28, size.width,
        size.height * 0.32, size.width, size.height * 0.35);
    path.cubicTo(size.width, size.height * 0.35, size.width, size.height * 0.91,
        size.width, size.height * 0.91);
    path.cubicTo(size.width, size.height * 0.96, size.width * 0.94, size.height,
        size.width * 0.87, size.height);
    path.cubicTo(size.width * 0.87, size.height, size.width * 0.87, size.height,
        size.width * 0.87, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
