import '../../domain/input/create_note.dart';
import '../models/note.dart';

abstract interface class NotesDatasource {
  Future<NoteModel> create(CreateNoteInput input);
}
