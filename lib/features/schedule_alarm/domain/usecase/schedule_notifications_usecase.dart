import '../repository/notification_repository.dart';

class ScheduleNotificationsUseCase {
  final NotificationRepository _repository;

  ScheduleNotificationsUseCase(this._repository);

  Future<void> call() async {
    await _repository.scheduleNotifications();
  }

  Future<bool> requestPermissions() async {
    return await _repository.requestPermissions();
  }
}
