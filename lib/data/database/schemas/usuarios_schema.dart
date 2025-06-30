// lib/data/database/schemas/usuarios_schema.dart
class UsuariosSchema {
  static const String tableName = 'Usuarios';

  static const String id = 'id';
  static const String nomeCompleto = 'nome_completo';
  static const String email = 'email';
  static const String cpf = 'cpf';
  static const String senhaHash = 'senha_hash';
  static const String dataNascimento = 'data_nascimento';
  static const String endereco = 'endereco';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String tipoUsuario = 'tipo_usuario';
  static const String urlFotoPerfil = 'url_foto_perfil';
  static const String dataCadastro = 'data_cadastro';
  static const String ativo = 'ativo';

  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $nomeCompleto TEXT NOT NULL,
      $email TEXT UNIQUE NOT NULL,
      $cpf TEXT UNIQUE,
      $senhaHash TEXT NOT NULL,
      $dataNascimento TEXT,
      $endereco TEXT,
      $latitude REAL,
      $longitude REAL,
      $tipoUsuario TEXT NOT NULL,
      $urlFotoPerfil TEXT,
      $dataCadastro TEXT NOT NULL,
      $ativo INTEGER NOT NULL DEFAULT 1
    )
  ''';
}
