// lib/data/database/schemas/seguidores_schema.dart
class SeguidoresSchema {
  static const String tableName = 'Seguidores';

  static const String idUsuarioSeguidor = 'id_usuario_seguidor';
  static const String idUsuarioSeguido = 'id_usuario_seguido';
  static const String idForumSeguido = 'id_forum_seguido';
  static const String dataInicioSeguimento = 'data_inicio_seguimento';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $idUsuarioSeguidor INTEGER NOT NULL,
      $idUsuarioSeguido INTEGER,
      $idForumSeguido INTEGER,
      $dataInicioSeguimento TEXT NOT NULL,
      
      UNIQUE($idUsuarioSeguidor, $idUsuarioSeguido, $idForumSeguido),

      CHECK (
        ($idUsuarioSeguido IS NOT NULL AND $idForumSeguido IS NULL) OR
        ($idUsuarioSeguido IS NULL AND $idForumSeguido IS NOT NULL)
      ),

      FOREIGN KEY ($idUsuarioSeguidor) REFERENCES Usuarios(id) ON DELETE CASCADE,
      FOREIGN KEY ($idUsuarioSeguido) REFERENCES Usuarios(id) ON DELETE CASCADE,
      FOREIGN KEY ($idForumSeguido) REFERENCES Foruns(id) ON DELETE CASCADE
    )
  ''';
}
