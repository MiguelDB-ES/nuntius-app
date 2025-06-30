// lib/core/session/session_manager.dart
import 'package:nuntius/models/user_model.dart';
import 'package:flutter/foundation.dart'; // Para debugPrint

/// Uma classe singleton para gerenciar a sessão do usuário logado.
class SessionManager {
  // Instância única do SessionManager (singleton)
  static final SessionManager _instance = SessionManager._internal();

  // Construtor privado para garantir que apenas uma instância seja criada
  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  // Variável para armazenar o UserModel do usuário logado
  UserModel? _currentUser;

  /// Retorna o usuário atualmente logado. Pode ser nulo se nenhum usuário estiver logado.
  UserModel? get currentUser => _currentUser;

  /// Define o usuário atualmente logado.
  void setCurrentUser(UserModel? user) {
    _currentUser = user;
    if (user != null) {
      debugPrint('Usuário logado na sessão: ${user.email}');
    } else {
      debugPrint('Sessão do usuário limpa.');
    }
  }

  /// Verifica se há um usuário logado na sessão.
  bool get isLoggedIn => _currentUser != null;

  /// Limpa o usuário da sessão.
  void clearCurrentUser() {
    _currentUser = null;
    debugPrint('Usuário removido da sessão em memória.');
  }
}
