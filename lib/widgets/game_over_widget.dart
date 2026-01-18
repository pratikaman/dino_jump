import 'package:flutter/material.dart';

class GameOverWidget extends StatelessWidget {
  final VoidCallback onRestart;

  const GameOverWidget({super.key, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'GAME OVER',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF535353),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onRestart,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF535353), width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPaint(
                    size: const Size(24, 24),
                    painter: RestartIconPainter(),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'TAP TO RESTART',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF535353),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RestartIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF535353)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw circular arrow
    canvas.drawArc(
      Rect.fromLTWH(2, 2, size.width - 4, size.height - 4),
      0.5,
      4.5,
      false,
      paint,
    );

    // Arrow head
    final arrowPaint = Paint()
      ..color = const Color(0xFF535353)
      ..style = PaintingStyle.fill;

    final arrowPath = Path();
    arrowPath.moveTo(size.width * 0.7, 0);
    arrowPath.lineTo(size.width * 0.9, size.height * 0.25);
    arrowPath.lineTo(size.width * 0.55, size.height * 0.25);
    arrowPath.close();
    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(RestartIconPainter oldDelegate) => false;
}
