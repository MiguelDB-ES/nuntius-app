// lib/data/database/schemas/chats_schema.dart
class ChatsSchema {
  static const String tableName = 'Chats';

  static const String id = 'id';
  static const String tipoChat = 'tipo_chat';
  static const String nomeGrupo = 'nome_grupo';
  static const String dataCriacao = 'data_criacao';
  static const String urlFotoGrupo = 'url_foto_grupo';
  static const String idCriadorGrupo = 'id_criador_grupo';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $tipoChat TEXT NOT NULL,
      $nomeGrupo TEXT,
      $dataCriacao TEXT NOT NULL,
      $urlFotoGrupo TEXT,
      $idCriadorGrupo INTEGER,
      FOREIGN KEY ($idCriadorGrupo) REFERENCES Usuarios(id)
    )
  ''';
}
