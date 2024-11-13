class SQLCommandQueries {
  static const String createTableCommands = '''
    CREATE TABLE commands (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      noteId INTEGER NOT NULL,
      value TEXT NOT NULL,
      arguments TEXT,
      FOREIGN KEY (noteId) REFERENCES notes(id) ON DELETE CASCADE
    );
  ''';
}
