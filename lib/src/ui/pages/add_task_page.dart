import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/cubits/cubits.dart';
import 'package:tasks/src/router/router.dart';
import 'package:tasks/src/ui/helpers/helpers.dart';
import 'package:tasks/src/ui/widgets/widgets.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = "12:30 PM";
  int _selectedRemind = 5;
  final List<int> _remindList = [5, 10, 15, 20, 25, 30];
  String _selectedRepeat = 'None';
  final List<String> _repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).iconTheme.color,
                size: 20.0,
              ),
              onPressed: () {
                AutoRouter.of(context).pop();
              },
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).iconTheme.color,
                  size: 20.0,
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            child: SingleChildScrollView(
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Add Task',
                          style: ksHeading,
                        ),
                        InputField(
                          title: 'Title',
                          hint: 'Enter you title',
                          onChange: (value) {
                            var title = value as String;
                            context
                                .read<TaskCubit>()
                                .onTitleChanged(title: title);
                          },
                        ),
                        InputField(
                          title: 'Note',
                          hint: 'Enter you note',
                          onChange: (value) {
                            var note = value as String;
                            context
                                .read<TaskCubit>()
                                .onNoteChanged(note: note);
                          },
                        ),
                        InputField(
                          title: 'Date',
                          hint: DateFormat.yMd().format(_selectedDate),
                          widget: IconButton(
                            onPressed: () {
                              _getDate();
                              context.read<TaskCubit>().onDateChanged(
                                    date: DateFormat.yMd()
                                        .format(_selectedDate),
                                  );
                            },
                            icon: const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: InputField(
                                title: 'Start time',
                                hint: _startTime,
                                widget: IconButton(
                                  onPressed: () {
                                    _getTime(
                                      onSuccess: (value) {
                                        setState(() {
                                          _startTime =
                                              value.format(context);
                                        });
                                        context
                                            .read<TaskCubit>()
                                            .onStartTimeChanged(
                                              startTime: _startTime,
                                            );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: InputField(
                                title: 'End time',
                                hint: _endTime,
                                widget: IconButton(
                                  onPressed: () {
                                    _getTime(
                                      onSuccess: (value) {
                                        setState(() {
                                          _endTime = value.format(context);
                                        });
                                        context
                                            .read<TaskCubit>()
                                            .onEndTimeChanged(
                                              endTime: _endTime,
                                            );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        InputField(
                          title: 'Remind',
                          hint: '$_selectedRemind minutes early',
                          widget: DropdownButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            iconSize: 32.0,
                            elevation: 4,
                            style: ksSubTitle,
                            underline: Container(height: 0),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedRemind = int.parse(value!);
                              });
                              context
                                  .read<TaskCubit>()
                                  .onRemindChanged(remind: _selectedRemind);
                            },
                            items: _remindList
                                .map<DropdownMenuItem<String>>(
                                  (int value) => DropdownMenuItem<String>(
                                    value: value.toString(),
                                    child: Text(
                                      value.toString(),
                                      style: ksSubTitle.copyWith(
                                          color: Colors.grey),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        InputField(
                          title: 'Repeat',
                          hint: _selectedRepeat,
                          widget: DropdownButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            iconSize: 32.0,
                            elevation: 4,
                            style: ksSubTitle,
                            underline: Container(height: 0),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedRepeat = value!;
                              });
                              context
                                  .read<TaskCubit>()
                                  .onRepeatChanged(repeat: _selectedRepeat);
                            },
                            items: _repeatList
                                .map<DropdownMenuItem<String>>(
                                  (String value) =>
                                      DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: ksSubTitle.copyWith(
                                          color: Colors.grey),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 10.0,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Color',
                                    style: ksTitle,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Wrap(
                                    children: List<Widget>.generate(
                                      3,
                                      (index) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedColor = index;
                                          });
                                          context
                                              .read<TaskCubit>()
                                              .onColorChanged(
                                                color: _selectedColor,
                                              );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0),
                                          child: CircleAvatar(
                                            radius: 14.0,
                                            backgroundColor: index == 0
                                                ? kcBlueColor
                                                : index == 1
                                                    ? kcPinkColor
                                                    : kcYellowColor,
                                            child: _selectedColor == index
                                                ? const Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  )
                                                : const SizedBox(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<TaskCubit>().save();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Your task is saved'),
                                    ),
                                  );

                                  AutoRouter.of(context)
                                      .push(const HomeRoute());
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: kcBlueColor,
                                  shape: const StadiumBorder(),
                                  fixedSize: const Size.fromHeight(50.0),
                                ),
                                child: Row(
                                  children: const <Widget>[
                                    Icon(Icons.save),
                                    SizedBox(width: 5.0),
                                    Text('Create Task'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _getDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _getTime({required ValueChanged<TimeOfDay> onSuccess}) async {
    var pickedTime = await _showTimePicker();
    if (pickedTime != null) {
      onSuccess.call(pickedTime);
    }
  }

  Future<TimeOfDay?> _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }
}
