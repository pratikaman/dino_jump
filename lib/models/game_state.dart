import 'dino.dart';
import 'obstacle.dart';
import 'cloud.dart';

enum GameStatus { waiting, playing, gameOver }

/// The complete game state
class GameState {
  final Dino dino;
  final List<Obstacle> obstacles;
  final List<Cloud> clouds;
  final double speed;
  final int score;
  final int highScore;
  final GameStatus status;
  final double groundOffset;

  static const double initialSpeed = 6.0;
  static const double maxSpeed = 15.0;
  static const double speedIncrement = 0.001;
  static const double minObstacleGap = 300.0;

  const GameState({
    required this.dino,
    required this.obstacles,
    required this.clouds,
    required this.speed,
    required this.score,
    required this.highScore,
    required this.status,
    required this.groundOffset,
  });

  factory GameState.initial(double groundLevel) {
    return GameState(
      dino: Dino(x: 50, y: groundLevel - Dino.dinoHeight),
      obstacles: [],
      clouds: [],
      speed: initialSpeed,
      score: 0,
      highScore: 0,
      status: GameStatus.waiting,
      groundOffset: 0,
    );
  }

  GameState copyWith({
    Dino? dino,
    List<Obstacle>? obstacles,
    List<Cloud>? clouds,
    double? speed,
    int? score,
    int? highScore,
    GameStatus? status,
    double? groundOffset,
  }) {
    return GameState(
      dino: dino ?? this.dino,
      obstacles: obstacles ?? this.obstacles,
      clouds: clouds ?? this.clouds,
      speed: speed ?? this.speed,
      score: score ?? this.score,
      highScore: highScore ?? this.highScore,
      status: status ?? this.status,
      groundOffset: groundOffset ?? this.groundOffset,
    );
  }

  bool get isPlaying => status == GameStatus.playing;
  bool get isGameOver => status == GameStatus.gameOver;
  bool get isWaiting => status == GameStatus.waiting;
}
