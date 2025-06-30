// lib/data/database/schemas/postagens_schema.dart
class PostagensSchema {
  static const String tableName = 'Postagens';

  static const String id = 'id';
  static const String idUsuarioAutor = 'id_usuario_autor';
  static const String titulo = 'titulo';
  static const String descricao = 'descricao';
  static const String tipoPostagem = 'tipo_postagem';
  static const String categoria = 'categoria';
  static const String status = 'status';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String dataCriacao = 'data_criacao';
  static const String dataAtualizacao = 'data_atualizacao';
  static const String aprovadaModeracao = 'aprovada_moderacao';
  static const String urlImagemPrincipal = 'url_imagem_principal';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $idUsuarioAutor INTEGER NOT NULL,
      $titulo TEXT NOT NULL,
      $descricao TEXT NOT NULL,
      $tipoPostagem TEXT NOT NULL,
      $categoria TEXT,
      $status TEXT,
      $latitude REAL,
      $longitude REAL,
      $dataCriacao TEXT NOT NULL,
      $dataAtualizacao TEXT NOT NULL,
      $aprovadaModeracao INTEGER NOT NULL DEFAULT 0,
      $urlImagemPrincipal TEXT,
      FOREIGN KEY ($idUsuarioAutor) REFERENCES Usuarios(id)
    )
  ''';
}
