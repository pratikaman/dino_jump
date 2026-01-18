import 'game_object.dart';

/// The player-controlled dinosaur
class Dino extends GameObject {
  double velocityY;
  bool isJumping;
  bool isDucking;
  int animationFrame;

  static const double dinoWidth = 44.0;
  static const double dinoHeight = 47.0;
  static const double duckingHeight = 30.0;
  static const double gravity = 1.2;
  static const double jumpVelocity = -18.0;
  static const double groundY = 0.0;

  Dino({
    required double x,
    required double y,
  })  : velocityY = 0,
        isJumping = false,
        isDucking = false,
        animationFrame = 0,
        super(
          x: x,
          y: y,
          width: dinoWidth,
          height: dinoHeight,
        );

  Dino copyWith({
    double? x,
    double? y,
    double? velocityY,
    bool? isJumping,
    bool? isDucking,
    int? animationFrame,
  }) {
    final dino = Dino(x: x ?? this.x, y: y ?? this.y);
    dino.velocityY = velocityY ?? this.velocityY;
    dino.isJumping = isJumping ?? this.isJumping;
    dino.isDucking = isDucking ?? this.isDucking;
    dino.animationFrame = animationFrame ?? this.animationFrame;
    return dino;
  }

  void jump() {
    if (!isJumping && !isDucking) {
      velocityY = jumpVelocity;
      isJumping = true;
    }
  }

  void duck(bool ducking) {
    if (!isJumping) {
      isDucking = ducking;
    }
  }

  void update(double groundLevel) {
    if (isJumping) {
      velocityY += gravity;
      y += velocityY;

      if (y >= groundLevel) {
        y = groundLevel;
        velocityY = 0;
        isJumping = false;
      }
    }

    // Update animation frame
    animationFrame = (animationFrame + 1) % 20;
  }

  @override
  double get height => isDucking ? duckingHeight : dinoHeight;
}
