import 'package:dartz/dartz.dart';

import '../../domain/entities/note.dart';

import '../../domain/errors/notes_error.dart';

import '../../domain/input/create_note.dart';

import '../../domain/repositories/notes_repository.dart';
import '../datasource/notes_datasource.dart';

class NotesRepositoryImplementation implements NotesRepository {
  final NotesDatasource _datasource;

  NotesRepositoryImplementation(this._datasource);

  @override
  Future<Either<NotesError, NoteEntity>> create(
    CreateNoteInput input,
  ) async {
    try {
      final response = await _datasource.create(input);

      return Right(response.toEntity());
    } catch (error) {
      return Left(
        NotesError(error.toString(), code: -99),
      );
    }
  }
}
