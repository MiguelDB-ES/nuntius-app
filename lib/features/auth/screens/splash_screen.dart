import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 100, color: Theme.of(context).primaryColor),
            SizedBox(height: 20),
            Text('Nuntius', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 48, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Conectando Cidadãos e Agentes Públicos', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 50),
            CircularProgressIndicator(color: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}