import 'package:flutter/material.dart';
import 'package:ios_f_n_9potsofgold_3265/models/principles_model.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/own_code_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/action_share_button.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';
import 'package:logger/web.dart';

class LuckPrinciplesScreen extends StatefulWidget {
  const LuckPrinciplesScreen({super.key});

  @override
  State<LuckPrinciplesScreen> createState() => _LuckPrinciplesScreenState();
}

class _LuckPrinciplesScreenState extends State<LuckPrinciplesScreen> {
  int? selectedIndex;

  final List<LuckPrinciple> allPrinciples = [
    LuckPrinciple(
      title: "The Golden Rule of Gratitude",
      description:
          "The more grateful you are for what you have, the more good things come into your life.",
      tip: "Start your day by listing three things you’re grateful for.",
    ),
    LuckPrinciple(
      title: "The Principle of Small Wins",
      description:
          "Every day is an opportunity to take a step forward. Small wins lead to big achievements.",
      tip: "Keep a success journal and record even your smallest victories.",
    ),
    LuckPrinciple(
      title: "The Secret of Generosity",
      description:
          "Generosity is a magnet for luck. Share resources, knowledge, and kindness – and you’ll receive more in return.",
      tip: "Find a way to help someone today – with advice, time, or action.",
    ),
    LuckPrinciple(
      title: "The Law of Pure Intentions",
      description:
          "True luck comes to those whose intentions are sincere and honest.",
      tip:
          "Before making a big decision, ask yourself: “What are my true motives?”",
    ),
    LuckPrinciple(
      title: "The Open Doors Rule",
      description:
          "The more opportunities you consider, the higher your chances of finding your luck.",
      tip:
          "Try something new – start a project, meet a new person, or change your routine.",
    ),
    LuckPrinciple(
      title: "The Energy of Action",
      description:
          "Dreams come true for those who act. Even a small step is better than inaction.",
      tip: "Pick one task you’ve been putting off and start it today.",
    ),
    LuckPrinciple(
      title: "The Art of Trusting Yourself",
      description:
          "Intuition is a key ally in finding luck. Learn to listen to it.",
      tip:
          "In tough situations, pay attention to your first instinct – it may lead you to the right decision.",
    ),
    LuckPrinciple(
      title: "The Balance of Luck",
      description:
          "Happiness is balance. Health, relationships, work, and rest should be in harmony.",
      tip:
          "Identify which area of your life needs more attention and take a step toward improving it.",
    ),
    LuckPrinciple(
      title: "The Principle of Play",
      description:
          "Lightness and joy are the best allies of luck. Those who see life as a game often win.",
      tip: "Approach tasks with curiosity and excitement instead of stress.",
    ),
    LuckPrinciple(
      title: "The Courage to Fail",
      description:
          "Every failure is a doorway to growth. Those who dare to lose are the ones who learn the most.",
      tip: "Try something bold today, even if you’re not sure of the outcome.",
    ),
    LuckPrinciple(
      title: "The Reflection Principle",
      description:
          "Self-awareness attracts luck by helping you align with what really matters.",
      tip:
          "Take 5 minutes to reflect on your actions and decisions from today.",
    ),
    LuckPrinciple(
      title: "The Power of Presence",
      description:
          "Luck often hides in the now. When you are truly present, you notice more opportunities.",
      tip:
          "Pause. Take a deep breath. Look around — what is one thing you can appreciate right now?",
    ),
    LuckPrinciple(
      title: "The Ripple Rule",
      description:
          "Small acts of kindness or progress ripple outward in unexpected ways.",
      tip:
          "Do one kind thing without expecting anything in return — it may return multiplied.",
    ),
    LuckPrinciple(
      title: "The Mindset of Growth",
      description:
          "Believing in your ability to grow makes you more resilient and lucky in the long run.",
      tip: "When something goes wrong, ask: 'What can I learn from this?'",
    ),
  ];

  final List<Color> allColors = const [
    Color(0xFFFE9F1A),
    Color(0xFFD4D946),
    Color(0xFFEC3100),
    Color(0xFFFFE3A4),
    Color(0xFFF64E6C),
    Color(0xFF33A2A6),
    Color(0xFF12B91A),
    Color(0xFF597A89),
    Color(0xFFB5FFA3),
  ];

  final rowItems = [
    [0, 1, 2, 13],
    [3, 4, 12],
    [5, 6, 11],
    [7, 8, 10],
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/code2.png', fit: BoxFit.cover),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: const StrokeText(
              text: 'The Code of Success',
              fontSize: 36.0,
            ),
            actions: const [ActionAppBar()],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                ...List.generate(4, (rowIndex) {
                  final itemIndexes = rowItems[rowIndex];
                  final initialScrollOffset =
                      (rowIndex == 1 || rowIndex == 3) ? 115.0 : 0.0;
                  return SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: itemIndexes.length,
                      controller: ScrollController(
                        initialScrollOffset: initialScrollOffset,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final i = itemIndexes[index];
                        final item = allPrinciples[i];
                        final bgColor = allColors[i % allColors.length];
                        final isSelected = selectedIndex == i;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = i;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 250,
                            height: 70,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow:
                                  isSelected
                                      ? [
                                        const BoxShadow(
                                          color: Color(0xFFFBFF26),
                                          blurRadius: 12,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                      : [],
                            ),
                            child: Center(
                              child: Text(
                                item.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                const Spacer(),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (selectedIndex != null) {
                        final item = allPrinciples[selectedIndex!];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => OwnCodeScreen(principleItem: item),
                          ),
                        );
                      } else {
                        Logger().i('Selected index = null');
                      }
                    },

                    child: Container(
                      width: 282,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            selectedIndex != null
                                ? const Color(0xFFFF7B00)
                                : Colors.grey,
                            selectedIndex != null
                                ? const Color(0xFFFFE924)
                                : Colors.grey,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Center(
                        child: Text(
                          'Explore',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
