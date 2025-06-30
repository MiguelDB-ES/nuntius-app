// lib/data/database/schemas/mensagens_schema.dart
class MensagensSchema {
  static const String tableName = 'Mensagens';

  static const String id = 'id';
  static const String idChat = 'id_chat';
  static const String idUsuarioRemetente = 'id_usuario_remetente';
  static const String conteudo = 'conteudo';
  static const String dataEnvio = 'data_envio';
  static const String lida = 'lida';
  static const String tipoMensagem = 'tipo_mensagem';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $idChat INTEGER NOT NULL,
      $idUsuarioRemetente INTEGER NOT NULL,
      $conteudo TEXT NOT NULL,
      $dataEnvio TEXT NOT NULL,
      $lida INTEGER NOT NULL DEFAULT 0,
      $tipoMensagem TEXT NOT NULL,
      FOREIGN KEY ($idChat) REFERENCES Chats(id),
      FOREIGN KEY ($idUsuarioRemetente) REFERENCES Usuarios(id)
    )
  ''';
}
