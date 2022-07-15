import 'package:hive/hive.dart';

abstract class HiveApi<T> {
  Future<Box<T>> openBox();

  List<T> getEntities({required Box<T> box});

  Stream<List<T>?> listenToEntities({required Box<T> box});

  Future<void> addToBox({required Box<T> box, required T entity});

  Future<void> removeFromBox({required Box<T> box, required T entity});
}
