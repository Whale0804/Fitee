import 'package:fitee/plugin/db/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

abstract class DBProvider {

  bool isTableExits = false;

  tableSqlString();

  tableName();

  tableBaseString(String name, String columnId) {
    return '''
        create table $name (
        $columnId integer primary key autoincrement,
      ''';
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await DBHelper.isTableExits(name);
    if (!isTableExits) {
      Database db = await DBHelper.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), tableSqlString());
    }
    return await DBHelper.getCurrentDatabase();
  }
}