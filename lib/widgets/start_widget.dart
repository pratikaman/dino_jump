import 'package:flutter/material.dart';

class StartWidget extends StatelessWidget {
  const StartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'DINO JUMP',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF535353),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'TAP TO START',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 18,
              color: Color(0xFF757575),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'TAP to jump | SWIPE DOWN to duck',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }
}
