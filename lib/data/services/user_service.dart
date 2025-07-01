// lib/data/services/user_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nuntius/models/user_model.dart';
import 'package:flutter/foundation.dart'; // Para debugPrint

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  static const String _userKey = 'currentUser';
  static const String _notificationsKey = 'notificationsEnabled';
  static const String _privateAccountKey = 'privateAccount';
  static const String _themeKey = 'selectedTheme';

  UserModel? _currentUser;

  // Retorna o usuário atualmente logado
  UserModel? get currentUser => _currentUser;

  // Carrega o usuário e as configurações do SharedPreferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      _currentUser = UserModel.fromMap(json.decode(userJson));
      debugPrint('Usuário carregado: ${_currentUser?.fullName}');
    } else {
      debugPrint('Nenhum usuário salvo localmente.');
      // Opcional: Criar um usuário mock para testes se não houver nenhum
      _currentUser = UserModel(
        id: 1,
        fullName: 'Usuário Teste',
        email: 'teste@example.com',
        passwordHash: 'hashed_password', // Em um app real, isso viria do login
        userType: 'fisica',
        registrationDate: DateTime.now().toIso8601String(),
        profilePictureUrl: 'https://placehold.co/120x120/FFC107/FFFFFF?text=UT',
      );
      await saveUserData(_currentUser!); // Salva o mock para futuras sessões
      debugPrint('Usuário mock criado e salvo.');
    }
  }

  // Salva os dados do usuário no SharedPreferences
  Future<void> saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = user;
    await prefs.setString(_userKey, json.encode(user.toMap()));
    debugPrint('Usuário salvo: ${user.fullName}');
  }

  // Atualiza as informações do usuário
  Future<void> updateUserData(UserModel updatedUser) async {
    await saveUserData(updatedUser); // Apenas sobrescreve o usuário atual
    debugPrint('Usuário atualizado: ${updatedUser.fullName}');
  }

  // Carrega o estado das notificações
  Future<bool> getNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsKey) ?? true; // Padrão: ativado
  }

  // Salva o estado das notificações
  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, enabled);
    debugPrint('Notificações ${enabled ? 'ativadas' : 'desativadas'}');
  }

  // Carrega o estado da conta privada
  Future<bool> getPrivateAccount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_privateAccountKey) ?? false; // Padrão: pública
  }

  // Salva o estado da conta privada
  Future<void> setPrivateAccount(bool isPrivate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_privateAccountKey, isPrivate);
    debugPrint('Conta ${isPrivate ? 'privada' : 'pública'}');
  }

  // Carrega o tema selecionado
  Future<String> getSelectedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'Sistema'; // Padrão: Sistema
  }

  // Salva o tema selecionado
  Future<void> setSelectedTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
    debugPrint('Tema selecionado: $theme');
  }

  // Limpa todos os dados do usuário e configurações ao fazer logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    // Opcional: Manter configurações como tema, ou remover tudo
    // await prefs.clear(); // Limpa tudo, incluindo configurações
    _currentUser = null;
    debugPrint('Usuário deslogado e dados limpos.');
  }
}
