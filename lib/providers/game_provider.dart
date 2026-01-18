import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';

/// Provider for screen dimensions
final screenSizeProvider = StateProvider<Size>((ref) => const Size(400, 300));

class Size {
  final double width;
  final double height;
  const Size(this.width, this.height);
}

/// Provider for ground level calculation
final groundLevelProvider = Provider<double>((ref) {
  final size = ref.watch(screenSizeProvider);
  return size.height - 50;
});

/// Main game state notifier
class GameNotifier extends StateNotifier<GameState> {
  Timer? _gameTimer;
  final Ref ref;
  final Random _random = Random();

  GameNotifier(this.ref, double groundLevel)
      : super(GameState.initial(groundLevel));

  double get _groundLevel => ref.read(groundLevelProvider);
  double get _screenWidth => ref.read(screenSizeProvider).width;

  void startGame() {
    if (state.status == GameStatus.playing) return;

    // Reset or start game
    state = GameState(
      dino: Dino(x: 50, y: _groundLevel - Dino.dinoHeight),
      obstacles: [],
      clouds: _generateInitialClouds(),
      speed: GameState.initialSpeed,
      score: 0,
      highScore: state.highScore,
      status: GameStatus.playing,
      groundOffset: 0,
    );

    // Start game loop at ~60fps
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(
      const Duration(milliseconds: 16),
      (_) => _update(),
    );
  }

  void stopGame() {
    _gameTimer?.cancel();
    _gameTimer = null;
  }

  void jump() {
    if (state.status == GameStatus.waiting) {
      startGame();
      return;
    }

    if (state.status == GameStatus.playing) {
      state.dino.jump();
    }
  }

  void duck(bool ducking) {
    if (state.status == GameStatus.playing) {
      state.dino.duck(ducking);
    }
  }

  void restart() {
    startGame();
  }

  List<Cloud> _generateInitialClouds() {
    final clouds = <Cloud>[];
    for (int i = 0; i < 3; i++) {
      clouds.add(Cloud.createRandom(
        _random.nextDouble() * _screenWidth,
        50,
        _groundLevel - 150,
      ));
    }
    return clouds;
  }

  void _update() {
    if (state.status != GameStatus.playing) return;

    // Update dino
    state.dino.update(_groundLevel - Dino.dinoHeight);

    // Update obstacles
    final obstacles = List<Obstacle>.from(state.obstacles);
    for (final obstacle in obstacles) {
      obstacle.update(state.speed);
    }

    // Remove off-screen obstacles
    obstacles.removeWhere((o) => o.isOffScreen);

    // Spawn new obstacles
    if (_shouldSpawnObstacle(obstacles)) {
      obstacles.add(Obstacle.createRandom(
        _screenWidth + 50,
        _groundLevel,
        state.score,
      ));
    }

    // Update clouds
    final clouds = List<Cloud>.from(state.clouds);
    for (final cloud in clouds) {
      cloud.update(state.speed);
    }

    // Remove off-screen clouds and spawn new ones
    clouds.removeWhere((c) => c.isOffScreen);
    if (_shouldSpawnCloud(clouds)) {
      clouds.add(Cloud.createRandom(
        _screenWidth + 50,
        50,
        _groundLevel - 150,
      ));
    }

    // Check collisions
    for (final obstacle in obstacles) {
      if (state.dino.collidesWith(obstacle)) {
        _gameOver();
        return;
      }
    }

    // Update score and speed
    final newScore = state.score + 1;
    final newSpeed = min(
      GameState.maxSpeed,
      state.speed + GameState.speedIncrement,
    );

    // Update ground offset for scrolling effect
    final newGroundOffset = (state.groundOffset + state.speed) % 12;

    state = state.copyWith(
      obstacles: obstacles,
      clouds: clouds,
      score: newScore,
      speed: newSpeed,
      groundOffset: newGroundOffset,
    );
  }

  bool _shouldSpawnObstacle(List<Obstacle> obstacles) {
    if (obstacles.isEmpty) return true;

    final lastObstacle = obstacles.last;
    final minGap = GameState.minObstacleGap + _random.nextDouble() * 200;

    return _screenWidth - lastObstacle.x > minGap;
  }

  bool _shouldSpawnCloud(List<Cloud> clouds) {
    if (clouds.isEmpty) return true;
    if (_random.nextDouble() > 0.02) return false;

    final lastCloud = clouds.last;
    return _screenWidth - lastCloud.x > 200;
  }

  void _gameOver() {
    stopGame();
    state = state.copyWith(
      status: GameStatus.gameOver,
      highScore: max(state.highScore, state.score),
    );
  }

  @override
  void dispose() {
    stopGame();
    super.dispose();
  }
}

/// Provider for the game notifier
final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  final groundLevel = ref.watch(groundLevelProvider);
  return GameNotifier(ref, groundLevel);
});

/// Provider for just the score (optimized rebuilds)
final scoreProvider = Provider<int>((ref) {
  return ref.watch(gameProvider.select((state) => state.score));
});

/// Provider for high score
final highScoreProvider = Provider<int>((ref) {
  return ref.watch(gameProvider.select((state) => state.highScore));
});

/// Provider for game status
final gameStatusProvider = Provider<GameStatus>((ref) {
  return ref.watch(gameProvider.select((state) => state.status));
});
