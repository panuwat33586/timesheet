import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/main.dart';
import 'package:timesheet/models/timesheet.model.dart';
import 'package:timesheet/providers/timesheet_provider.dart';

class EditTimesheetScreen extends ConsumerStatefulWidget {
  static const routeName = '/edit-timesheet';
  const EditTimesheetScreen({super.key});

  @override
  ConsumerState<EditTimesheetScreen> createState() =>
      _EditTimesheetScreenState();
}

class _EditTimesheetScreenState extends ConsumerState<EditTimesheetScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final Map<String, TextEditingController> timeControllers = {
    'startTimeController': TextEditingController(),
    'endTimeController': TextEditingController()
  };
  final Map<String, TimeOfDay?> timeState = {
    'startTime': null,
    'endTime': null
  };
  List<Map<String, dynamic>> projectList = [
    {
      "project_id": 1,
      "name": "Project A",
      "tasks": [
        {"task_id": 1, "task": "Implement"}
      ]
    },
    {
      "project_id": 2,
      "name": "Project B",
      "tasks": [
        {"task_id": 1, "task": "Implement"},
        {"task_id": 2, "task": "Sale"},
      ]
    }
  ];
  List<Map<String, dynamic>> selectedProjectTasks = [];
  final _formKey = GlobalKey<FormState>();
  late DateTime selectedDate;
  late int? selectedProject;
  late int? selectedTask;
  final TimeOfDay initialTime = const TimeOfDay(hour: 0, minute: 0);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context, String timeStateName) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.inputOnly,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != timeState[timeStateName]) {
      setState(() {
        timeState[timeStateName] = picked;
        timeControllers["${timeStateName}Controller"]?.text =
            picked.to24hours();
      });
    }
  }

  int calculateTimeDifferenceInHours(TimeOfDay startTime, TimeOfDay endTime) {
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;
    int differenceInMinutes = endMinutes - startMinutes;
    return differenceInMinutes ~/ 60;
  }

  addTimesheet(BuildContext context, WidgetRef ref) {
    var manHour = calculateTimeDifferenceInHours(
        timeState['startTime']!, timeState['endTime']!);
    var selectProject = projectList
        .firstWhere((project) => project['project_id'] == selectedProject);
    var selectTask = (selectProject['tasks'] as List<Map<String, dynamic>>)
        .firstWhere((task) => task['task_id'] == selectedTask);
    var newTimeSheet = Timesheet(
        manHour,
        selectProject['name'],
        selectTask['task'],
        _detailController.text,
        timeState['startTime']!.to24hours(),
        timeState['endTime']!.to24hours(),
        selectTask['task_id'],
        selectProject['project_id']);
    ref.read(timesheetProvider.notifier).addTimesheet(newTimeSheet);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('successfully add timesheet'),
      backgroundColor: Color(Colors.green.shade300.value),
    ));
  }

  @override
  void initState() {
    selectedDate = DateTime.now();
    _dateController.text = selectedDate.toString().split(' ')[0];
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    timeControllers['startTimeController']?.dispose();
    timeControllers['endTimeController']?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var headerType = ModalRoute.of(context)?.settings?.arguments;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(headerType == 'add' ? 'Add Timesheet' : 'Edit Timesheet'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState?.validate() == true) {
              addTimesheet(context, ref);
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'date is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () => _selectTime(context, 'startTime'),
                      child: AbsorbPointer(
                        child: TextFormField(
                          readOnly: true,
                          controller: timeControllers['startTimeController'],
                          decoration: const InputDecoration(
                            labelText: 'Start Time',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'start time is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () => _selectTime(context, 'endTime'),
                      child: AbsorbPointer(
                        child: TextFormField(
                          readOnly: true,
                          controller: timeControllers['endTimeController'],
                          decoration: const InputDecoration(
                            labelText: 'End Time',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'finish time is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(labelText: 'project'),
                      onChanged: (value) {
                        setState(() {
                          selectedProject = value;
                          selectedProjectTasks = projectList.firstWhere(
                              (project) =>
                                  project['project_id'] == value)['tasks'];
                        });
                      },
                      items: projectList
                          .map((project) => DropdownMenuItem<int>(
                                value: project['project_id'],
                                child: Text(project['name']),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'project is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: DropdownButtonFormField(
                      onChanged: (value) {
                        setState(() {
                          selectedTask = value;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'task'),
                      items: selectedProjectTasks
                          .map((task) => DropdownMenuItem<int>(
                                value: task['task_id'],
                                child: Text(task['task']),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'task is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    child: TextField(
                      maxLines: 5,
                      controller: _detailController,
                      decoration: const InputDecoration(
                        labelText: 'detail',
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
