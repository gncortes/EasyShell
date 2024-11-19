import '../../domain/entities/note.dart';

class NoteModel {
  NoteModel._();

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel._();
  }

  NoteEntity toEntity() {
    return NoteEntity();
  }
}
