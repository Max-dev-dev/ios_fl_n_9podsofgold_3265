// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/legends/correct_answer_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/legends/legends_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/legends/wrong_answer_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/tabs_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/action_share_button.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';

class RiddleScreen extends StatefulWidget {
  final String wisdom;
  const RiddleScreen({required this.wisdom, super.key});

  @override
  State<RiddleScreen> createState() => _RiddleScreenState();
}

class _RiddleScreenState extends State<RiddleScreen> {
  late Riddle _riddle;
  int? _selectedIndex;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _riddle = riddles[Random().nextInt(riddles.length)];
  }

  void _onAnswerTap(int index) {
    if (_answered) return;

    setState(() {
      _selectedIndex = index;
      _answered = true;
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (index == _riddle.correctIndex) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CorrectAnswerScreen(wisdom: widget.wisdom),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WrongAnswerScreen(wisdom: widget.wisdom),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/wisdom_back.png',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: const StrokeText(
              text: 'Leprechaun’s riddle',
              fontSize: 24.0,
            ),
            actions: const [ActionAppBar()],
          ),
          body: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenWidth > 375 ? 200 : 150),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: SizedBox(
                        width: 200,
                        child: StrokeText(
                          text: _riddle.question,
                          fontSize: 20,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ...List.generate(_riddle.answers.length, (index) {
                final isCorrect = index == _riddle.correctIndex;
                final isSelected = index == _selectedIndex;

                Color backgroundColor = const Color(0xFFFFD12F);
                if (_answered && isSelected) {
                  backgroundColor = isCorrect ? Colors.green : Colors.red;
                }

                return GestureDetector(
                  onTap: () => _onAnswerTap(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    width: 260,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors:
                            isSelected && _answered
                                ? [backgroundColor, backgroundColor]
                                : [
                                  const Color(0xFFFFD12F),
                                  const Color(0xFFFF7B00),
                                ],
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        _riddle.answers[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const Spacer(),

              Center(
                child: GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TabsScreen(initialTabIndex: 2,),
                        ),
                      ),
                  child: Container(
                    width: 282,
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
                        'Return to the myths',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenWidth > 375 ? 80 : 10),
            ],
          ),
        ),
      ],
    );
  }
}

class Riddle {
  final String question;
  final List<String> answers;
  final int correctIndex;

  Riddle({
    required this.question,
    required this.answers,
    required this.correctIndex,
  });
}

final List<Riddle> riddles = [
  Riddle(
    question: "What is always in your hands, but you can never hold it?",
    answers: ["Water", "Time", "Stone"],
    correctIndex: 1,
  ),
  Riddle(
    question: "What can you catch, but can’t see?",
    answers: ["Dream", "Happiness", "Wind"],
    correctIndex: 1,
  ),
  Riddle(
    question: "The more you take, the more you leave behind. What is it?",
    answers: ["Steps", "Memories", "Shadows"],
    correctIndex: 0,
  ),
  Riddle(
    question: "What grows, but never goes away?",
    answers: ["Leaves", "Haircuts", "Friends"],
    correctIndex: 2,
  ),
  Riddle(
    question: "Where can there be an end, but no beginning?",
    answers: ["River", "Circle", "Sand"],
    correctIndex: 1,
  ),
  Riddle(
    question: "What is always with you, but never feels you?",
    answers: ["Shadow", "Spirit", "Air"],
    correctIndex: 1,
  ),
  Riddle(
    question:
        "If you drop me, I remain whole. If you cut me, I vanish. What am I?",
    answers: ["Secret", "Mirror", "Glass"],
    correctIndex: 0,
  ),
  Riddle(
    question: "The more I give, the more I have. What is it?",
    answers: ["Happiness", "Gold", "Leaves"],
    correctIndex: 0,
  ),
  Riddle(
    question: "Who always moves forward but never moves?",
    answers: ["Sun", "Clock", "Wind"],
    correctIndex: 1,
  ),
];
