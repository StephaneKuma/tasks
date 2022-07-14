part of 'task_cubit.dart';

enum TaskStatus { initial, submitting, success, error }

class TaskState extends Equatable {
  const TaskState({
    required this.id,
    required this.title,
    required this.note,
    required this.isCompleted,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.remind,
    required this.repeat,
    required this.status,
  });

  factory TaskState.initial() => const TaskState(
        id: '',
        title: '',
        note: '',
        isCompleted: 0,
        date: '',
        startTime: '',
        endTime: '',
        color: 0,
        remind: 0,
        repeat: '',
        status: TaskStatus.initial,
      );

  TaskState copyWith({
    String? id,
    String? title,
    String? note,
    int? isCompleted,
    String? date,
    String? startTime,
    String? endTime,
    int? color,
    int? remind,
    String? repeat,
    TaskStatus? status,
  }) {
    return TaskState(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      remind: remind ?? this.remind,
      repeat: repeat ?? this.repeat,
      status: status ?? this.status,
    );
  }

  final String id;
  final String title;
  final String note;
  final int isCompleted;
  final String date;
  final String startTime;
  final String endTime;
  final int color;
  final int remind;
  final String repeat;
  final TaskStatus status;

  @override
  List<Object> get props {
    return [
      id,
      title,
      note,
      isCompleted,
      date,
      startTime,
      endTime,
      color,
      remind,
      repeat,
      status,
    ];
  }

  @override
  bool get stringify => true;
}
