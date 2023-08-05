import 'package:flutter/material.dart';
import 'package:timesheet/screens/edit_timesheet_screen.dart';
import 'package:timesheet/screens/timesheet_screen.dart';

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

void main() {
  runApp(const MyApp());
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
        TimesheetScreen.routeName: (ctx) => TimesheetScreen(),
        EditTimesheetScreen.routeName: (ctx) => EditTimesheetScreen()
      },
    );
  }
}
