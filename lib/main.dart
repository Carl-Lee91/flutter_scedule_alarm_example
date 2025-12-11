import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'features/schedule_alarm/data/datasource/local_notification_source.dart';
import 'features/schedule_alarm/data/repository/notification_repository_impl.dart';
import 'features/schedule_alarm/domain/usecase/schedule_notifications_usecase.dart';
import 'features/schedule_alarm/presentation/state/local/alarm_cubit.dart';
import 'features/schedule_alarm/presentation/view/alarm_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localNotificationSource = LocalNotificationSource();
  await localNotificationSource.initialize();

  tz.initializeTimeZones();

  final notificationRepository = NotificationRepositoryImpl(
    localNotificationSource,
  );
  final scheduleNotificationsUseCase = ScheduleNotificationsUseCase(
    notificationRepository,
  );

  runApp(MyApp(scheduleNotificationsUseCase: scheduleNotificationsUseCase));
}

class MyApp extends StatelessWidget {
  final ScheduleNotificationsUseCase scheduleNotificationsUseCase;

  const MyApp({super.key, required this.scheduleNotificationsUseCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Schedule Alarm Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => AlarmCubit(scheduleNotificationsUseCase),
        child: const AlarmScreen(),
      ),
    );
  }
}
