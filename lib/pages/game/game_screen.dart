import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/game/game_action_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/action_share_button.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int highScore = 0;

  @override
  void initState() {
    super.initState();
    loadHighScore();
  }

  Future<void> loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      highScore = prefs.getInt('high_score') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/wisdom_back.png',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            backgroundColor: Colors.transparent,
            title: const StrokeText(
              text: 'Leprechaun and Gold',
              fontSize: 36.0,
            ),
            actions: const [ActionAppBar()],
          ),
          body: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenWidth > 375 ? 120 : 80),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: 200,
                    child: StrokeText(
                      text:
                          'Catch the golden clovers, avoid rocks, and collect the pots of gold to score points.',
                      fontSize: 20,
                      maxLines: 4,
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: StrokeText(
                    text: 'Best Score: $highScore',
                    fontSize: 30,
                    maxLines: 4,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameActionScreen(),
                        ),
                      ).then((_) => loadHighScore()); // reload best score after returning
                    },
                    child: Container(
                      width: 282,
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
                          'Start',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
