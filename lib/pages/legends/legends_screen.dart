import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_9potsofgold_3265/cubit/legends_cubit.dart';
import 'package:ios_f_n_9potsofgold_3265/models/legends_model.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/legends/wisdom_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/action_share_button.dart';
import 'package:ios_f_n_9potsofgold_3265/widgets/stroke_text.dart';

class LegendsScreen extends StatefulWidget {
  const LegendsScreen({super.key});

  @override
  State<LegendsScreen> createState() => _LegendsScreenState();
}

class _LegendsScreenState extends State<LegendsScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  final ValueNotifier<int> _currentPageIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    context.read<LegendCubit>().loadLegends();

    _pageController.addListener(() {
      final page = _pageController.page ?? 0.0;
      _currentPageIndex.value = page.round();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageIndex.dispose();
    super.dispose();
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
            automaticallyImplyLeading: false,
            centerTitle: true,
            toolbarHeight: 80,
            title: const StrokeText(
              text: 'Collection of Myths and Legends',
              fontSize: 32.0,
            ),
            actions: const [ActionAppBar()],
          ),
          body: BlocBuilder<LegendCubit, LegendState>(
            builder: (context, state) {
              if (state is LegendLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LegendLoaded) {
                final legends = state.legends;

                return Column(
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      "Explore ancient myths and legends\nabout leprechauns, treasures, and magical creatures.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ValueListenableBuilder<int>(
                      valueListenable: _currentPageIndex,
                      builder: (context, index, _) {
                        final title =
                            index < legends.length ? legends[index].title : '';
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: StrokeText(text: title, fontSize: 22),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: legends.length,
                        itemBuilder: (context, index) {
                          final legend = legends[index];
                          final isFocused = index == _currentPageIndex.value;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(legend.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(24),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => LegendDetailScreen(
                                            legend: legend,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder<int>(
                      valueListenable: _currentPageIndex,
                      builder: (context, currentIndex, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(legends.length, (index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: index == currentIndex ? 14 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color:
                                    index == currentIndex
                                        ? Colors.amber
                                        : Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            );
                          }),
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        final selectedLegend = legends[_currentPageIndex.value];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    LegendDetailScreen(legend: selectedLegend),
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
                            'Explore',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              } else if (state is LegendError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}

class LegendDetailScreen extends StatelessWidget {
  final LegendModel legend;

  const LegendDetailScreen({super.key, required this.legend});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/code2.png', fit: BoxFit.cover),
        ),
        Scaffold(
          backgroundColor: const Color(0xFF0B3722),
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: StrokeText(text: legend.title, fontSize: 24.0),
            actions: const [ActionAppBar()],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Text(
                  legend.text,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                const Center(
                  child: StrokeText(
                    text: "Hear the wisdom of the leprechaun",
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    WisdomScreen(widsom: legend.wisdom),
                          ),
                        ),
                    child: Container(
                      width: 282,
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
                          'Hear',
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
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
