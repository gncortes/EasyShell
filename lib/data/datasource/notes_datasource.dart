import '../../domain/errors/database_error.dart';
import '../../domain/errors/notes_error.dart';
import '../../domain/input/create_note.dart';
import '../../external/database/database_service.dart';
import '../models/note.dart';
import 'adapters/create_command.dart';
import 'adapters/create_note.dart';

abstract interface class NotesDatasource {
  Future<NoteModel> create(CreateNoteInput input);
}

class NotesDatasourceImplementation implements NotesDatasource {
  final DatabaseService _databaseService;

  const NotesDatasourceImplementation(this._databaseService);

  @override
  Future<NoteModel> create(CreateNoteInput input) async {
    try {
      final noteArgs = CreateNoteInputAdapter.fromInput(input).toJson();
      final int id = await _databaseService.insert(
        'notes',
        noteArgs,
      );

      for (final command in input.commands) {
        final commandArgs = CreateCommandInputAdapter.fromInput(
          command,
          noteId: id,
        ).toJson();

        await _databaseService.insert(
          'notes',
          commandArgs,
        );
      }

      return NoteModel.fromJson({});
    } on DatabaseError {
      rethrow;
    } catch (err) {
      throw NotesError(
        err.toString().replaceAll('Exception: ', ''),
        code: -99,
      );
    }
  }
}
