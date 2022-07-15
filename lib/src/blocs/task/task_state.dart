part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded({
    this.tasks = const <Task>[],
  });

  TaskLoaded copyWith({
    List<Task>? tasks,
  }) {
    return TaskLoaded(
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'TaskLoaded(tasks: $tasks)';

  @override
  bool operator ==(covariant TaskLoaded other) {
    if (identical(this, other)) return true;

    return listEquals(other.tasks, tasks);
  }

  @override
  int get hashCode => tasks.hashCode;
}
