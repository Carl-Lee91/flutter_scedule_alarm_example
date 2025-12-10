import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecase/schedule_notifications_usecase.dart';

part 'alarm_cubit.freezed.dart';
part 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  final ScheduleNotificationsUseCase _scheduleNotificationsUseCase;

  AlarmCubit(this._scheduleNotificationsUseCase)
    : super(const AlarmState.initial());

  Future<void> scheduleAlarm() async {
    emit(const AlarmState.loading());
    try {
      final hasPermission = await _scheduleNotificationsUseCase
          .requestPermissions();
      if (!hasPermission) {
        emit(const AlarmState.error('Permissions not granted'));
        return;
      }

      await _scheduleNotificationsUseCase();
      emit(const AlarmState.success());
    } catch (e) {
      emit(AlarmState.error(e.toString()));
    }
  }
}
