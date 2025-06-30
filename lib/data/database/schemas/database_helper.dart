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
  static const int _databaseVersion = 1;

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
      onUpgrade: _onUpgrade,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future _onCreate(Database db, int version) async {
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
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Implemente a lógica de migração aqui
  }

  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }
}
