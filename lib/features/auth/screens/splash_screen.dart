import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Adicione aqui a lógica para carregar dados, verificar autenticação, etc.
    // Por exemplo, após 2 segundos, navegue para o ecrã de login ou home.
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pode adicionar um logótipo ou um indicador de progresso aqui
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('A carregar Nuntius...', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
