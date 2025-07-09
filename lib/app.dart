import 'package:flutter/material.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/onboarding_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/tabs_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/ver_screen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  final AudioPlayer _player = AudioPlayer();
  bool _isMusicOn = true;

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isMusicOn = prefs.getBool('isMusicOn') ?? true;
    if (_isMusicOn) {
      await _player.setAsset('assets/music.mp3');
      _player.setLoopMode(LoopMode.one);
      _player.play();
    }
  }

  void toggleMusic(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isMusicOn = value;
    await prefs.setBool('isMusicOn', _isMusicOn);
    if (_isMusicOn) {
      await _player.play();
    } else {
      await _player.pause();
    }
  }

  bool get isMusicOn => _isMusicOn;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F5F31), Color(0xFF0B3722)],
          ),
        ),
        child: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    AudioManager().init();
    _checkFirstRun();
  }

  Future<void> _checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('first_run') ?? true;

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  isFirstRun ? const OnboardingScreen() : const TabsScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF272727),
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/splash_screen.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
