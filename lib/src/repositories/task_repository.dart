import 'package:hive/hive.dart';
import 'package:tasks/src/models/models.dart';
import 'package:tasks/src/repositories/hive_api.dart';

class TaskRepository implements HiveApi<Task> {
  @override
  Future<void> addToBox({required Box box, required Task entity}) {
    // TODO: implement addToBox
    throw UnimplementedError();
  }

  @override
  List<Task> getEntities({required Box box}) {
    // TODO: implement getEntity
    throw UnimplementedError();
  }

  @override
  Future<Box> openBox() {
    // TODO: implement openBox
    throw UnimplementedError();
  }

  @override
  Future<void> removeFromBox({required Box box, required Task entity}) {
    // TODO: implement removeFromBox
    throw UnimplementedError();
  }
}
