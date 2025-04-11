import 'package:flutter/material.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/action_share_button.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';

class HarmonyAdvicerScreen extends StatefulWidget {
  final String category;

  const HarmonyAdvicerScreen({required this.category, super.key});

  @override
  State<HarmonyAdvicerScreen> createState() => _HarmonyAdvicerScreenState();
}

class _HarmonyAdvicerScreenState extends State<HarmonyAdvicerScreen> {
  int currentIndex = 0;

  late final List<String> advices;

  @override
  void initState() {
    super.initState();
    advices = _getAdvicesForCategory(widget.category);
  }

  List<String> _getAdvicesForCategory(String category) {
    switch (category) {
      case 'Career':
        return [
          '📌 Tasks and recommendations:\n\n• Task: "Weekly Planning". Plan your most important work tasks for the week.\n\n• Task: "Set Career Goals for 3 Months". Write down what you want to achieve in your career and define the steps to reach those goals.',
          '📌 Planning Time — The Key to Success\n\nBefore starting any workday, take 10-15 minutes to plan. This can include making a list of tasks for the day, week, or even month. It’s important not only to write down tasks but to prioritize and set clear deadlines. This approach will help you avoid chaos, manage your time efficiently, and reach your goals. Start the day by focusing on the most important tasks and then move on to the less significant ones.',
          '📌 Lifelong Skill Development\n\nNever stop learning. Even if you’ve reached a high level in your profession, continue to educate yourself. Constantly improving your skills and knowledge makes you a more valuable professional and opens up new career opportunities. This can involve extra education or enhancing personal qualities such as time management, negotiation skills, or leadership.',
          '📌 Networking — Expand Your Circle\n\nDon’t underestimate the power of networking. Interact with colleagues, partners, and others in your field. This will not only open new career opportunities but also help you grow personally. Remember, luck often comes through the connections we make.',
        ];
      case 'Personal life':
        return [
          '📌 Tasks:\n\n• Task 1: "Plan a device-free evening" — Plan an evening without your phone or other technologies, and spend time with your loved ones.\n\n• Task 2: "Spend 10 minutes in silence, focusing on yourself" — Set aside time for yourself, practicing mindfulness and relaxation.',
          '📌 Listen, Don’t Just Speak\n\nOne of the key aspects of successful relationships is the ability to listen. We often focus on expressing our own opinions or sharing our emotions, but it’s important to learn to hear the other person. Practice active listening: ask questions, confirm understanding, and don’t interrupt. This will create an atmosphere of trust and open up new opportunities for strengthening relationships.',
          '📌 Time for Yourself — The Foundation of Healthy Relationships\n\nSometimes we forget that personal space is important not just for us, but for our loved ones too. Set aside time for yourself, for hobbies, rest, and recovery. This will help you not only maintain inner harmony but also be more attentive and caring in relationships. When we are in good shape, we can give more to others.',
          '📌 Don’t Be Afraid to Be Vulnerable\n\nTrue closeness is impossible without openness and vulnerability. Be sincere, express your true emotions and feelings. This creates a solid foundation for trust. Sometimes it’s important to say, “I feel vulnerable,” or share difficult emotions. This will deepen your relationship and bring you closer together.',
        ];
      case 'Health':
        return [
          '📌 Tasks:\n\n• Task 1: "Go for a run or practice yoga for 15 minutes" — Suggestion to start the day with physical activity.\n\n• Task 2: "Try a new healthy recipe" — Advice on how to incorporate more vegetables or nutritious foods into your diet.',
          '📌 Start with Small Steps\n\nHealth is not just about physical condition, but a lifestyle overall. Don’t try to make drastic changes all at once. Start with small steps: add one healthy habit a day, like drinking more water, walking for 15 minutes daily, or reducing sugar intake. Gradually, you’ll get used to these changes, and they’ll become an integral part of your life.',
          '📌 Practice Mindfulness\n\nMindfulness is a practice that helps improve mental health, reduce stress, and anxiety. Find a few minutes each day to meditate or simply focus on your breathing. Listen to your body and the surrounding sounds and sensations. This practice helps not only preserve mental health but also enhances overall life harmony.',
          '📌 Balanced Diet — The Key to Long-Term Health\n\nMaintaining health is impossible without proper nutrition. Forget about short-term diets and focus on a long-term healthy eating strategy. Your menu should be diverse, include all the necessary vitamins and minerals, and keep your energy level steady throughout the day. Add more vegetables, whole grains, and proteins to your diet, while avoiding processed and overly sugary foods.',
        ];
      default:
        return ['No advices available.'];
    }
  }

  void _nextAdvice() {
    if (currentIndex < advices.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  String _getButtonText() {
    if (currentIndex == 0) return 'Get Advice';
    if (currentIndex < advices.length - 1) return 'Next';
    return 'Back to categories';
  }

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
            title: StrokeText(text: widget.category, fontSize: 36.0),
            actions: const [ActionAppBar()],
          ),
          body: Column(
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  advices[currentIndex],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.6,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _nextAdvice,
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
                  child: Center(
                    child: Text(
                      _getButtonText(),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60.0),
            ],
          ),
        ),
      ],
    );
  }
}
