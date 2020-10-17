import 'package:fitee/plugin/db/db_provider.dart';
import 'package:fitee/utils/code_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class SearchTable extends DBProvider {

  final String dbTableName = 'search_history';

  final String columnId = "_id";
  final String columnHistory = "history";

  int id;
  String history;

  SearchTable();

  Map<String, dynamic> toMap(String history) {
    Map<String, dynamic> map = {columnHistory: history};
    if(id != null) {
      map[columnId] = id;
    }
    return map;
  }

  SearchTable.fromMap(Map map) {
    id = map[columnId];
    history = map[columnHistory];
  }

  @override
  tableName() {
    return dbTableName;
  }

  @override
  tableSqlString() {
    return tableBaseString(dbTableName, columnId) +
      '''
      $columnHistory text not null)
      ''';
  }

  /// 新增数据
  Future insert(String data) async{
    Database db = await getDataBase();
    return await db.insert(dbTableName, toMap(data));
  }

  /// 删除数据
  Future delete() async {
    Database db = await getDataBase();
    return await db.rawDelete('DELETE FROM $dbTableName');
  }

  /// 查询数据
  Future<Set<String>> query() async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(dbTableName, columns: [columnId, columnHistory]);
    Set<String> list = new Set<String>();
    for(Map map in maps) {
      list.add(map[columnHistory] as String);
    }
    return list;
  }
}