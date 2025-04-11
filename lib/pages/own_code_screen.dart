import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_9potsofgold_3265/models/principles_model.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/add_own_code_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/action_share_button.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnCodeScreen extends StatefulWidget {
  final LuckPrinciple principleItem;
  const OwnCodeScreen({required this.principleItem, super.key});

  @override
  State<OwnCodeScreen> createState() => _LuckPrinciplesScreenState();
}

class _LuckPrinciplesScreenState extends State<OwnCodeScreen> {
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
              text: 'The Golden Rule of Gratitude',
              fontSize: 24.0,
            ),
            actions: const [ActionAppBar()],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                StrokeText(
                  text: '"${widget.principleItem.description}"',
                  fontSize: 26.0,
                ),
                const SizedBox(height: 100),
                const Text(
                  '📌 How to apply:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.principleItem.tip,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                const Spacer(),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AddOwnCodeScreen(
                                principleItem: widget.principleItem,
                              ),
                        ),
                      );
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
                          'Create your own code',
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

