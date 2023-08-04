import 'package:flutter/material.dart';
import 'package:timesheet/widgets/timesheet_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
