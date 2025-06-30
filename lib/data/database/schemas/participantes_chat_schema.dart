// lib/data/database/schemas/participantes_chat_schema.dart
class ParticipantesChatSchema {
  static const String tableName = 'ParticipantesChat';

  static const String idChat = 'id_chat';
  static const String idUsuario = 'id_usuario';
  static const String funcao = 'funcao';
  static const String dataEntrada = 'data_entrada';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $idChat INTEGER NOT NULL,
      $idUsuario INTEGER NOT NULL,
      $funcao TEXT,
      $dataEntrada TEXT NOT NULL,
      PRIMARY KEY ($idChat, $idUsuario),
      FOREIGN KEY ($idChat) REFERENCES Chats(id),
      FOREIGN KEY ($idUsuario) REFERENCES Usuarios(id)
    )
  ''';
}
