import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bem-vindo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sua voz na comunidade', style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 40),
            ElevatedButton(onPressed: () => Navigator.of(context).pushNamed(AppRoutes.login), child: const Text('Entrar')),
            SizedBox(height: 20),
            OutlinedButton(onPressed: () => Navigator.of(context).pushNamed(AppRoutes.register), child: const Text('Registrar-se')),
          ],
        ),
      ),
    );
  }
}