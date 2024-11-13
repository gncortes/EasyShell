import 'app_error.dart';

class NotesError extends AppError {
  final int code;

  const NotesError(
    super.message, {
    required this.code,
  });

  @override
  String toString() => 'Exception: $message, code: $code';
}
