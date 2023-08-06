import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/models/timesheet.model.dart';

List<Timesheet> timesheets = [
  Timesheet(4, 'Project A', "Implement/Development", "- fix ui and more ",
      "09:00:00", "13:00:00", 1, 1),
  Timesheet(4, 'Project B', "Self-Learn, Read, Research ...",
      "Research on flutter", "14:00:00", "18:00:00", 2, 2)
];

class TimesheetNotifier extends StateNotifier<List<Timesheet>> {
  TimesheetNotifier() : super(timesheets);

  void deleteTimesheet(String timesheetId) {
    var filteredTimesheets = state
        .where((timesheet) => timesheet.timesheet_id != timesheetId)
        .toList();
    state = filteredTimesheets;
  }

  void addTimesheet(Timesheet timesheet) {
    state = [...state, timesheet];
  }

  void editTimesheet(Timesheet editedTimesheet) {
    state = state.map((timesheet) {
      if (timesheet.timesheet_id == editedTimesheet.timesheet_id) {
        return editedTimesheet;
      }
      return timesheet;
    }).toList();
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
