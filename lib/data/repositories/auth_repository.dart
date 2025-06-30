// lib/data/repositories/auth_repository.dart
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart'; // NOVO: Importe para usar debugPrint
import 'package:nuntius/data/database/schemas/database_helper.dart'; 
import 'package:nuntius/data/database/schemas/usuarios_schema.dart'; 
import 'package:nuntius/models/user_model.dart'; 
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
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
      userType: user.userType,
      profilePictureUrl: user.profilePictureUrl,
      registrationDate: user.registrationDate,
      isActive: user.isActive,
    );

    try {
      return await db.insert(
        UsuariosSchema.tableName,
        userToSave.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint('Erro ao registrar usuário: $e'); 
      return -1;
    }
  }

  /// Tenta autenticar um usuário.
  /// Retorna o UserModel se o login for bem-sucedido e o usuário estiver ativo, caso contrário, retorna null.
  Future<UserModel?> loginUser(String emailOrCpf, String password) async {
    final db = await _databaseHelper.database;
    final hashedPassword = _hashPassword(password);

    final List<Map<String, dynamic>> results = await db.query(
      UsuariosSchema.tableName,
      where: '(${UsuariosSchema.email} = ? OR ${UsuariosSchema.cpf} = ?) AND ${UsuariosSchema.senhaHash} = ? AND ${UsuariosSchema.ativo} = 1',
      whereArgs: [emailOrCpf, emailOrCpf, hashedPassword],
    );

    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
    }
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
    return await db.update(
      UsuariosSchema.tableName,
      user.toMap(),
      where: '${UsuariosSchema.id} = ?',
      whereArgs: [user.id],
    );
  }

  /// Deleta um usuário.
  Future<int> deleteUser(int id) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      UsuariosSchema.tableName,
      where: '${UsuariosSchema.id} = ?',
      whereArgs: [id],
    );
  }
}
