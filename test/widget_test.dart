import 'package:flutter_test/flutter_test.dart';
import 'package:dino_jump/models/models.dart';

void main() {
  group('Dino', () {
    test('should initialize with correct default values', () {
      final dino = Dino(x: 50, y: 100);

      expect(dino.x, 50);
      expect(dino.y, 100);
      expect(dino.velocityY, 0);
      expect(dino.isJumping, false);
      expect(dino.isDucking, false);
    });

    test('should set velocity when jumping', () {
      final dino = Dino(x: 50, y: 100);
      dino.jump();

      expect(dino.velocityY, Dino.jumpVelocity);
      expect(dino.isJumping, true);
    });

    test('should not jump while already jumping', () {
      final dino = Dino(x: 50, y: 100);
      dino.jump();
      final initialVelocity = dino.velocityY;

      dino.velocityY = -5; // Simulate mid-jump
      dino.jump();

      expect(dino.velocityY, -5); // Velocity should not reset
    });

    test('should duck when not jumping', () {
      final dino = Dino(x: 50, y: 100);
      dino.duck(true);

      expect(dino.isDucking, true);
    });

    test('should not duck while jumping', () {
      final dino = Dino(x: 50, y: 100);
      dino.jump();
      dino.duck(true);

      expect(dino.isDucking, false);
    });
  });

  group('Obstacle', () {
    test('should create small cactus with correct dimensions', () {
      final obstacle = Obstacle(
        x: 100,
        y: 200,
        type: ObstacleType.smallCactus,
      );

      expect(obstacle.width, Obstacle.smallCactusWidth);
      expect(obstacle.height, Obstacle.smallCactusHeight);
    });

    test('should create large cactus with correct dimensions', () {
      final obstacle = Obstacle(
        x: 100,
        y: 200,
        type: ObstacleType.largeCactus,
      );

      expect(obstacle.width, Obstacle.largeCactusWidth);
      expect(obstacle.height, Obstacle.largeCactusHeight);
    });

    test('should create bird with correct dimensions', () {
      final obstacle = Obstacle(
        x: 100,
        y: 200,
        type: ObstacleType.bird,
      );

      expect(obstacle.width, Obstacle.birdWidth);
      expect(obstacle.height, Obstacle.birdHeight);
    });

    test('should move left when updated', () {
      final obstacle = Obstacle(
        x: 100,
        y: 200,
        type: ObstacleType.smallCactus,
      );

      obstacle.update(5);

      expect(obstacle.x, 95);
    });

    test('should be off screen when x is negative', () {
      final obstacle = Obstacle(
        x: -20,
        y: 200,
        type: ObstacleType.smallCactus,
      );

      expect(obstacle.isOffScreen, true);
    });
  });

  group('GameState', () {
    test('should initialize with waiting status', () {
      final state = GameState.initial(300);

      expect(state.status, GameStatus.waiting);
      expect(state.score, 0);
      expect(state.speed, GameState.initialSpeed);
      expect(state.obstacles, isEmpty);
    });

    test('should detect playing state', () {
      final state = GameState.initial(300).copyWith(
        status: GameStatus.playing,
      );

      expect(state.isPlaying, true);
      expect(state.isGameOver, false);
      expect(state.isWaiting, false);
    });

    test('should detect game over state', () {
      final state = GameState.initial(300).copyWith(
        status: GameStatus.gameOver,
      );

      expect(state.isPlaying, false);
      expect(state.isGameOver, true);
      expect(state.isWaiting, false);
    });
  });

  group('Collision Detection', () {
    test('should detect collision between overlapping objects', () {
      final dino = Dino(x: 50, y: 100);
      final obstacle = Obstacle(
        x: 55,
        y: 105,
        type: ObstacleType.smallCactus,
      );

      expect(dino.collidesWith(obstacle), true);
    });

    test('should not detect collision between non-overlapping objects', () {
      final dino = Dino(x: 50, y: 100);
      final obstacle = Obstacle(
        x: 200,
        y: 100,
        type: ObstacleType.smallCactus,
      );

      expect(dino.collidesWith(obstacle), false);
    });
  });
}
