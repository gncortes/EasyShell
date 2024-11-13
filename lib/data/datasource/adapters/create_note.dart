import '../../../domain/input/create_note.dart';

class CreateNoteInputAdapter extends CreateNoteInput {
  CreateNoteInputAdapter._({
    required super.name,
    required super.description,
    required super.commands,
  });

  factory CreateNoteInputAdapter.fromInput(CreateNoteInput input) {
    return CreateNoteInputAdapter._(
      name: input.name,
      description: input.description,
      commands: input.commands,
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
