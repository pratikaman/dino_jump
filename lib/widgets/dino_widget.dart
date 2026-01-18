import 'package:flutter/material.dart';
import '../models/models.dart';

class DinoWidget extends StatelessWidget {
  final Dino dino;

  const DinoWidget({super.key, required this.dino});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: dino.x,
      top: dino.y,
      child: CustomPaint(
        size: Size(dino.width, dino.height),
        painter: DinoPainter(
          isJumping: dino.isJumping,
          isDucking: dino.isDucking,
          animationFrame: dino.animationFrame,
        ),
      ),
    );
  }
}

class DinoPainter extends CustomPainter {
  final bool isJumping;
  final bool isDucking;
  final int animationFrame;

  DinoPainter({
    required this.isJumping,
    required this.isDucking,
    required this.animationFrame,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF535353)
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFF535353)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    if (isDucking) {
      _drawDuckingDino(canvas, size, paint);
    } else {
      _drawStandingDino(canvas, size, paint, outlinePaint);
    }
  }

  void _drawStandingDino(
      Canvas canvas, Size size, Paint paint, Paint outlinePaint) {
    final path = Path();

    // Body
    path.addRect(Rect.fromLTWH(size.width * 0.2, size.height * 0.2,
        size.width * 0.6, size.height * 0.5));

    // Head
    path.addRect(Rect.fromLTWH(
        size.width * 0.5, 0, size.width * 0.5, size.height * 0.35));

    // Eye (white space)
    canvas.drawPath(path, paint);

    // Draw eye
    final eyePaint = Paint()..color = Colors.white;
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.75, size.height * 0.08, size.width * 0.12, size.height * 0.1),
      eyePaint,
    );

    // Legs - animate when running
    final legOffset = (!isJumping && animationFrame < 10) ? 5.0 : 0.0;

    // Left leg
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.25, size.height * 0.7 + legOffset,
          size.width * 0.15, size.height * 0.3 - legOffset),
      paint,
    );

    // Right leg
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.55, size.height * 0.7 - legOffset,
          size.width * 0.15, size.height * 0.3 + legOffset),
      paint,
    );

    // Tail
    canvas.drawRect(
      Rect.fromLTWH(
          0, size.height * 0.3, size.width * 0.25, size.height * 0.15),
      paint,
    );

    // Arms
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.6, size.height * 0.45, size.width * 0.15,
          size.height * 0.2),
      paint,
    );
  }

  void _drawDuckingDino(Canvas canvas, Size size, Paint paint) {
    // Ducking dino - more horizontal
    final path = Path();

    // Stretched body
    path.addRect(
        Rect.fromLTWH(0, size.height * 0.2, size.width, size.height * 0.5));

    // Head at front
    path.addRect(Rect.fromLTWH(
        size.width * 0.75, 0, size.width * 0.25, size.height * 0.4));

    canvas.drawPath(path, paint);

    // Eye
    final eyePaint = Paint()..color = Colors.white;
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.85, size.height * 0.1, size.width * 0.08, size.height * 0.12),
      eyePaint,
    );

    // Legs
    final legOffset = animationFrame < 10 ? 3.0 : 0.0;
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.15, size.height * 0.7 + legOffset,
          size.width * 0.1, size.height * 0.3 - legOffset),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.35, size.height * 0.7 - legOffset,
          size.width * 0.1, size.height * 0.3 + legOffset),
      paint,
    );
  }

  @override
  bool shouldRepaint(DinoPainter oldDelegate) {
    return oldDelegate.isJumping != isJumping ||
        oldDelegate.isDucking != isDucking ||
        oldDelegate.animationFrame != animationFrame;
  }
}
