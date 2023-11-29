import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timesheet/models/timesheet.model.dart';
import 'package:timesheet/providers/timesheet_provider.dart';
import 'package:timesheet/screens/edit_timesheet_screen.dart';
import 'package:timesheet/widgets/confirm_dialog.dart';
import 'package:timesheet/widgets/timesheet_status.dart';

import 'list_detail.dart';

class TimeSheetTile extends ConsumerWidget {
  Timesheet timesheet;

  Future<bool?> _handleDismiss(
      BuildContext context, DismissDirection direction) {
    if (direction == DismissDirection.endToStart) {
      return showDialog<bool?>(
          context: context,
          builder: (BuildContext context) => ConfirmDialog(
              title: 'Delete Timesheet',
              detail: 'Are you sure you want to delete this timesheet'));
    } else {
      editTimesheet(context);
      return Future(() => false);
    }
  }

  deleteTimeSheet(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref
        .read(timesheetProvider.notifier)
        .deleteTimesheet(context, timesheet.timesheet_id);
  }

  editTimesheet(BuildContext context) {
    Navigator.of(context).pushNamed(EditTimesheetScreen.routeName, arguments: {
      'type': 'edit',
      'props': {'timesheetId': timesheet.timesheet_id}
    });
  }

  TimeSheetTile({super.key, required this.timesheet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(timesheet.timesheet_id),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          deleteTimeSheet(context, ref);
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
        leading: TimesheetStatus(status: timesheet.timesheet_status),
        title: Text(
          timesheet.project_name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat('dd-MM-yyyy')
                    .format(DateTime.parse(timesheet.date))),
                Text(
                  "${timesheet.start_time} - ${timesheet.finish_time}",
                ),
              ],
            ),
            Column(children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Chip(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  label: Text("${timesheet.man_hour} hours"),
                ),
              )
            ])
          ],
        ),
        children: [ListDetail(title: timesheet.task, detail: timesheet.detail)],
      ),
    );
  }
}
