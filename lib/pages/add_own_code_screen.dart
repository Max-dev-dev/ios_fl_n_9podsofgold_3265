import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_9potsofgold_3265/models/principles_model.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/luck_principles.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/action_share_button.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOwnCodeScreen extends StatefulWidget {
  final LuckPrinciple principleItem;
  const AddOwnCodeScreen({required this.principleItem, super.key});

  @override
  State<AddOwnCodeScreen> createState() => _AddOwnCodeScreenState();
}

class _AddOwnCodeScreenState extends State<AddOwnCodeScreen> {
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

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<DescriptionsCubit>();
    final existing = cubit.getDescription(widget.principleItem.title) ?? '';
    _controller = TextEditingController(text: existing);
  }

  @override
  Widget build(BuildContext context) {
    final colorIndex =
        allPrinciples.indexWhere((p) => p.title == widget.principleItem.title) %
        allColors.length;

    final color = allColors[colorIndex];
    final descriptionCubit = context.read<DescriptionsCubit>();

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
              text: 'Your Personal Code of Success.',
              fontSize: 24.0,
            ),
            actions: const [ActionAppBar()],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      widget.principleItem.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Add your description to better understand the\nprinciples of Luck and Prosperity.",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  onChanged: (value) {
                    descriptionCubit.updateDescription(
                      widget.principleItem.title,
                      value,
                    );
                  },
                  maxLines: 6,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Your own code of success',
                    hintStyle: const TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFFFCD3F)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFFFCD3F)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: color, width: 2),
                    ),
                  ),
                ),

                const Spacer(),
                Center(
                  child: GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LuckPrinciplesScreen(),
                          ),
                        ),
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
                          'Add more',
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

class DescriptionsCubit extends Cubit<Map<String, String>> {
  final SharedPreferences prefs;
  static const _key = 'user_descriptions';

  DescriptionsCubit(this.prefs) : super({}) {
    _load();
  }

  void _load() {
    final data = prefs.getString(_key);
    if (data != null) {
      emit(Map<String, String>.from(jsonDecode(data)));
    }
  }

  void updateDescription(String title, String description) {
    final updated = Map<String, String>.from(state);
    updated[title] = description;
    emit(updated);
    prefs.setString(_key, jsonEncode(updated));
  }

  String? getDescription(String title) => state[title];

  void resetProgress() {
    prefs.remove(_key);
    emit({});
  }
}
