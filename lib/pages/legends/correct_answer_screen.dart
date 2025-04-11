import 'package:flutter/material.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/tabs_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/action_share_button.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';

class CorrectAnswerScreen extends StatelessWidget {
  final String wisdom;
  const CorrectAnswerScreen({required this.wisdom, super.key});

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
          body: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenWidth > 375 ? 200 : 150),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: 200,
                    child: StrokeText(
                      text:
                          '“Well, you’re not just clever, you’re a true seeker of luck! ”',
                      fontSize: 20,
                      maxLines: 2,
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
        ),
      ],
    );
  }
}
