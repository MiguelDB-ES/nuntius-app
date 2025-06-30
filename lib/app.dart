// lib/app.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_router.dart';
import 'package:nuntius/core/routes/app_routes.dart';
// **CRUCIAL:** Verifique se este import está correto para o seu pacote
import 'package:nuntius/core/theme/app_theme.dart';

class NuntiusApp extends StatelessWidget {
  const NuntiusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuntius',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
