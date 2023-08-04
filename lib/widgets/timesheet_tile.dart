import 'package:flutter/material.dart';
import 'package:timesheet/widgets/confirm_dialog.dart';
import 'package:timesheet/widgets/timesheet_status.dart';

import 'list_detail.dart';

class TimeSheetTile extends StatelessWidget {
  Map<String, dynamic> timesheet;
  Function deleteTimesheet;

  Future<bool?> _handleDismiss(
      BuildContext context, DismissDirection direction) {
    if (direction == DismissDirection.endToStart) {
      return showDialog<bool?>(
          context: context,
          builder: (BuildContext context) => ConfirmDialog(
              title: 'Delete Timesheet',
              detail: 'Are you sure you want to delete this timesheet'));
    } else {
      return Future(() => false);
    }
  }

  TimeSheetTile(
      {super.key, required this.timesheet, required this.deleteTimesheet});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(timesheet['timesheet_id'].toString()),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          deleteTimesheet();
        }
      },
      confirmDismiss: (direction) {
        return _handleDismiss(context, direction);
      },
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.5,
        DismissDirection.endToStart: 0.5
      },
      background: Container(
        color: Colors.yellow,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16.0),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ExpansionTile(
        leading: TimesheetStatus(status: timesheet['timesheet_status']),
        title: Text(
          timesheet['project_name'],
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${timesheet['start_time']} - ${timesheet['finish_time']}",
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Chip(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                label: Text("${timesheet['man_hour']} hours"),
              ),
            )
          ],
        ),
        children: [
          ListDetail(title: timesheet['task'], detail: timesheet['detail'])
        ],
      ),
    );
  }
}
