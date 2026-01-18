import 'dart:math';
import 'game_object.dart';

/// Background cloud decoration
class Cloud extends GameObject {
  static const double cloudWidth = 46.0;
  static const double cloudHeight = 14.0;

  Cloud({
    required double x,
    required double y,
  }) : super(
          x: x,
          y: y,
          width: cloudWidth,
          height: cloudHeight,
        );

  Cloud copyWith({double? x, double? y}) {
    return Cloud(x: x ?? this.x, y: y ?? this.y);
  }

  void update(double speed) {
    // Clouds move slower than obstacles
    x -= speed * 0.3;
  }

  bool get isOffScreen => x < -width;

  static Cloud createRandom(double startX, double minY, double maxY) {
    final random = Random();
    final y = minY + random.nextDouble() * (maxY - minY);
    return Cloud(x: startX, y: y);
  }
}
