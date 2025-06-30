// lib/data/repositories/auth_repository.dart
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart'; // Importe para usar debugPrint
import 'package:nuntius/data/database/schemas/database_helper.dart';
import 'package:nuntius/data/database/schemas/usuarios_schema.dart';
import 'package:nuntius/models/user_model.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // NOVO: Importe shared_preferences

class AuthRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Salva as informações do usuário logado no SharedPreferences.
  Future<void> _saveUserSession(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    // Converte o UserModel para JSON e salva como string
    await prefs.setString('currentUser', json.encode(user.toMap()));
    debugPrint('Sessão do usuário salva: ${user.email}');
  }

  /// Carrega as informações do usuário logado do SharedPreferences.
  Future<UserModel?> loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('currentUser');
    if (userJson != null) {
      debugPrint('Sessão do usuário carregada.');
      // Converte a string JSON de volta para UserModel
      return UserModel.fromMap(json.decode(userJson));
    }
    debugPrint('Nenhuma sessão de usuário encontrada.');
    return null;
  }

  /// Limpa as informações do usuário logado do SharedPreferences.
  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
    debugPrint('Sessão do usuário limpa.');
  }

  /// Registra um novo usuário no banco de dados.
  /// Retorna o ID da linha inserida ou -1 em caso de falha.
  Future<int> registerUser(UserModel user) async {
    final db = await _databaseHelper.database;
    final hashedPassword = _hashPassword(user.passwordHash);

    final userToSave = UserModel(
      fullName: user.fullName,
      email: user.email,
      cpf: user.cpf,
      passwordHash: hashedPassword,
      dateOfBirth: user.dateOfBirth,
      address: user.address,
      latitude: user.latitude,
      longitude: user.longitude,
      userType: user.userType, // Garante que o tipo de usuário seja passado
      profilePictureUrl: user.profilePictureUrl,
      registrationDate: user.registrationDate,
      isActive: user.isActive,
    );

    try {
      final id = await db.insert(
        UsuariosSchema.tableName,
        userToSave.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint('Usuário registrado com ID: $id');
      return id;
    } catch (e) {
      debugPrint('Erro ao registrar usuário: $e');
      return -1; // Indica falha no registro
    }
  }

  /// Realiza o login do usuário.
  /// Retorna o UserModel se o login for bem-sucedido, caso contrário, retorna null.
  Future<UserModel?> loginUser(String emailOrCpf, String password) async {
    final db = await _databaseHelper.database;
    final hashedPassword = _hashPassword(password);

    debugPrint('Tentando login para: $emailOrCpf com hash: $hashedPassword');

    final List<Map<String, dynamic>> results = await db.query(
      UsuariosSchema.tableName,
      where: '(${UsuariosSchema.email} = ? OR ${UsuariosSchema.cpf} = ?) AND ${UsuariosSchema.senhaHash} = ? AND ${UsuariosSchema.ativo} = 1',
      whereArgs: [emailOrCpf, emailOrCpf, hashedPassword],
    );

    if (results.isNotEmpty) {
      final user = UserModel.fromMap(results.first);
      await _saveUserSession(user); // Salva a sessão do usuário
      debugPrint('Login bem-sucedido para: ${user.email}');
      return user;
    }
    debugPrint('Falha no login para: $emailOrCpf');
    return null;
  }

  /// Busca um usuário pelo ID.
  Future<UserModel?> getUserById(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> results = await db.query(
      UsuariosSchema.tableName,
      where: '${UsuariosSchema.id} = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
    }
    return null;
  }

  /// Atualiza as informações de um usuário.
  Future<int> updateUser(UserModel user) async {
    final db = await _databaseHelper.database;
    try {
      final rowsAffected = await db.update(
        UsuariosSchema.tableName,
        user.toMap(),
        where: '${UsuariosSchema.id} = ?',
        whereArgs: [user.id],
      );
      if (rowsAffected > 0) {
        // Se o usuário atualizado for o usuário logado, atualize a sessão
        final currentUser = await loadUserSession();
        if (currentUser != null && currentUser.id == user.id) {
          await _saveUserSession(user);
        }
      }
      debugPrint('Usuário atualizado: ${user.email}, Linhas afetadas: $rowsAffected');
      return rowsAffected;
    } catch (e) {
      debugPrint('Erro ao atualizar usuário: $e');
      return 0;
    }
  }

  /// Desativa um usuário (define 'ativo' como 0).
  Future<int> deactivateUser(int id) async {
    final db = await _databaseHelper.database;
    try {
      final rowsAffected = await db.update(
        UsuariosSchema.tableName,
        {UsuariosSchema.ativo: 0},
        where: '${UsuariosSchema.id} = ?',
        whereArgs: [id],
      );
      debugPrint('Usuário desativado com ID: $id, Linhas afetadas: $rowsAffected');
      return rowsAffected;
    } catch (e) {
      debugPrint('Erro ao desativar usuário: $e');
      return 0;
    }
  }

  /// Ativa um usuário (define 'ativo' como 1).
  Future<int> activateUser(int id) async {
    final db = await _databaseHelper.database;
    try {
      final rowsAffected = await db.update(
        UsuariosSchema.tableName,
        {UsuariosSchema.ativo: 1},
        where: '${UsuariosSchema.id} = ?',
        whereArgs: [id],
      );
      debugPrint('Usuário ativado com ID: $id, Linhas afetadas: $rowsAffected');
      return rowsAffected;
    } catch (e) {
      debugPrint('Erro ao ativar usuário: $e');
      return 0;
    }
  }
}
