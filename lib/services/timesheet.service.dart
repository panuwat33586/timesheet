import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:timesheet/models/timesheet.model.dart';

class TimesheetService {
  late final _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000',
    responseType: ResponseType.json,
  ));

  Future<List<Timesheet>> fetchTimesheet() async {
    final response = await _dio.get<List<dynamic>>('/timesheets');
    try {
      var timesheetList = response.data?.map((timesheet) {
        final timesheetObj = Timesheet(
            timesheet['man_hour'],
            timesheet['project_name'],
            timesheet['task'],
            timesheet['detail'],
            timesheet['start_time'],
            timesheet['finish_time'],
            timesheet['task_id'],
            timesheet['project_id']);
        timesheetObj.timesheet_id = timesheet['id'];
        return timesheetObj;
      }).toList();
      return timesheetList ?? [];
    } on DioException catch (err) {
      throw err;
    } catch (err) {
      throw err;
    }
  }

  Future<dynamic> createTimesheet(Map<String, dynamic> timesheetRequest) {
    return _dio.post('/timesheets', data: timesheetRequest);
  }

  Future<dynamic> editTimesheet(Map<String, dynamic> editedTimesheetRequest) {
    return _dio.put("/timesheets/${editedTimesheetRequest["id"]}",
        data: editedTimesheetRequest);
  }

  Future<dynamic> deleteTimesheet(String timesheetId) {
    return _dio.delete("/timesheets/$timesheetId");
  }
}
