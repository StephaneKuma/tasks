import 'dart:async';

import 'package:hive/hive.dart';
import 'package:tasks/src/models/models.dart';
import 'package:tasks/src/repositories/hive_api.dart';

class TaskRepository implements HiveApi<Task> {
  final String name = 'taks';
  final StreamController<List<Task>> _tasksController =
      StreamController<List<Task>>.broadcast();

  @override
  Future<void> saveToBox({required Box<Task> box, required Task entity}) async {
    await box.put(entity.id, entity);
  }

  @override
  List<Task> getEntities({required Box<Task> box}) {
    return box.values.toList();
  }

  @override
  Stream<List<Task>> listenToEntities({required Box<Task> box}) {
    var tasks = getEntities(box: box);

    tasks.isEmpty
        ? _tasksController.add(<Task>[])
        : _tasksController.add(tasks);

    print('Listening');
    print('Task numner: ${tasks.length}');

    return _tasksController.stream;
  }

  @override
  Future<Box<Task>> openBox() async {
    Box<Task> box = await Hive.openBox<Task>(name);

    return box;
  }

  @override
  Future<void> removeFromBox(
      {required Box<Task> box, required Task entity}) async {
    await box.delete(entity.id);
  }
}
