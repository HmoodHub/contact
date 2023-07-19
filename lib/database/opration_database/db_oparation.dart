import 'package:sqflite/sqflite.dart';

abstract class DBOperation<T>{
  // CRUD
  // C =>create (insert)
  // R =>read (select *)
  //*S =>show (select where)
  // U =>update
  // D =>delete

  Future<int> insert(T object);
  Future<T?> show(int id);
  Future<List<T>> read();
  Future<bool> update(T object);
  Future<bool> delete(int id);
}