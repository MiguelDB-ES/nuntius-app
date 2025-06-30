// lib/data/database/schemas/usuarios_schema.dart
class UsuariosSchema {
  static const String tableName = 'Usuarios';

  // Nomes das colunas da tabela de usuários
  static const String id = 'id';
  static const String nomeCompleto = 'nome_completo';
  static const String email = 'email';
  static const String cpf = 'cpf'; // Usado para CPF (Pessoa Física)
  static const String senhaHash = 'senha_hash';
  static const String dataNascimento = 'data_nascimento';
  static const String endereco = 'endereco';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String tipoUsuario = 'tipo_usuario'; // 'fisica' ou 'admin'
  static const String urlFotoPerfil = 'url_foto_perfil';
  static const String dataCadastro = 'data_cadastro';
  static const String ativo = 'ativo';

  // Comando SQL para criar a tabela de usuários
  static const String createTableSql = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $nomeCompleto TEXT NOT NULL,
      $email TEXT UNIQUE NOT NULL,
      $cpf TEXT, -- CPF pode ser nulo e não precisa ser UNIQUE se não for um identificador principal
      $senhaHash TEXT NOT NULL,
      $dataNascimento TEXT,
      $endereco TEXT,
      $latitude REAL,
      $longitude REAL,
      $tipoUsuario TEXT NOT NULL DEFAULT 'fisica', -- Define 'fisica' como padrão
      $urlFotoPerfil TEXT,
      $dataCadastro TEXT NOT NULL,
      $ativo INTEGER NOT NULL DEFAULT 1
    )
  ''';
}
