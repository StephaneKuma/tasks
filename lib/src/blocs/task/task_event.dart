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

class CompletedTask extends TaskEvent {
  final Task task;

  const CompletedTask({required this.task});
  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;

  const DeleteTask({required this.task});
  @override
  List<Object> get props => [task];
}
