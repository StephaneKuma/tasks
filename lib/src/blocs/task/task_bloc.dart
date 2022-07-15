import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tasks/src/models/models.dart';
import 'package:tasks/src/repositories/repositories.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;
  StreamSubscription<List<Task>?>? _streamSubscription;

  TaskBloc({required this.repository}) : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<UpdateTasks>(_onUpdateTasks);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    _streamSubscription?.cancel();
    var box = await repository.openBox();
    _streamSubscription = repository.listenToEntities(box: box).listen((tasks) {
      if (tasks == null) {
        add(const UpdateTasks(tasks: <Task>[]));
      } else {
        add(UpdateTasks(tasks: tasks));
      }
    });
  }

  void _onUpdateTasks(UpdateTasks event, Emitter<TaskState> emit) {
    emit(TaskLoaded(tasks: event.tasks));
  }
}
