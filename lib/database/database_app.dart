import 'dart:io';

import 'package:contacts/database/opration_database/db_oparation.dart';
import 'package:contacts/model/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../widgets/const_widgets_app.dart';

class DatabaseApp implements DBOperation<ContactModel> {
  static final DatabaseApp _instance = DatabaseApp._internal();

  DatabaseApp._internal();

  late Database _database;

  factory DatabaseApp() {
    return _instance;
  }

  Future<void> initDatabase() async {
    Directory files = await getApplicationDocumentsDirectory();
    String path = join(files.path, 'contact.sql');
    await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db
            .execute('CREATE TABLE contact ('
                'id INTEGER PRIMARY KEY AUTOINCREMENT , '
                'name TEXT NOT NULL , '
                'number TEXT NOT NULL'
                ')')
            .then((value) {
          print('the database and contact table is created success');
        }).catchError((onError) {
          print('failed in create the database and contact table');
        });
      },
      // onOpen: (db) {
      //   print('database is opened');
      //   read(db).then((value) {
      //     myData = value;
      //   });
      // },
    ).then((value) {
      _database = value;
    });
    // return myData;
  }

  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    // Delete from contact where id = ? ;
    int rowsDelete =
        await _database.delete('contact', where: 'id = ?', whereArgs: [id]);
    return rowsDelete > 0;
  }

  @override
  Future<int> insert(object) async {
    // TODO: implement insert
    // Insert into contact (name , number) values ('mohammed', '0592564573');
    return await _database.insert('contact', object.toMap());
  }

  @override
  Future<List<ContactModel>> read() async {
    // Select * from contact ;

    List<Map<String, dynamic>> rows = await _database.query('contact');
    return rows.map((e) => ContactModel.fromMap(e)).toList();
  }

  @override
  Future<ContactModel?> show(int id) async {
    // TODO: implement show
    // Select * from contact where id = ? ;

    List<Map<String, dynamic>> row =
        await _database.query('contact', where: 'id = ?', whereArgs: [id]);
    return row.isNotEmpty ? ContactModel.fromMap(row.first) : null;
  }

  @override
  Future<bool> update(object) async {
    // TODO: implement update
    // UPDATE table_name SET name = 'ali' , number = '123456' WHERE id = ?;
    int rowNumUpdated = await _database.update('contact', object.toMap(),
        where: 'id = ?', whereArgs: [object.id]);
    return rowNumUpdated > 0;
  }
}
