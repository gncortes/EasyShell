import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database_service.dart';
import 'sql/sql.dart';

class SQLiteDatabase implements DatabaseService {
  late final Database _database;
  bool isInitialized = false;

  SQLiteDatabase([Database? database]) {
    if (database != null) {
      _database = database;
      isInitialized = true;
    }
  }

  @override
  Future<void> init() async {
    if (isInitialized) return;

    String path = join(await getDatabasesPath(), 'app_database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(SQLNoteQueries.createTableNotes);
        await db.execute(SQLCommandQueries.createTableCommands);
      },
    );
    isInitialized = true;
  }

  @override
  Future<int> insert(String table, Map<String, dynamic> data) async {
    await init();
    return await _database.insert(table, data);
  }

  @override
  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    await init();
    return await _database.query(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  @override
  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    await init();
    return await _database.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }

  @override
  Future<int> delete(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    await init();
    return await _database.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  @override
  Future<void> close() {
    return _database.close();
  }
}
