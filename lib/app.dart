// lib/app.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_router.dart';
import 'package:nuntius/core/routes/app_routes.dart';
import 'package:nuntius/core/theme/app_theme.dart';

class NuntiusApp extends StatelessWidget {
  const NuntiusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuntius',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Aceder diretamente à propriedade ThemeData
      darkTheme: AppTheme.darkTheme, // Aceder diretamente à propriedade ThemeData
      themeMode: ThemeMode.system, // Usa o tema do sistema (claro/escuro)
      initialRoute: AppRoutes.splash, // A rota inicial é a SplashScreen
      onGenerateRoute: AppRouter.generateRoute, // Gerencia todas as rotas
    );
  }
}
