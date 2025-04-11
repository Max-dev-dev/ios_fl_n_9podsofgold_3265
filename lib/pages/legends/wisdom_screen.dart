import 'package:flutter/material.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/legends/legends_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/legends/ridle_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/tabs_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/action_share_button.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';

class WisdomScreen extends StatelessWidget {
  final String widsom;
  const WisdomScreen({required this.widsom, super.key});

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
              text: 'Leprechaun’s wisdom for you',
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: 200,
                    child: StrokeText(text: widsom, fontSize: 20, maxLines: 2),
                  ),
                ),
                const Spacer(),
                Center(
                  child: GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RiddleScreen(wisdom: widsom),
                          ),
                        ),
                    child: Container(
                      width: 230,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF7B00), Color(0xFFFFE924)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Center(
                        child: Text(
                          'Solve the riddle',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
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
