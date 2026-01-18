import 'package:flutter/material.dart';

class GroundWidget extends StatelessWidget {
  final double groundLevel;
  final double offset;

  const GroundWidget({
    super.key,
    required this.groundLevel,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: groundLevel,
      right: 0,
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width, 50),
        painter: GroundPainter(offset: offset),
      ),
    );
  }
}

class GroundPainter extends CustomPainter {
  final double offset;

  GroundPainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF535353)
      ..style = PaintingStyle.fill;

    // Main ground line
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, 2),
      paint,
    );

    // Ground texture - small bumps that scroll
    final bumpPaint = Paint()
      ..color = const Color(0xFF535353)
      ..style = PaintingStyle.fill;

    for (double x = -offset; x < size.width; x += 12) {
      // Random-ish pattern based on position
      final hash = (x.toInt() * 31) % 7;
      if (hash < 3) {
        canvas.drawRect(
          Rect.fromLTWH(x, 5, 2, 2),
          bumpPaint,
        );
      }
      if (hash == 1 || hash == 4) {
        canvas.drawRect(
          Rect.fromLTWH(x + 3, 8, 3, 1),
          bumpPaint,
        );
      }
      if (hash > 4) {
        canvas.drawRect(
          Rect.fromLTWH(x + 1, 12, 1, 2),
          bumpPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(GroundPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}
