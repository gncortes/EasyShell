import 'package:dartz/dartz.dart';
import 'package:easy_shell/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.mocks.dart';

class ContractTestNotesRepository implements NotesRepository {
  final NoteEntity mockNoteEntity;

  ContractTestNotesRepository(this.mockNoteEntity);
  @override
  Future<Either<NotesError, NoteEntity>> create(CreateNoteInput input) async {
    if (input.name.isNotEmpty) {
      return Right(mockNoteEntity);
    }
    return const Left(NotesError('Name cannot be empty', code: 400));
  }
}

void main() {
  group('NotesRepository Contract', () {
    late NotesRepository repository;
    late MockNoteEntity mockNoteEntity;

    setUp(() {
      mockNoteEntity = MockNoteEntity();
      repository = ContractTestNotesRepository(mockNoteEntity);
    });

    test('should return Right(MockNoteEntity) when creating with valid input',
        () async {
      const input = CreateNoteInput(
        name: 'Valid Note Name',
        description: 'Valid description',
        commands: [CreateCommand(value: 'echo', args: 'Hello World')],
      );

      final result = await repository.create(input);

      expect(result.isRight(), true,
          reason: 'The repository should return Right for valid input');
      result.fold(
        (_) => fail('Expected Right(NoteEntity), but got Left(NotesError)'),
        (note) {
          expect(note, isA<NoteEntity>(),
              reason: 'Expected result to be a NoteEntity');
          expect(note.toString(), equals('MockNoteEntity'));
        },
      );
    });

    test('should return Left(NotesError) when creating with invalid input',
        () async {
      const input = CreateNoteInput(
        name: '',
        description: 'Description without a valid name',
        commands: [CreateCommand(value: 'echo', args: 'Hello')],
      );

      final result = await repository.create(input);

      expect(result.isLeft(), true,
          reason: 'The repository should return Left for invalid input');
      result.fold(
        (error) {
          expect(error, isA<NotesError>(),
              reason: 'Expected result to be a NotesError');
          expect(error.message, equals('Name cannot be empty'),
              reason: 'Expected error message to indicate empty name');
          expect(error.code, equals(400),
              reason: 'Expected error code 400 for invalid input');
        },
        (_) => fail('Expected Left(NotesError), but got Right(NoteEntity)'),
      );
    });
  });
}
