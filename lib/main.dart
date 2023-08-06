import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/screens/edit_timesheet_screen.dart';
import 'package:timesheet/screens/timesheet_screen.dart';

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final convertHour = hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$convertHour:$min:00";
  }
}

extension StringToTimeOfDay on String {
  TimeOfDay? toTimeOfDay() {
    final timeParts = split(":");
    if (timeParts.length > 0) {
      int hours = int.parse(timeParts[0]);
      int minutes = int.parse(timeParts[1]);
      return TimeOfDay(hour: hours, minute: minutes);
    } else {
      return null;
    }
  }
}

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timesheet-App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: TimesheetScreen.routeName,
      routes: {
        TimesheetScreen.routeName: (ctx) => const TimesheetScreen(),
        EditTimesheetScreen.routeName: (ctx) => const EditTimesheetScreen()
      },
    );
  }
}
