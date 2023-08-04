import 'package:flutter/material.dart';

import 'ListDetail.dart';

class TimeSheetTile extends StatelessWidget {
  Map<String, dynamic> timesheet;

  TimeSheetTile({super.key, required this.timesheet});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
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
    );
  }
}
