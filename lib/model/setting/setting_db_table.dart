import 'package:fitee/plugin/db/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class SettingTable extends DBProvider {

  final String dbTableName = 'settings';

  final String columnId = '_id';
  final String columnKey = 'key';
  final String columnValue = 'value';

  int id;
  String key;
  String value;

  SettingTable();

  Map<String, dynamic> toMap(String key, String value){
    Map<String, dynamic> map = {columnKey: key, columnValue: value};
    if(id != null) {
      map[columnId] = id;
    }
    return map;
  }

  SettingTable.fromMap(Map map) {
    id = map[columnId];
    key = map[columnKey];
    value = map[columnValue];
  }

  @override
  tableName() {
    return dbTableName;
  }

  @override
  tableSqlString() {
    return tableBaseString(dbTableName, columnId) +
    '''
    $columnKey text not null,
    $columnValue text not null)
    ''';
  }

  /// 新增数据
  Future insert(String key, dynamic value) async{
    Database db = await getDataBase();
    return await db.insert(dbTableName, toMap(key, value));
  }

  /// 删除数据
  Future delete(String key) async {
    Database db = await getDataBase();
    return await db.rawDelete('DELETE FROM $dbTableName WHERE $columnKey = ?',[key]);
  }

  /// 查询数据
  Future<dynamic> queryByKey(String key) async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(dbTableName, columns: [columnId, columnKey, columnValue]);
    if(maps.length > 0){
      Map map = maps.first;
      return map[columnValue];
    }
    return null;
  }

  /// 更新数据
  Future<int> update(String key, dynamic value) async {
    Database db = await getDataBase();
    return db.rawUpdate('UPDATE $dbTableName SET $columnValue = ? WHERE $columnKey = ?',[value, key]);
  }

  /// 更新数据
  Future<int> queryCount(String key) async {
    Database db = await getDataBase();
    List<Map> list = await db.query(dbTableName,columns: [columnId, columnKey], where: columnKey, whereArgs: [key]);
    return list.length;
  }

}