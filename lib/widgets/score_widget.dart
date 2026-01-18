import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class ScoreWidget extends ConsumerWidget {
  const ScoreWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(scoreProvider);
    final highScore = ref.watch(highScoreProvider);

    return Positioned(
      top: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (highScore > 0)
            Text(
              'HI ${highScore.toString().padLeft(5, '0')}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF757575),
              ),
            ),
          Text(
            score.toString().padLeft(5, '0'),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF535353),
            ),
          ),
        ],
      ),
    );
  }
}
