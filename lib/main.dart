import 'package:advertising_id/advertising_id.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
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

const String _fallbackIdfa = '00000000-0000-0000-0000-000000000000';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Отримуємо SharedPreferences одразу
  final prefs = await SharedPreferences.getInstance();

  // 1) Запитуємо ATT-права до запуску UI
  final status = await AppTrackingTransparency.requestTrackingAuthorization();
  debugPrint('ATT status: $status');

  String newIdfa;
  if (status == TrackingStatus.authorized) {
    try {
      newIdfa = await AdvertisingId.id(true) ?? _fallbackIdfa;
    } catch (_) {
      newIdfa = _fallbackIdfa;
    }
  } else {
    newIdfa = _fallbackIdfa;
  }

  // 2) Зберігаємо IDFA в prefs
  await prefs.setString('advertising_id', newIdfa);
  debugPrint('Saved IDFA: $newIdfa');

  // 3) Обчислюємо initialRoute
  final now = DateTime.now();
  final dateOff = DateTime(2024, 7, 14, 20, 00);
  final initialRoute = now.isBefore(dateOff) ? '/white' : '/verify';

  // 4) Запускаємо додаток
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

