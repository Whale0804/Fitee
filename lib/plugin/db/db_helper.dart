import 'package:fitee/config/config.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DBHelper {
  static Database db;

  /// 初始化数据库
  static init() async{
    //Get a location using getDatabasesPath
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, AppConfig.DB_NAME);
    try {
      db = await openDatabase(path);
    } catch (e) {
      print("Error $e");
    }

    db = await openDatabase(path, version: AppConfig.DB_VERSION,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          //await db.execute("CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)");
          print('db created version is $version');
        });
  }

  /// 表是否存在
  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await db.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  ///获取当前数据库对象
  static Future<Database> getCurrentDatabase() async {
    if (db == null) {
      await init();
    }
    return db;
  }

  ///关闭
  static close() {
    db?.close();
    db = null;
  }
}