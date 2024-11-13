import '../../../domain/input/create_note.dart';

class CreateNoteInputAdapter extends CreateNoteInput {
  CreateNoteInputAdapter({
    required super.name,
    required super.description,
    required super.commands,
  });

  Map<String, dynamic> toJson() {
    return {};
  }
}
