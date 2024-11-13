import 'package:easy_shell/data/datasource/notes_datasource.dart';
import 'package:easy_shell/data/models/note.dart';
import 'package:easy_shell/data/repositories/notes_repository.dart';
import 'package:easy_shell/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.mocks.dart';

void main() {
  late NotesRepository repository;
  late NotesDatasource mockDatasource;
  late NoteEntity mockNoteEntity;
  late NoteModel mockNoteModel;

  setUp(() {
    mockDatasource = MockNotesDatasource();
    repository = NotesRepositoryImplementation(mockDatasource);
    mockNoteEntity = MockNoteEntity();
    mockNoteModel = MockNoteModel();
  });

  group('NotesRepositoryImplementation', () {
    test('should return Right(NoteEntity) when create is successful', () async {
      const input = CreateNoteInput(
        name: 'Valid Note Name',
        description: 'Valid description',
        commands: [CreateCommand(value: 'echo', args: 'Hello World')],
      );

      // Mock the datasource behavior to return a NoteEntity
      when(mockDatasource.create(input)).thenAnswer((_) async => mockNoteModel);

      when(mockNoteModel.toEntity()).thenAnswer((_) => mockNoteEntity);

      // Act
      final result = await repository.create(input);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (error) => fail('Expected Right(NoteEntity), but got Left(NotesError)'),
        (note) {
          expect(note, isA<NoteEntity>());
          expect(note.toString(), equals('MockNoteEntity'));
        },
      );
    });

    test('should return Left(NotesError) when create fails', () async {
      // Prepare the mock input
      const input = CreateNoteInput(
        name: 'Invalid Note',
        description: 'Description without commands',
        commands: [],
      );

      // Mock the datasource behavior to throw an error
      when(mockDatasource.create(input))
          .thenThrow(Exception('Datasource error'));

      // Act
      final result = await repository.create(input);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (error) {
          expect(error, isA<NotesError>());
          expect(error.message, 'Exception: Datasource error');
          expect(error.code, -99);
        },
        (_) => fail('Expected Left(NotesError), but got Right(NoteEntity)'),
      );
    });
  });
}
