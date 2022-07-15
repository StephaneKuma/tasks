part of 'task_bloc.dart';

abstract class TaskBlocState extends Equatable {
  const TaskBlocState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskBlocState {}

class TaskLoaded extends TaskBlocState {
  final List<Task> tasks;

  const TaskLoaded({
    this.tasks = const <Task>[],
  });

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'TaskLoaded(tasks: $tasks)';
}
