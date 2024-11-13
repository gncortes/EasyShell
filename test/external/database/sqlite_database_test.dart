import 'package:easy_shell/external/database/sql/sql.dart';
import 'package:easy_shell/external/database/sqlite_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.mocks.dart';

void main() {
  late SQLiteDatabase sqliteDatabase;
  late MockDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockDatabase();
    sqliteDatabase = SQLiteDatabase();
  });

  group('SQLiteDatabase', () {
    test('init should initialize the database', () async {
      when(mockDatabase.execute(any)).thenAnswer((_) async => {});

      await sqliteDatabase.init();

      verify(mockDatabase.execute(SQLNoteQueries.createTableNotes)).called(1);
      verify(mockDatabase.execute(SQLCommandQueries.createTableCommands))
          .called(1);
    });

    test('insert should insert data into the table', () async {
      when(mockDatabase.insert('notes', any)).thenAnswer((_) async => 1);

      final result =
          await sqliteDatabase.insert('notes', {'title': 'Test Note'});

      expect(result, 1);
      verify(mockDatabase.insert('notes', {'title': 'Test Note'})).called(1);
    });

    test('query should retrieve data from the table', () async {
      final mockData = [
        {'title': 'Test Note'}
      ];
      when(mockDatabase.query('notes')).thenAnswer((_) async => mockData);

      final result = await sqliteDatabase.query('notes');

      expect(result, mockData);
      verify(mockDatabase.query('notes')).called(1);
    });

    test('update should update data in the table', () async {
      when(mockDatabase.update('notes', any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      final result = await sqliteDatabase.update(
          'notes', {'title': 'Updated Note'},
          where: 'id = ?', whereArgs: [1]);

      expect(result, 1);
      verify(mockDatabase.update('notes', {'title': 'Updated Note'},
          where: 'id = ?', whereArgs: [1])).called(1);
    });

    test('delete should remove data from the table', () async {
      when(mockDatabase.delete('notes',
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      final result =
          await sqliteDatabase.delete('notes', where: 'id = ?', whereArgs: [1]);

      expect(result, 1);
      verify(mockDatabase.delete('notes', where: 'id = ?', whereArgs: [1]))
          .called(1);
    });

    test('close should close the database connection', () async {
      when(mockDatabase.close()).thenAnswer((_) async => null);

      await sqliteDatabase.close();

      verify(mockDatabase.close()).called(1);
    });
  });
}
