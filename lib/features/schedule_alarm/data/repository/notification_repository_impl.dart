import '../../domain/repository/notification_repository.dart';
import '../datasource/local_notification_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final LocalNotificationSource _source;

  NotificationRepositoryImpl(this._source);

  @override
  Future<void> scheduleNotifications() async {
    await _source.scheduleNotifications();
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _source.cancelAll();
  }

  @override
  Future<bool> requestPermissions() async {
    return await _source.requestPermissions();
  }
}
