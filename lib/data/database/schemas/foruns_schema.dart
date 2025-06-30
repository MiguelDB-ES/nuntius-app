// lib/data/database/schemas/foruns_schema.dart
class ForunsSchema {
  static const String tableName = 'Foruns';

  static const String id = 'id';
  static const String nomeForum = 'nome_forum';
  static const String descricao = 'descricao';
  static const String idAdminCriador = 'id_admin_criador';
  static const String dataCriacao = 'data_criacao';
  static const String ativo = 'ativo';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $nomeForum TEXT NOT NULL,
      $descricao TEXT,
      $idAdminCriador INTEGER NOT NULL,
      $dataCriacao TEXT NOT NULL,
      $ativo INTEGER NOT NULL DEFAULT 1,
      FOREIGN KEY ($idAdminCriador) REFERENCES Usuarios(id)
    )
  ''';
}
