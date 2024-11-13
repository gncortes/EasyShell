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
          'commands',
          commandArgs,
        );
      }

      final noteResult = await _databaseService.query(
        'notes',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (noteResult.isEmpty) {
        return throw const NotesError(
          'Erro ao criar a nota',
          code: -1,
        );
      }

      return NoteModel.fromJson(noteResult.first);
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
