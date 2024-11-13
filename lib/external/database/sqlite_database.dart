import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database_service.dart';
import 'sql/sql.dart';

class SQLiteDatabase implements DatabaseService {
  Database? _database;

  // Método para garantir inicialização automática de _database
  Future<Database> get database async {
    if (_database == null) {
      String path = join(await getDatabasesPath(), 'app_database.db');
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(SQLNoteQueries.createTableNotes);
          await db.execute(SQLCommandQueries.createTableCommands);
        },
      );
    }
    return _database!;
  }

  @override
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database; // Garante que _database está inicializado
    return await db.insert(table, data);
  }

  @override
  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    final db = await database;
    return await db.query(
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
    final db = await database;
    return await db.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }

  @override
  Future<int> delete(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    final db = await database;
    return await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  @override
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null; // Permite reabertura do banco se necessário
    }
  }

  @override
  Future<void> init() {
    return database;
  }
}
