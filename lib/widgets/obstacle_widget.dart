import 'package:flutter/material.dart';
import '../models/models.dart';

class ObstacleWidget extends StatelessWidget {
  final Obstacle obstacle;

  const ObstacleWidget({super.key, required this.obstacle});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: obstacle.x,
      top: obstacle.y,
      child: CustomPaint(
        size: Size(obstacle.width, obstacle.height),
        painter: ObstaclePainter(
          type: obstacle.type,
          variant: obstacle.variant,
        ),
      ),
    );
  }
}

class ObstaclePainter extends CustomPainter {
  final ObstacleType type;
  final int variant;

  ObstaclePainter({required this.type, required this.variant});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF535353)
      ..style = PaintingStyle.fill;

    switch (type) {
      case ObstacleType.smallCactus:
        _drawSmallCactus(canvas, size, paint);
        break;
      case ObstacleType.largeCactus:
        _drawLargeCactus(canvas, size, paint);
        break;
      case ObstacleType.bird:
        _drawBird(canvas, size, paint);
        break;
    }
  }

  void _drawSmallCactus(Canvas canvas, Size size, Paint paint) {
    // Main stem
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.3, size.height * 0.2, size.width * 0.4, size.height * 0.8),
      paint,
    );

    // Left arm
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.3, size.width * 0.3, size.height * 0.15),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.15, size.width * 0.15, size.height * 0.3),
      paint,
    );

    // Right arm
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.7, size.height * 0.45, size.width * 0.3, size.height * 0.15),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.85, size.height * 0.3, size.width * 0.15, size.height * 0.3),
      paint,
    );
  }

  void _drawLargeCactus(Canvas canvas, Size size, Paint paint) {
    // Main stem - thicker
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.25, size.height * 0.1, size.width * 0.5, size.height * 0.9),
      paint,
    );

    // Left arm
    canvas.drawRect(
      Rect.fromLTWH(
          0, size.height * 0.25, size.width * 0.25, size.height * 0.12),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.1, size.width * 0.12, size.height * 0.27),
      paint,
    );

    // Right arm
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.75, size.height * 0.4, size.width * 0.25, size.height * 0.12),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.88, size.height * 0.25, size.width * 0.12, size.height * 0.27),
      paint,
    );

    // Top spikes
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.35, 0, size.width * 0.1, size.height * 0.1),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.55, 0, size.width * 0.1, size.height * 0.1),
      paint,
    );
  }

  void _drawBird(Canvas canvas, Size size, Paint paint) {
    final wingUp = variant % 2 == 0;

    // Main body - angular pterodactyl shape
    final bodyPath = Path();
    bodyPath.moveTo(size.width * 0.0, size.height * 0.5);
    bodyPath.lineTo(size.width * 0.15, size.height * 0.4);
    bodyPath.lineTo(size.width * 0.5, size.height * 0.38);
    bodyPath.lineTo(size.width * 0.6, size.height * 0.42);
    bodyPath.lineTo(size.width * 0.5, size.height * 0.55);
    bodyPath.lineTo(size.width * 0.15, size.height * 0.55);
    bodyPath.close();
    canvas.drawPath(bodyPath, paint);

    // Head with crest
    final headPath = Path();
    headPath.moveTo(size.width * 0.5, size.height * 0.38);
    headPath.lineTo(size.width * 0.55, size.height * 0.25);
    headPath.lineTo(size.width * 0.7, size.height * 0.2);
    headPath.lineTo(size.width * 0.75, size.height * 0.35);
    headPath.lineTo(size.width * 0.7, size.height * 0.45);
    headPath.lineTo(size.width * 0.6, size.height * 0.42);
    headPath.close();
    canvas.drawPath(headPath, paint);

    // Long pointed beak
    final beakPath = Path();
    beakPath.moveTo(size.width * 0.75, size.height * 0.35);
    beakPath.lineTo(size.width, size.height * 0.4);
    beakPath.lineTo(size.width * 0.75, size.height * 0.45);
    beakPath.close();
    canvas.drawPath(beakPath, paint);

    // Wing - pterodactyl membrane style
    if (wingUp) {
      final wingPath = Path();
      wingPath.moveTo(size.width * 0.1, size.height * 0.4);
      wingPath.lineTo(size.width * 0.15, size.height * 0.15);
      wingPath.lineTo(size.width * 0.35, size.height * 0.0);
      wingPath.lineTo(size.width * 0.45, size.height * 0.1);
      wingPath.lineTo(size.width * 0.4, size.height * 0.38);
      wingPath.close();
      canvas.drawPath(wingPath, paint);
    } else {
      final wingPath = Path();
      wingPath.moveTo(size.width * 0.1, size.height * 0.55);
      wingPath.lineTo(size.width * 0.15, size.height * 0.75);
      wingPath.lineTo(size.width * 0.35, size.height * 0.95);
      wingPath.lineTo(size.width * 0.45, size.height * 0.85);
      wingPath.lineTo(size.width * 0.4, size.height * 0.55);
      wingPath.close();
      canvas.drawPath(wingPath, paint);
    }

    // Eye
    final eyePaint = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.32),
      size.width * 0.04,
      eyePaint,
    );

    // Pupil
    final pupilPaint = Paint()..color = const Color(0xFF535353);
    canvas.drawCircle(
      Offset(size.width * 0.66, size.height * 0.32),
      size.width * 0.02,
      pupilPaint,
    );
  }

  @override
  bool shouldRepaint(ObstaclePainter oldDelegate) {
    return oldDelegate.type != type || oldDelegate.variant != variant;
  }
}
