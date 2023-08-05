import 'package:uuid/uuid.dart';

class Timesheet {
  String timesheet_id = Uuid().v4().toString();
  String date = DateTime.now().toString();
  int man_hour;
  String project_name;
  String task;
  String detail;
  String timesheet_status = 'w';
  String start_time;
  String finish_time;
  int task_id;
  int project_id;

  Timesheet(
    this.man_hour,
    this.project_name,
    this.task,
    this.detail,
    this.start_time,
    this.finish_time,
    this.task_id,
    this.project_id,
  );
}
