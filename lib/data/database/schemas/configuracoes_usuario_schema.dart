// lib/data/database/schemas/configuracoes_usuario_schema.dart
class ConfiguracoesUsuarioSchema {
  static const String tableName = 'ConfiguracoesUsuario';

  static const String idUsuario = 'id_usuario';
  static const String temaApp = 'tema_app';
  static const String notificacoesForum = 'notificacoes_forum';
  static const String notificacoesDenuncia = 'notificacoes_denuncia';
  static const String idioma = 'idioma';
  static const String ultimaAtualizacao = 'ultima_atualizacao';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $idUsuario INTEGER PRIMARY KEY,
      $temaApp TEXT NOT NULL,
      $notificacoesForum INTEGER NOT NULL,
      $notificacoesDenuncia INTEGER NOT NULL,
      $idioma TEXT NOT NULL,
      $ultimaAtualizacao TEXT NOT NULL,
      FOREIGN KEY ($idUsuario) REFERENCES Usuarios(id)
    )
  ''';
}
