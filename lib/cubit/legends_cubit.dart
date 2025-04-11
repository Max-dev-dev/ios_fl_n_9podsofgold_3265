import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:ios_f_n_9potsofgold_3265/models/legends_model.dart';
import 'package:logger/logger.dart';

class LegendCubit extends Cubit<LegendState> {
  LegendCubit() : super(LegendInitial());

  Future<void> loadLegends() async {
    emit(LegendLoading());
    try {
      final String response = await rootBundle.loadString('assets/legends.json');
      final List<dynamic> data = json.decode(response);
      final legends = data.map((item) => LegendModel.fromJson(item)).toList();
      Logger().i('Legends is loaded');
      emit(LegendLoaded(legends));
    } catch (e) {
      Logger().e('Failed to load legends $e');
      emit(LegendError('Failed to load legends: $e'));
    }
  }
}

abstract class LegendState {}

class LegendInitial extends LegendState {}

class LegendLoading extends LegendState {}

class LegendLoaded extends LegendState {
  final List<LegendModel> legends;

  LegendLoaded(this.legends);
}

class LegendError extends LegendState {
  final String message;

  LegendError(this.message);
}

