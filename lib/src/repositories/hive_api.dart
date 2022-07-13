import 'package:hive/hive.dart';

abstract class HiveApi<T> {
  Future<Box> openBox();

  List<T> getEntities({required Box box});

  Future<void> addToBox({required Box box, required T entity});

  Future<void> removeFromBox({required Box box, required T entity});
}
