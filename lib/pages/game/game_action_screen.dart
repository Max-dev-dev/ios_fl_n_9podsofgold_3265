import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/tabs_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameActionScreen extends StatefulWidget {
  const GameActionScreen({super.key});

  @override
  State<GameActionScreen> createState() => _GameActionScreenState();
}

class _GameActionScreenState extends State<GameActionScreen> {
  int highScore = 0;
  double playerX = 0;
  double fallingY = -1;
  double fallingX = 0;
  String fallingObject = 'gold';
  int score = 0;
  Timer? gameTimer;
  bool isGameOver = false;

  Future<void> loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      highScore = prefs.getInt('high_score') ?? 0;
    });
  }

  Future<void> updateHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    if (score > highScore) {
      highScore = score;
      await prefs.setInt('high_score', highScore);
    }
  }

  void startGame() {
    fallingY = -1;
    fallingX = getRandomX();
    fallingObject = getRandomObject();

    gameTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        fallingY += 0.02;

        if (fallingY >= 0.9) {
          final caught = (fallingX - playerX).abs() < 0.2;

          if (caught && fallingObject == 'gold') {
            score += 10;
            resetFallingObject();
          } else if (caught && fallingObject == 'rock') {
            endGame();
          } else if (!caught && fallingObject == 'gold') {
            endGame();
          } else {
            resetFallingObject();
          }
        }
      });
    });
  }

  void endGame() async {
    gameTimer?.cancel();
    isGameOver = true;

    await updateHighScore();

    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            backgroundColor: const Color(0xFF0F5F31),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const StrokeText(
                    text: 'Luck turned its back…\n Time to chase it down!',
                    fontSize: 28,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 30.0),
                  Image.asset('assets/images/game_assets/clerk.png'),
                  const SizedBox(height: 30.0),
                  Center(
                    child: GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GameActionScreen(),
                            ),
                          ),
                      child: Container(
                        width: 280,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFFF7B00), Color(0xFFFFE924)],
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Text(
                            'Try again',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const TabsScreen(initialTabIndex: 0),
                            ),
                          ),
                      child: Container(
                        width: 280,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFE52300), Color(0xFFFF9A1A)],
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Text(
                            'Return to main',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void resetGame() {
    setState(() {
      score = 0;
      playerX = 0;
      isGameOver = false;
    });
    startGame();
  }

  void resetFallingObject() {
    fallingY = -1;
    fallingX = getRandomX();
    fallingObject = getRandomObject();
  }

  double getRandomX() {
    return (Random().nextDouble() * 2 - 1);
  }

  String getRandomObject() {
    return Random().nextBool() ? 'gold' : 'rock';
  }

  void movePlayer(bool left) {
    setState(() {
      playerX += left ? -0.2 : 0.2;
      if (playerX < -1) playerX = -1;
      if (playerX > 1) playerX = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    loadHighScore();
    startGame();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/game_back.png', fit: BoxFit.cover),
        ),
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                if (screenWidth <= 375)
                  Positioned(
                    bottom: 0,
                    left: 0.1,
                    right: 0.1,
                    child: Container(
                      width: double.infinity,
                      height: 160,
                      decoration: const BoxDecoration(color: Color(0xFF0B3722)),
                    ),
                  ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/game_assets/gold.png',
                        width: 24,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$score',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).size.height * fallingY / 2 + 50,
                  left: screenWidth / 2 + screenWidth * fallingX / 2 - 25,
                  child: Image.asset(
                    'assets/images/game_assets/${fallingObject == 'gold' ? 'gold' : 'rock'}.png',
                    width: 50,
                  ),
                ),

                Positioned(
                  bottom: 160,
                  left: screenWidth / 2 + screenWidth * playerX / 2 - 40,
                  child: Image.asset(
                    'assets/images/game_assets/men.png',
                    width: 80,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildControlButton(
                        icon: Icons.arrow_left,
                        onPressed: () => movePlayer(true),
                      ),
                      const SizedBox(width: 20),
                      buildControlButton(
                        icon: Icons.arrow_right,
                        onPressed: () => movePlayer(false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFEB3B), Color(0xFFFF9800)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF1B5E20), size: 30),
      ),
    );
  }
}
