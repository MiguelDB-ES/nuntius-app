// lib/data/database/schemas/anexos_postagem_schema.dart
class AnexosPostagemSchema {
  static const String tableName = 'AnexosPostagem';

  static const String id = 'id';
  static const String idPostagem = 'id_postagem';
  static const String urlAnexo = 'url_anexo';
  static const String tipoAnexo = 'tipo_anexo';
  static const String ordem = 'ordem';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $idPostagem INTEGER NOT NULL,
      $urlAnexo TEXT NOT NULL,
      $tipoAnexo TEXT NOT NULL,
      $ordem INTEGER,
      FOREIGN KEY ($idPostagem) REFERENCES Postagens(id)
    )
  ''';
}
