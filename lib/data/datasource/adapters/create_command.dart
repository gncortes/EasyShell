import '../../../domain/input/create_command.dart';

class CreateCommandInputAdapter extends CreateCommandInput {
  final int noteId;

  CreateCommandInputAdapter._({
    required super.value,
    required super.args,
    required this.noteId,
  });

  factory CreateCommandInputAdapter.fromInput(
    CreateCommandInput input, {
    required int noteId,
  }) {
    return CreateCommandInputAdapter._(
      value: input.value,
      args: input.args,
      noteId: noteId,
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
