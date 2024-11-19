import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/errors/database_error.dart';
import 'database_service.dart';
import 'sql/sql.dart';

class SQLiteDatabase implements DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      try {
        String path = join(await getDatabasesPath(), 'app_database.db');
        _database = await openDatabase(
          path,
          version: 1,
          onCreate: (db, version) async {
            await db.execute(SQLNoteQueries.createTableNotes);
            await db.execute(SQLCommandQueries.createTableCommands);
          },
        );
      } catch (e, stacktrace) {
        if (kDebugMode) {
          print('Error: $e');
          print('StackTrace: $stacktrace');
        }
        throw DatabaseError(
          DatabaseErrorType.connectionError,
          'Failed to connect to the database: ${e.toString()}',
        );
      }
    }
    return _database!;
  }

  @override
  Future<int> insert(String table, Map<String, dynamic> data) async {
    try {
      final db = await database;
      return await db.insert(
        table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error: $e');
        print('StackTrace: $stacktrace');
      }
      throw DatabaseError(
        DatabaseErrorType.insertError,
        'Failed to insert into table $table: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    try {
      final db = await database;

      return await db.query(
        table,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error: $e');
        print('StackTrace: $stacktrace');
      }
      throw DatabaseError(
        DatabaseErrorType.queryError,
        'Failed to query table $table: ${e.toString()}',
      );
    }
  }

  @override
  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    try {
      final db = await database;
      return await db.update(
        table,
        data,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error: $e');
        print('StackTrace: $stacktrace');
      }
      throw DatabaseError(
        DatabaseErrorType.updateError,
        'Failed to update table $table: ${e.toString()}',
      );
    }
  }

  @override
  Future<int> delete(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    try {
      final db = await database;
      return await db.delete(
        table,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error: $e');
        print('StackTrace: $stacktrace');
      }
      throw DatabaseError(DatabaseErrorType.deleteError,
          'Failed to delete from table $table: ${e.toString()}');
    }
  }

  @override
  Future<void> close() async {
    try {
      if (_database != null) {
        await _database!.close();
        _database = null;
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error: $e');
        print('StackTrace: $stacktrace');
      }
      throw DatabaseError(DatabaseErrorType.connectionError,
          'Failed to close the database: ${e.toString()}');
    }
  }

  @override
  Future<void> init() async {
    await database;
  }
}
