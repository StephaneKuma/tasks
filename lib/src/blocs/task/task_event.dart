part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class UpdateTasks extends TaskEvent {
  final List<Task> tasks;

  const UpdateTasks({required this.tasks});

  @override
  List<Object> get props => [tasks];
}
