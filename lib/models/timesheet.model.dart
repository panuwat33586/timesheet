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

  Map<String, dynamic> toRequest() {
    return {
      'id': timesheet_id,
      'timesheet_id': timesheet_id,
      'date': date,
      'man_hour': man_hour,
      'project_name': project_name,
      'task': task,
      'detail': detail,
      'timesheet_status': timesheet_status,
      'start_time': start_time,
      'finish_time': finish_time,
      'task_id': task_id,
      'project_id': project_id,
    };
  }
}
