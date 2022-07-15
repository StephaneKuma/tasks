import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tasks/src/models/models.dart';
import 'package:tasks/src/repositories/repositories.dart';
import 'package:uuid/uuid.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskBlocState> {
  final TaskRepository _repository;
  StreamSubscription<List<Task>>? _streamSubscription;

  TaskBloc({required TaskRepository repository})
      : _repository = repository,
        super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<UpdateTasks>(_onUpdateTasks);
    on<CompletedTask>(_onCompletedTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskBlocState> emit) async {
    _streamSubscription?.cancel();
    var box = await _repository.openBox();
    var tasks = _repository.getEntities(box: box);
    add(UpdateTasks(tasks: tasks));
  }

  void _onUpdateTasks(UpdateTasks event, Emitter<TaskBlocState> emit) {
    print('Updated tasks: $event');
    emit(TaskLoaded(tasks: event.tasks));
  }

  Future<void> _onCompletedTask(
      CompletedTask event, Emitter<TaskBlocState> emit) async {
    if (state is TaskLoaded) {
      try {
        _streamSubscription?.cancel();
        var box = await _repository.openBox();
        await _repository.saveToBox(
          box: box,
          entity: event.task.copyWith(isCompleted: 1),
        );
        var tasks = _repository.getEntities(box: box);
        add(UpdateTasks(tasks: tasks));
      } catch (_) {}
    }
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskBlocState> emit) async {
    if (state is TaskLoaded) {
      try {
        _streamSubscription?.cancel();
        var box = await _repository.openBox();
        await _repository.removeFromBox(box: box, entity: event.task);
        var tasks = _repository.getEntities(box: box);
        add(UpdateTasks(tasks: tasks));
      } catch (_) {}
    }
  }
}
