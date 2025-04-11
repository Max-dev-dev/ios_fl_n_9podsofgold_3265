import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_9potsofgold_3265/app.dart';
import 'package:ios_f_n_9potsofgold_3265/cubit/legends_cubit.dart';
import 'package:ios_f_n_9potsofgold_3265/pages/add_own_code_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DescriptionsCubit(prefs)),
        BlocProvider(create: (context) => LegendCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

