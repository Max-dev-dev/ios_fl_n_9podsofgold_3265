import 'package:flutter/material.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/harmony_of_life_tab/harmony_advicer_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/action_share_button.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';

class HarmonyCategoryScreen extends StatefulWidget {
  const HarmonyCategoryScreen({super.key});

  @override
  State<HarmonyCategoryScreen> createState() => _HarmonyCategoryScreenState();
}

class _HarmonyCategoryScreenState extends State<HarmonyCategoryScreen> {
  String? selectedCategory;

  final List<String> categories = ['Career', 'Personal life', 'Health'];

  void _onCategoryTap(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _onPick() {
    if (selectedCategory != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HarmonyImageScreen(category: selectedCategory!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category first.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    }
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
            title: const StrokeText(text: 'Harmony of Life', fontSize: 36.0),
            actions: const [ActionAppBar()],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100.0),
              Center(
                child: Column(
                  children:
                      categories.map((category) {
                        final isSelected = selectedCategory == category;
                        return GestureDetector(
                          onTap: () => _onCategoryTap(category),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            width: 282,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFFF7B00), Color(0xFFFFE924)],
                              ),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow:
                                  isSelected
                                      ? const [
                                        BoxShadow(
                                          color: Color(0xFFFBFF26),
                                          blurRadius: 12,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                      : [],
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
              const Spacer(),
              Center(
                child: GestureDetector(
                  onTap: _onPick,
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
                        'Pick',
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
      ],
    );
  }
}

class HarmonyImageScreen extends StatelessWidget {
  final String category;

  const HarmonyImageScreen({super.key, required this.category});

  String _getImagePath() {
    switch (category) {
      case 'Career':
        return 'assets/images/category/1.png';
      case 'Personal life':
        return 'assets/images/category/2.png';
      case 'Health':
        return 'assets/images/category/3.png';
      default:
        return 'assets/images/category/1.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = _getImagePath();
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.cover)),
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: StrokeText(text: category, fontSize: 36.0),
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
                            builder: (context) => HarmonyAdvicerScreen(category: category),
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
                          'Get a task',
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
