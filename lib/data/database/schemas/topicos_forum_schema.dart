// lib/data/database/schemas/topicos_forum_schema.dart
class TopicosForumSchema {
  static const String tableName = 'TopicosForum';

  static const String id = 'id';
  static const String idForum = 'id_forum';
  static const String idUsuarioAutor = 'id_usuario_autor';
  static const String titulo = 'titulo';
  static const String conteudo = 'conteudo';
  static const String dataCriacao = 'data_criacao';
  static const String dataUltimaAtividade = 'data_ultima_atividade';
  static const String moderado = 'moderado';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $idForum INTEGER NOT NULL,
      $idUsuarioAutor INTEGER NOT NULL,
      $titulo TEXT NOT NULL,
      $conteudo TEXT NOT NULL,
      $dataCriacao TEXT NOT NULL,
      $dataUltimaAtividade TEXT NOT NULL,
      $moderado INTEGER NOT NULL DEFAULT 0,
      FOREIGN KEY ($idForum) REFERENCES Foruns(id),
      FOREIGN KEY ($idUsuarioAutor) REFERENCES Usuarios(id)
    )
  ''';
}
