import 'package:dartz/dartz.dart';

import '../entities/note.dart';
import '../errors/notes_error.dart';
import '../input/create_note.dart';

abstract interface class NotesRepository {
  Future<Either<NotesError, NoteEntity>> create(CreateNoteInput input);
}
