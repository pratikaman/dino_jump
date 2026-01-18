import 'package:flutter/material.dart';
import '../models/models.dart';

class CloudWidget extends StatelessWidget {
  final Cloud cloud;

  const CloudWidget({super.key, required this.cloud});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: cloud.x,
      top: cloud.y,
      child: CustomPaint(
        size: Size(cloud.width, cloud.height),
        painter: CloudPainter(),
      ),
    );
  }
}

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCCCCCC)
      ..style = PaintingStyle.fill;

    // Simple cloud shape using circles
    canvas.drawOval(
      Rect.fromLTWH(0, size.height * 0.3, size.width * 0.4, size.height * 0.7),
      paint,
    );
    canvas.drawOval(
      Rect.fromLTWH(
          size.width * 0.25, 0, size.width * 0.5, size.height),
      paint,
    );
    canvas.drawOval(
      Rect.fromLTWH(
          size.width * 0.6, size.height * 0.3, size.width * 0.4, size.height * 0.7),
      paint,
    );
  }

  @override
  bool shouldRepaint(CloudPainter oldDelegate) => false;
}
