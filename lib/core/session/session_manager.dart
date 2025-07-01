// lib/core/session/session_manager.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nuntius/models/user_model.dart';

class SessionManager {
  // Singleton instance
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  UserModel? _currentUser;
  SharedPreferences? _prefs;

  // Getter para o usuário atual
  UserModel? get currentUser => _currentUser;

  // Inicializa o SharedPreferences
  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Carrega o usuário da sessão persistente (SharedPreferences)
  Future<void> loadCurrentUser() async {
    await _initPrefs();
    final userJson = _prefs!.getString('currentUser');
    if (userJson != null) {
      _currentUser = UserModel.fromMap(json.decode(userJson));
    }
  }

  // Define o usuário atual e o salva na sessão persistente
  Future<void> setCurrentUser(UserModel user) async {
    await _initPrefs();
    _currentUser = user;
    await _prefs!.setString('currentUser', json.encode(user.toMap()));
  }

  // Limpa o usuário da sessão e do armazenamento persistente (logout)
  Future<void> logout() async {
    await _initPrefs();
    _currentUser = null;
    await _prefs!.remove('currentUser'); // Remove o usuário do SharedPreferences
  }

  // Verifica se há um usuário logado
  bool isLoggedIn() {
    return _currentUser != null;
  }
}
