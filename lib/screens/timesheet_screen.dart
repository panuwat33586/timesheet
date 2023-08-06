import 'package:flutter/material.dart';
import 'package:timesheet/screens/edit_timesheet_screen.dart';
import '../widgets/timesheet_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/providers/timesheet_provider.dart';

class TimesheetScreen extends ConsumerStatefulWidget {
  static const routeName = '/timesheet';

  const TimesheetScreen({super.key});

  @override
  ConsumerState<TimesheetScreen> createState() => _TimesheetScreenState();
}

class _TimesheetScreenState extends ConsumerState<TimesheetScreen> {
  @override
  void initState() {
    ref.read(timesheetProvider.notifier).loadTimesheets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timesheets = ref.watch(timesheetProvider);
    var maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Timesheet'),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.pushNamed(context, EditTimesheetScreen.routeName,
                        arguments: {'type': 'add', 'props': {}})
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
                      TimeSheetTile(timesheet: timesheets[index])))
        ],
      ),
    );
  }
}
