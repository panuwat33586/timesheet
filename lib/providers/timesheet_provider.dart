import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/models/timesheet.model.dart';
import 'package:timesheet/services/timesheet.service.dart';

class TimesheetNotifier extends StateNotifier<List<Timesheet>> {
  TimesheetNotifier() : super([]);

  void loadTimesheets(BuildContext context) async {
    try {
      final timesheets = await TimesheetService().fetchTimesheet();
      state = timesheets;
    } catch (err) {
      print(err.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('cannot fetch data'),
        backgroundColor: Color(Colors.red.shade300.value),
      ));
    }
  }

  void deleteTimesheet(BuildContext context, String timesheetId) async {
    try {
      await TimesheetService().deleteTimesheet(timesheetId);
      var filteredTimesheets = state
          .where((timesheet) => timesheet.timesheet_id != timesheetId)
          .toList();
      state = filteredTimesheets;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('successfully delete timesheet'),
        backgroundColor: Color(Colors.green.shade300.value),
      ));
    } catch (err) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('failed delete timesheet'),
        backgroundColor: Color(Colors.red.shade300.value),
      ));
    }
  }

  void addTimesheet(BuildContext context, Timesheet timesheet) async {
    try {
      await TimesheetService().createTimesheet(timesheet.toRequest());
      state = [...state, timesheet];
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('successfully add timesheet'),
        backgroundColor: Color(Colors.green.shade300.value),
      ));
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('fail add timesheet'),
        backgroundColor: Color(Colors.red.shade300.value),
      ));
    }
  }

  void editTimesheet(BuildContext context, Timesheet editedTimesheet) async {
    try {
      await TimesheetService().editTimesheet(editedTimesheet.toRequest());
      state = state.map((timesheet) {
        if (timesheet.timesheet_id == editedTimesheet.timesheet_id) {
          return editedTimesheet;
        }
        return timesheet;
      }).toList();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('successfully edit timesheet'),
        backgroundColor: Color(Colors.green.shade300.value),
      ));
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('fail edit timesheet'),
        backgroundColor: Color(Colors.red.shade300.value),
      ));
    }
  }

  Timesheet findTimesheet(String timesheetId) {
    return state
        .firstWhere((timesheet) => timesheet.timesheet_id == timesheetId);
  }
}

final timesheetProvider =
    StateNotifierProvider<TimesheetNotifier, List<Timesheet>>((ref) {
  return TimesheetNotifier();
});
