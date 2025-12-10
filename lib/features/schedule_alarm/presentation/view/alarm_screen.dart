import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/local/alarm_cubit.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Alarms')),
      body: Center(
        child: BlocConsumer<AlarmCubit, AlarmState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('7 Alarms Scheduled!')),
                );
              },
              error: (message) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $message')));
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const CircularProgressIndicator(),
              orElse: () => ElevatedButton(
                onPressed: () {
                  context.read<AlarmCubit>().scheduleAlarm();
                },
                child: const Text('Start 7-Minute Alarms'),
              ),
            );
          },
        ),
      ),
    );
  }
}
