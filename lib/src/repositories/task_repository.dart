import 'package:hive/hive.dart';
import 'package:tasks/src/models/models.dart';
import 'package:tasks/src/repositories/hive_api.dart';

class TaskRepository implements HiveApi<Task> {
  final String name = 'taks';

  @override
  Future<void> addToBox({required Box<Task> box, required Task entity}) async {
    await box.put(entity.id, entity);
  }

  @override
  List<Task> getEntities({required Box<Task> box}) {
    return box.values.toList();
  }

  @override
  Future<Box<Task>> openBox() async {
    Box<Task> box = await Hive.openBox<Task>(name);

    return box;
  }

  @override
  Future<void> removeFromBox({required Box<Task> box, required Task entity}) async {
    await box.delete(entity.id);
  }
}
