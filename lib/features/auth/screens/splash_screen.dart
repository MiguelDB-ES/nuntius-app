// lib/features/auth/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';
import 'package:nuntius/core/session/session_manager.dart'; // Importe o SessionManager

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Verifica o status de login e redireciona o usuário
  Future<void> _checkLoginStatus() async {
    // Garante que o SessionManager carregue o usuário antes de verificar
    await SessionManager().loadCurrentUser();

    // Pequeno atraso para a splash screen ser visível (opcional)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return; // Verifica se o widget ainda está montado

    if (SessionManager().isLoggedIn()) {
      // Se o usuário estiver logado, navega para a tela inicial
      Navigator.of(context).pushReplacementNamed(AppRoutes.userHome);
    } else {
      // Se não estiver logado, navega para a tela de login
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Você pode adicionar um logo ou um indicador de carregamento aqui
            Image.asset(
              'assets/images/nuntius_logo.png', // Certifique-se de ter um logo na pasta assets/images
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 24),
            Text(
              'Nuntius',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(), // Indicador de carregamento
            const SizedBox(height: 8),
            Text(
              'Carregando...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
