import 'package:flutter/material.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/luck_principles.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/action_share_button.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';

class CodeOfSuccessScreen extends StatelessWidget {
  const CodeOfSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/code.png', fit: BoxFit.cover),
        ),
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: StrokeText(
              text: screenWidth > 375 ? 'The Code of Success' : 'The Code of...',
              fontSize: 36.0,
            ),
            actions: const [ActionAppBar()],
          ),
          body: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                          'See the principles',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
