import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/code_of_success_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/game/game_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/harmony_of_life_tab/harmony_of_life_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/legends/legends_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/settings_screen.dart';

class TabsScreen extends StatefulWidget {
  final int initialTabIndex;

  const TabsScreen({super.key, this.initialTabIndex = 2});

  @override
  HomeScreenState createState() => HomeScreenState();
}

final GlobalKey<HomeScreenState> homeScreenKey = GlobalKey<HomeScreenState>();

class HomeScreenState extends State<TabsScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex;
  }

  final List<Widget> _screens = [
    const GameScreen(),
    const CodeOfSuccessScreen(),
    const LegendsScreen(),
    const HarmonyOfLifeScreen(),
    const SettingScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigateToQuizStartTab() {
    setState(() {
      _selectedIndex = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Color(0xFF0B3722)),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Color(0xFFFF4500),
          unselectedItemColor: const Color(0xFF7DA48C),
          currentIndex: _selectedIndex,
          onTap: onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
             BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.gamepad),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.book),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.layerGroup),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.tableCellsLarge),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.gear),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
