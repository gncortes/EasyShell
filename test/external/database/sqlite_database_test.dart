import 'package:easy_shell/external/database/sqlite_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    // Initialize FFI support for unit tests
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('SQLiteDatabase', () {
    late SQLiteDatabase database;

    setUp(() async {
      database = SQLiteDatabase();
      await database.init();
      database.delete('notes');
    });

    tearDown(() async {
      await database.close();
    });

    test('Should notes is empty', () async {
      final result = await database.query('notes');
      expect(result.length, isZero);
    });

    test('Should insert a record into the notes table', () async {
      final data = {
        'title': 'Sample Note',
        'description': 'This is a test note',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String()
      };
      final id = await database.insert('notes', data);

      expect(id, isNonZero);

      final result = await database.query('notes');
      expect(result.length, 1);
      expect(result[0]['title'], 'Sample Note');
    });

    test('Should query records from the notes table', () async {
      final data1 = {
        'title': 'First Note',
        'description': 'Description 1',
        'createdAt': DateTime.now().toIso8601String(),
      };
      final data2 = {
        'title': 'Second Note',
        'description': 'Description 2',
        'createdAt': DateTime.now().toIso8601String(),
      };

      await database.insert('notes', data1);
      await database.insert('notes', data2);

      final result = await database
          .query('notes', where: 'title = ?', whereArgs: ['First Note']);
      expect(result.length, 1);
      expect(result[0]['title'], 'First Note');
    });

    test('Should update a record in the notes table', () async {
      final data = {
        'title': 'Note to Update',
        'description': 'Initial description',
        'createdAt': DateTime.now().toIso8601String(),
      };
      final id = await database.insert('notes', data);

      final updatedRows = await database.update(
        'notes',
        {'title': 'Updated Note'},
        where: 'id = ?',
        whereArgs: [id],
      );

      expect(updatedRows, 1);

      final result =
          await database.query('notes', where: 'id = ?', whereArgs: [id]);
      expect(result[0]['title'], 'Updated Note');
    });

    test('Should delete a record from the notes table', () async {
      final data = {
        'title': 'Note to Delete',
        'description': 'This note will be deleted',
        'createdAt': DateTime.now().toIso8601String(),
      };
      final id = await database.insert('notes', data);

      final deletedRows =
          await database.delete('notes', where: 'id = ?', whereArgs: [id]);
      expect(deletedRows, 1);

      final result = await database.query('notes');
      expect(result.isEmpty, true);
    });

    test(
        'Should insert and query a record in the commands table with a foreign key',
        () async {
      final noteData = {
        'title': 'Foreign Key Note',
        'description': 'Note for foreign key testing',
        'createdAt': DateTime.now().toIso8601String(),
      };
      final noteId = await database.insert('notes', noteData);

      final commandData = {
        'noteId': noteId,
        'value': 'Sample Command',
        'arguments': 'arg1,arg2',
      };
      final commandId = await database.insert('commands', commandData);

      expect(commandId, isNonZero);

      final result = await database
          .query('commands', where: 'noteId = ?', whereArgs: [noteId]);
      expect(result.length, 1);
      expect(result[0]['value'], 'Sample Command');
    });
  });
}
