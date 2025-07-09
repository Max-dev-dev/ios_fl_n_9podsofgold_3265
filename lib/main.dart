import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_9potsofgold_3265/app.dart';
import 'package:ios_f_n_9potsofgold_3265/cubit/legends_cubit.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/add_own_code_screen.dart';
import 'package:ios_f_n_9potsofgold_3265/ver_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static const String oneSignalAppId = "a1197632-0eae-4d19-bf26-1a969a79e91d";
  static const String appsFlyerDevKey = "EsJBZj76R5fCiere38Z6Dd";
  static const String appID = "6748387699";

  static const String baseDomain = "exquisite-honored-triumphant.space";
  static const String verificationParam = "LrASE2bc";

  static const String splashImagePath = 'assets/images/splash_screen.png';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final now = DateTime.now();
  final dateOff = DateTime(2024, 7, 14, 20, 00);

  final initialRoute = now.isBefore(dateOff) ? '/white' : '/verify';
  runApp(RootApp(
    initialRoute: initialRoute,
    whiteScreen: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DescriptionsCubit(prefs)),
        BlocProvider(create: (context) => LegendCubit()),
      ],
      child: const MainApp(),
    ),
  ));
}

