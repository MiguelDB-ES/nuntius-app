// lib/data/database/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// VERIFIQUE: Todos os imports de schemas devem usar 'package:nuntius/' e os nomes corretos dos arquivos.
import 'package:nuntius/data/database/schemas/usuarios_schema.dart';
import 'package:nuntius/data/database/schemas/postagens_schema.dart';
import 'package:nuntius/data/database/schemas/comentarios_schema.dart';
import 'package:nuntius/data/database/schemas/configuracoes_usuario_schema.dart';
import 'package:nuntius/data/database/schemas/foruns_schema.dart';
import 'package:nuntius/data/database/schemas/topicos_forum_schema.dart';
import 'package:nuntius/data/database/schemas/chats_schema.dart';
import 'package:nuntius/data/database/schemas/participantes_chat_schema.dart';
import 'package:nuntius/data/database/schemas/reacoes_schema.dart';
import 'package:nuntius/data/database/schemas/seguidores_schema.dart';
import 'package:nuntius/data/database/schemas/anexos_postagem_schema.dart';
import 'package:nuntius/data/database/schemas/logs_sistema_schema.dart';


class DatabaseHelper {
  static Database? _database;
  static const String _databaseName = 'nuntius.db';
  static const int _databaseVersion = 2; // INCREMENTADO PARA A VERSÃO 2

  // Singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    String databasePath = join(path, _databaseName);
    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Garante que onUpgrade é chamado
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  // Método chamado quando o banco de dados é criado pela primeira vez
  Future _onCreate(Database db, int version) async {
    print("Criando tabelas para a versão $version...");
    await db.execute(UsuariosSchema.createTableSql);
    await db.execute(ForunsSchema.createTableSql);
    await db.execute(ChatsSchema.createTableSql);

    await db.execute(ConfiguracoesUsuarioSchema.createTableSql);
    await db.execute(LogsSistemaSchema.createTableSql);

    await db.execute(PostagensSchema.createTableSql);
    await db.execute(TopicosForumSchema.createTableSql);
    await db.execute(ParticipantesChatSchema.createTableSql);
    await db.execute(SeguidoresSchema.createTableSql);

    await db.execute(AnexosPostagemSchema.createTableSql);
    await db.execute(ComentariosSchema.createTableSql);

    await db.execute(ReacoesSchema.createTableSql);
    print("Tabelas criadas com sucesso.");
  }

  // Método chamado quando a versão do banco de dados é incrementada
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("Atualizando banco de dados de $oldVersion para $newVersion...");

    if (oldVersion < 2) {
      // Migração da versão 1 para a versão 2
      // Alterações:
      // - Remoção da restrição UNIQUE do campo 'cpf' na tabela 'Usuarios'.
      // - Adição de DEFAULT 'fisica' para 'tipo_usuario' na tabela 'Usuarios'.

      // 1. Renomear a tabela antiga
      await db.execute('ALTER TABLE ${UsuariosSchema.tableName} RENAME TO ${UsuariosSchema.tableName}_old');
      print("Tabela ${UsuariosSchema.tableName} renomeada para ${UsuariosSchema.tableName}_old.");

      // 2. Criar a nova tabela com o novo esquema
      await db.execute(UsuariosSchema.createTableSql);
      print("Nova tabela ${UsuariosSchema.tableName} criada.");

      // 3. Copiar dados da tabela antiga para a nova
      // Seleciona todas as colunas da tabela antiga, exceto 'cnpj' se existisse
      // E garante que 'tipo_usuario' tenha um valor padrão se for nulo na antiga
      await db.execute('''
        INSERT INTO ${UsuariosSchema.tableName} (
          ${UsuariosSchema.id},
          ${UsuariosSchema.nomeCompleto},
          ${UsuariosSchema.email},
          ${UsuariosSchema.cpf},
          ${UsuariosSchema.senhaHash},
          ${UsuariosSchema.dataNascimento},
          ${UsuariosSchema.endereco},
          ${UsuariosSchema.latitude},
          ${UsuariosSchema.longitude},
          ${UsuariosSchema.tipoUsuario},
          ${UsuariosSchema.urlFotoPerfil},
          ${UsuariosSchema.dataCadastro},
          ${UsuariosSchema.ativo}
        )
        SELECT
          ${UsuariosSchema.id},
          ${UsuariosSchema.nomeCompleto},
          ${UsuariosSchema.email},
          ${UsuariosSchema.cpf},
          ${UsuariosSchema.senhaHash},
          ${UsuariosSchema.dataNascimento},
          ${UsuariosSchema.endereco},
          ${UsuariosSchema.latitude},
          ${UsuariosSchema.longitude},
          COALESCE(${UsuariosSchema.tipoUsuario}, 'fisica'), -- Garante 'fisica' se for nulo
          ${UsuariosSchema.urlFotoPerfil},
          ${UsuariosSchema.dataCadastro},
          ${UsuariosSchema.ativo}
        FROM ${UsuariosSchema.tableName}_old
      ''');
      print("Dados copiados de ${UsuariosSchema.tableName}_old para ${UsuariosSchema.tableName}.");

      // 4. Excluir a tabela antiga
      await db.execute('DROP TABLE ${UsuariosSchema.tableName}_old');
      print("Tabela ${UsuariosSchema.tableName}_old excluída.");
    }
    print("Atualização do banco de dados concluída para a versão $newVersion.");
  }
}
