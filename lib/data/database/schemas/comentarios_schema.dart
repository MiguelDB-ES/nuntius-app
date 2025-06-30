// lib/data/database/schemas/comentarios_schema.dart
class ComentariosSchema {
  static const String tableName = 'Comentarios';

  static const String id = 'id';
  static const String idUsuarioAutor = 'id_usuario_autor';
  static const String idPostagem = 'id_postagem';
  static const String idTopicoForum = 'id_topico_forum';
  static const String conteudo = 'conteudo';
  static const String dataCriacao = 'data_criacao';
  static const String moderado = 'moderado';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $idUsuarioAutor INTEGER NOT NULL,
      $idPostagem INTEGER,
      $idTopicoForum INTEGER,
      $conteudo TEXT NOT NULL,
      $dataCriacao TEXT NOT NULL,
      $moderado INTEGER NOT NULL DEFAULT 0,
      FOREIGN KEY ($idUsuarioAutor) REFERENCES Usuarios(id),
      FOREIGN KEY ($idPostagem) REFERENCES Postagens(id),
      FOREIGN KEY ($idTopicoForum) REFERENCES TopicosForum(id),
      CHECK (($idPostagem IS NOT NULL AND $idTopicoForum IS NULL) OR ($idPostagem IS NULL AND $idTopicoForum IS NOT NULL))
    )
  ''';
}