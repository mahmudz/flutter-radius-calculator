import 'package:flutter/material.dart';

class CornerSidePainter extends CustomPainter {
  final double radius;
  final Color borderColor;

  const CornerSidePainter({
    super.repaint,
    required this.radius,
    required this.borderColor,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    double w = size.width;
    double h = size.height;
    double r = radius; //<-- corner radius

    Paint blackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Paint redPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..shader = RadialGradient(
        colors: [
          Colors.grey.shade300,
          borderColor,
          Colors.grey.shade300,
        ],
      ).createShader(
        Rect.fromCircle(
          center: const Offset(0, 0),
          radius: radius,
        ),
      );

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
      Radius.circular(r),
    );

    Path topRightArc = Path()
      ..moveTo(0, r)
      ..arcToPoint(Offset(r, 0), radius: Radius.circular(r));

    canvas.drawRRect(fullRect, blackPaint);
    canvas.drawPath(topRightArc, redPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
