# Dino Jump

A mobile app version of the classic Chrome Dino game built with Flutter and Riverpod state management.

## Features

- Classic endless runner gameplay
- Jump to avoid cacti obstacles
- Duck to avoid flying birds (appear after score 200)
- Progressive difficulty - speed increases over time
- High score tracking
- Smooth animations and pixel-art style graphics

## Controls

- **Tap** anywhere to jump
- **Swipe down** to duck (useful for avoiding birds)

## Tech Stack

- **Flutter** - Cross-platform mobile framework
- **Riverpod** - State management solution
- **CustomPainter** - For rendering game graphics

## Project Structure

```
lib/
├── main.dart              # App entry point
├── models/                # Game data models
│   ├── dino.dart          # Dinosaur player model
│   ├── obstacle.dart      # Cactus and bird obstacles
│   ├── cloud.dart         # Background clouds
│   ├── game_object.dart   # Base class for game objects
│   └── game_state.dart    # Complete game state
├── providers/             # Riverpod providers
│   └── game_provider.dart # Game state management
├── screens/               # App screens
│   └── game_screen.dart   # Main game screen
└── widgets/               # UI components
    ├── dino_widget.dart   # Dino renderer
    ├── obstacle_widget.dart
    ├── cloud_widget.dart
    ├── ground_widget.dart
    ├── score_widget.dart
    ├── game_over_widget.dart
    └── start_widget.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

### Running Tests

```bash
flutter test
```

## Game Mechanics

- The dino automatically runs forward (represented by scrolling ground)
- Obstacles spawn randomly from the right side
- Collision detection uses slightly reduced hitboxes for forgiving gameplay
- Speed gradually increases up to a maximum limit
- Birds only appear after reaching a score of 200

## License

MIT License
