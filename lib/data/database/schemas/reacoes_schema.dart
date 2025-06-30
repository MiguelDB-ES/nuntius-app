// lib/data/database/schemas/reacoes_schema.dart
class ReacoesSchema {
  static const String tableName = 'Reacoes';

  static const String idUsuario = 'id_usuario';
  static const String idPostagem = 'id_postagem';
  static const String idComentario = 'id_comentario';
  static const String tipoReacao = 'tipo_reacao';
  static const String dataReacao = 'data_reacao';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $idUsuario INTEGER NOT NULL,
      $idPostagem INTEGER,
      $idComentario INTEGER,
      $tipoReacao TEXT NOT NULL,
      $dataReacao TEXT NOT NULL,
      
      UNIQUE($idUsuario, $tipoReacao, $idPostagem, $idComentario),

      CHECK (
        ($idPostagem IS NOT NULL AND $idComentario IS NULL) OR
        ($idPostagem IS NULL AND $idComentario IS NOT NULL)
      ),

      FOREIGN KEY ($idUsuario) REFERENCES Usuarios(id) ON DELETE CASCADE,
      FOREIGN KEY ($idPostagem) REFERENCES Postagens(id) ON DELETE CASCADE,
      FOREIGN KEY ($idComentario) REFERENCES Comentarios(id) ON DELETE CASCADE
    )
  ''';
}
