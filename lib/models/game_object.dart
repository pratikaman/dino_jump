import 'package:flutter/material.dart';

/// Base class for all game objects with position and size
class GameObject {
  double x;
  double y;
  final double width;
  final double height;

  GameObject({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  Rect get rect => Rect.fromLTWH(x, y, width, height);

  bool collidesWith(GameObject other) {
    // Shrink hitbox slightly for more forgiving collision
    const padding = 5.0;
    final thisRect = Rect.fromLTWH(
      x + padding,
      y + padding,
      width - padding * 2,
      height - padding * 2,
    );
    final otherRect = Rect.fromLTWH(
      other.x + padding,
      other.y + padding,
      other.width - padding * 2,
      other.height - padding * 2,
    );
    return thisRect.overlaps(otherRect);
  }
}
