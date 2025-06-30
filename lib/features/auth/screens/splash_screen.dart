// lib/features/auth/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';
import 'package:nuntius/data/repositories/auth_repository.dart';
import 'package:nuntius/core/session/session_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthRepository _authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    _checkUserSession();
  }

  Future<void> _checkUserSession() async {
    // Carrega a sessão do usuário do SharedPreferences
    final user = await _authRepository.loadUserSession();

    if (!mounted) return; // Garante que o widget ainda está montado

    if (user != null) {
      // Se houver um usuário salvo, define-o na sessão em memória
      SessionManager().setCurrentUser(user);
      // Redireciona para a Home Screen
      Navigator.of(context).pushReplacementNamed(AppRoutes.userHome);
    } else {
      // Se não houver usuário salvo, redireciona para a Welcome Screen
      Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Indicador de carregamento
            SizedBox(height: 20),
            Text('Carregando...', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
