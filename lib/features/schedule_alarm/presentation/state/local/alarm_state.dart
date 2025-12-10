part of 'alarm_cubit.dart';

@freezed
abstract class AlarmState with _$AlarmState {
  const factory AlarmState.initial() = _Initial;
  const factory AlarmState.loading() = _Loading;
  const factory AlarmState.success() = _Success;
  const factory AlarmState.error(String message) = _Error;
}
