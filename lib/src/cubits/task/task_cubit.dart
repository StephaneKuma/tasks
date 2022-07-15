import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks/src/models/models.dart';
import 'package:tasks/src/repositories/repositories.dart';
import 'package:uuid/uuid.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository repository;

  TaskCubit({required this.repository}) : super(TaskState.initial());

  void onTitleChanged({required String title}) {
    emit(state.copyWith(title: title));
  }

  void onNoteChanged({required String note}) {
    emit(state.copyWith(note: note));
  }

  void onIsCompletedChanged({required int isCompleted}) {
    emit(state.copyWith(isCompleted: isCompleted));
  }

  void onDateChanged({required String date}) {
    emit(state.copyWith(date: date));
  }

  void onStartTimeChanged({required String startTime}) {
    emit(state.copyWith(startTime: startTime));
  }

  void onEndTimeChanged({required String endTime}) {
    emit(state.copyWith(endTime: endTime));
  }

  void onColorChanged({required int color}) {
    emit(state.copyWith(color: color));
  }

  void onRemindChanged({required int remind}) {
    emit(state.copyWith(remind: remind));
  }

  void onRepeatChanged({required String repeat}) {
    emit(state.copyWith(repeat: repeat));
  }

  Future save() async {
    if (state.status == TaskStatus.submitting) return;

    emit(state.copyWith(status: TaskStatus.submitting));

    try {
      var box = await repository.openBox();
      await repository.addToBox(
        box: box,
        entity: Task(
          id: const Uuid().v4(),
          title: state.title,
          note: state.note,
          isCompleted: state.isCompleted,
          date: state.date,
          startTime: state.startTime,
          endTime: state.endTime,
          color: state.color,
          remind: state.remind,
          repeat: state.repeat,
        ),
      );

      emit(state.copyWith(status: TaskStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.error,
      ));
    }
  }
}
