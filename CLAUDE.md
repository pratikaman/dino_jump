# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Build for platforms
flutter build apk       # Android
flutter build ios       # iOS
flutter build web       # Web
```

## Architecture Overview

This is a Flutter mobile game - a recreation of the Chrome Dinosaur endless runner game using Riverpod for state management and CustomPaint for all graphics rendering (no image assets).

### State Management (Riverpod)

The app uses Riverpod's `StateNotifier` pattern with this provider hierarchy:

```
screenSizeProvider (StateProvider<Size>)
    ↓
groundLevelProvider (Provider<double>)
    ↓
gameProvider (StateNotifierProvider<GameNotifier, GameState>)
    ├── scoreProvider (derived)
    ├── highScoreProvider (derived)
    └── gameStatusProvider (derived)
```

**GameNotifier** (`lib/providers/game_provider.dart`) manages the entire game loop:
- Runs at 60fps using `Timer.periodic` (16ms intervals)
- Handles obstacle spawning, collision detection, physics updates
- Updates state immutably via `copyWith` pattern

### Game Models

All models in `lib/models/`:
- **GameObject** - Base class with position, dimensions, and AABB collision (5px padding for forgiving gameplay)
- **Dino** - Player with gravity (1.2), jump velocity (-18.0), running/jumping/ducking states
- **Obstacle** - SmallCactus, LargeCactus, Bird (birds unlock at score > 200)
- **GameState** - Immutable state container with `waiting`, `playing`, `gameOver` status
- **Cloud** - Decorative background element moving at 30% game speed

### Rendering

All graphics use `CustomPaint` with dedicated Painter classes in `lib/widgets/`. No external image assets - everything is drawn on Canvas.

### Code Patterns

- **Barrel exports**: Each directory has an export file (e.g., `models.dart`, `widgets.dart`) for clean imports
- **Immutability**: GameState uses `copyWith()` for all updates
- **Optimized rebuilds**: Derived providers use `.select()` to minimize widget rebuilds

### Game Constants

```dart
initialSpeed = 6.0       // Starting velocity
maxSpeed = 15.0          // Cap
speedIncrement = 0.001   // Per-frame increase
minObstacleGap = 300.0   // Minimum pixels between obstacles
```
