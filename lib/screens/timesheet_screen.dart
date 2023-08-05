import 'package:flutter/material.dart';
import 'package:timesheet/screens/edit_timesheet_screen.dart';

import '../widgets/Timesheet_Tile.dart';

class TimesheetScreen extends StatefulWidget {
  static const routeName = '/timesheet';

  TimesheetScreen({super.key});

  @override
  State<TimesheetScreen> createState() => _TimesheetScreenState();
}

class _TimesheetScreenState extends State<TimesheetScreen> {
  List<Map<String, dynamic>> timesheets = [
    {
      "timesheet_id": 1,
      "date": "2023-08-03",
      "man_hour": 4,
      "project_name": "Project A",
      "task": "Implement/Development",
      "detail": "- fix ui and more ",
      "timesheet_status": "w",
      "leave": 0,
      "start_time": "09:00:00",
      "finish_time": "13:00:00",
      "task_id": 1,
      "project_id": 1
    },
    {
      "timesheet_id": 2,
      "date": "2023-08-03",
      "man_hour": 4,
      "project_name": "Project B",
      "task": "Self-Learn, Read, Research ...",
      "detail": "Research on flutter",
      "timesheet_status": "w",
      "leave": 0,
      "start_time": "14:00:00",
      "finish_time": "18:00:00",
      "task_id": 2,
      "project_id": 2
    }
  ];

  @override
  Widget build(BuildContext context) {
    var maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Timesheet'),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.pushNamed(context, EditTimesheetScreen.routeName,
                        arguments: 'add')
                  },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: maxHeight * 0.5,
              child: ListView.builder(
                  itemCount: timesheets.length,
                  itemBuilder: (BuildContext context, int index) =>
                      TimeSheetTile(
                        timesheet: timesheets[index],
                        deleteTimesheet: () => timesheets.removeAt(index),
                      )))
        ],
      ),
    );
  }
}
