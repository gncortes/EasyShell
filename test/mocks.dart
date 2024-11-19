import 'package:easy_shell/data/datasource/notes_datasource.dart';
import 'package:easy_shell/data/models/models.dart';
import 'package:easy_shell/domain/entities/note.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite/sqflite.dart';

@GenerateMocks([Database, NoteEntity, NotesDatasource, NoteModel])
void main() {}
