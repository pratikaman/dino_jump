import 'dart:math';
import 'game_object.dart';

enum ObstacleType { smallCactus, largeCactus, bird }

/// Obstacles that the dino must avoid
class Obstacle extends GameObject {
  final ObstacleType type;
  final int variant;

  static const double smallCactusWidth = 17.0;
  static const double smallCactusHeight = 35.0;
  static const double largeCactusWidth = 25.0;
  static const double largeCactusHeight = 50.0;
  static const double birdWidth = 46.0;
  static const double birdHeight = 40.0;

  Obstacle({
    required double x,
    required double y,
    required this.type,
    this.variant = 0,
  }) : super(
          x: x,
          y: y,
          width: _getWidth(type),
          height: _getHeight(type),
        );

  static double _getWidth(ObstacleType type) {
    switch (type) {
      case ObstacleType.smallCactus:
        return smallCactusWidth;
      case ObstacleType.largeCactus:
        return largeCactusWidth;
      case ObstacleType.bird:
        return birdWidth;
    }
  }

  static double _getHeight(ObstacleType type) {
    switch (type) {
      case ObstacleType.smallCactus:
        return smallCactusHeight;
      case ObstacleType.largeCactus:
        return largeCactusHeight;
      case ObstacleType.bird:
        return birdHeight;
    }
  }

  Obstacle copyWith({double? x, double? y}) {
    return Obstacle(
      x: x ?? this.x,
      y: y ?? this.y,
      type: type,
      variant: variant,
    );
  }

  void update(double speed) {
    x -= speed;
  }

  bool get isOffScreen => x < -width;

  static Obstacle createRandom(double startX, double groundLevel, int score) {
    final random = Random();

    // Birds only appear after score of 200
    final canSpawnBird = score > 200;
    final maxType = canSpawnBird ? 3 : 2;
    final typeIndex = random.nextInt(maxType);

    final type = ObstacleType.values[typeIndex];

    double y;
    switch (type) {
      case ObstacleType.smallCactus:
        y = groundLevel - smallCactusHeight;
        break;
      case ObstacleType.largeCactus:
        y = groundLevel - largeCactusHeight;
        break;
      case ObstacleType.bird:
        // Birds can fly at different heights
        final heights = [groundLevel - 70, groundLevel - 100, groundLevel - 40];
        y = heights[random.nextInt(heights.length)];
        break;
    }

    return Obstacle(
      x: startX,
      y: y,
      type: type,
      variant: random.nextInt(3),
    );
  }
}
