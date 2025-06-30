// lib/data/database/schemas/logs_sistema_schema.dart
class LogsSistemaSchema {
  static const String tableName = 'LogsSistema';

  static const String id = 'id';
  static const String dataHora = 'data_hora';
  static const String idUsuario = 'id_usuario';
  static const String tipoEvento = 'tipo_evento';
  static const String descricaoEvento = 'descricao_evento';
  static const String idEntidadeAfetada = 'id_entidade_afetada';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $dataHora TEXT NOT NULL,
      $idUsuario INTEGER,
      $tipoEvento TEXT NOT NULL,
      $descricaoEvento TEXT NOT NULL,
      $idEntidadeAfetada INTEGER,
      FOREIGN KEY ($idUsuario) REFERENCES Usuarios(id)
    )
  ''';
}
