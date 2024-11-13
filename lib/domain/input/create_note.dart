import 'create_command.dart';

class CreateNoteInput {
  final String name;
  final String description;
  final List<CreateCommand> commands;

  const CreateNoteInput({
    required this.name,
    required this.description,
    required this.commands,
  });
}
