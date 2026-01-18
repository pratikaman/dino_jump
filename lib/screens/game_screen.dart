import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update screen size in provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      ref.read(screenSizeProvider.notifier).state = Size(size.width, size.height);
    });
  }

  void _handleTap() {
    final gameNotifier = ref.read(gameProvider.notifier);
    final status = ref.read(gameStatusProvider);

    if (status == GameStatus.gameOver) {
      gameNotifier.restart();
    } else {
      gameNotifier.jump();
    }
  }

  void _handleVerticalDragStart(DragStartDetails details) {
    ref.read(gameProvider.notifier).duck(true);
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    ref.read(gameProvider.notifier).duck(false);
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);
    final groundLevel = ref.watch(groundLevelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: GestureDetector(
        onTap: _handleTap,
        onVerticalDragStart: _handleVerticalDragStart,
        onVerticalDragEnd: _handleVerticalDragEnd,
        onVerticalDragCancel: () => ref.read(gameProvider.notifier).duck(false),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            // Clouds (background)
            ...gameState.clouds.map(
              (cloud) => CloudWidget(key: ValueKey(cloud.hashCode), cloud: cloud),
            ),

            // Ground
            GroundWidget(
              groundLevel: groundLevel,
              offset: gameState.groundOffset,
            ),

            // Obstacles
            ...gameState.obstacles.map(
              (obstacle) => ObstacleWidget(
                key: ValueKey(obstacle.hashCode),
                obstacle: obstacle,
              ),
            ),

            // Dino
            DinoWidget(dino: gameState.dino),

            // Score
            const ScoreWidget(),

            // Start screen
            if (gameState.isWaiting) const StartWidget(),

            // Game over screen
            if (gameState.isGameOver)
              GameOverWidget(
                onRestart: () => ref.read(gameProvider.notifier).restart(),
              ),
          ],
        ),
      ),
    );
  }
}
