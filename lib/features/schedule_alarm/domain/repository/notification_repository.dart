abstract class NotificationRepository {
  Future<void> scheduleNotifications();
  Future<void> cancelAllNotifications();
  Future<bool> requestPermissions();
}
