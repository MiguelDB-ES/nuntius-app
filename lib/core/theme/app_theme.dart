// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Importe o pacote google_fonts
import 'package:nuntius/core/theme/app_colors.dart';

class AppTheme {
  // Define a fonte padrão para o aplicativo
  static final TextTheme _appTextTheme = GoogleFonts.interTextTheme(); // Usando Inter como fonte padrão

  // Tema claro (Default Mode)
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.vibrantPink,
      scaffoldBackgroundColor: AppColors.primaryWhiteAcinzentado,
      appBarTheme: AppBarTheme( // Removendo 'const' aqui para permitir o uso de _appTextTheme.headlineMedium
        backgroundColor: AppColors.primaryWhiteAcinzentado,
        foregroundColor: AppColors.primaryTextDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _appTextTheme.headlineMedium?.copyWith(
          color: AppColors.primaryTextDark,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      textTheme: _appTextTheme.copyWith( // Aplica o tema de texto personalizado
        displayLarge: _appTextTheme.displayLarge?.copyWith(color: AppColors.primaryTextDark),
        displayMedium: _appTextTheme.displayMedium?.copyWith(color: AppColors.primaryTextDark),
        displaySmall: _appTextTheme.displaySmall?.copyWith(color: AppColors.primaryTextDark),
        headlineMedium: _appTextTheme.headlineMedium?.copyWith(color: AppColors.primaryTextDark),
        headlineSmall: _appTextTheme.headlineSmall?.copyWith(color: AppColors.primaryTextDark),
        titleLarge: _appTextTheme.titleLarge?.copyWith(color: AppColors.primaryTextDark),
        bodyLarge: _appTextTheme.bodyLarge?.copyWith(color: AppColors.primaryTextDark),
        bodyMedium: _appTextTheme.bodyMedium?.copyWith(color: AppColors.primaryTextDark),
        labelLarge: _appTextTheme.labelLarge?.copyWith(color: AppColors.primaryTextDark),
        bodySmall: _appTextTheme.bodySmall?.copyWith(color: AppColors.secondaryTextDark),
        labelSmall: _appTextTheme.labelSmall?.copyWith(color: AppColors.secondaryTextDark),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.vibrantPink,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.vibrantPink,
          foregroundColor: AppColors.primaryWhiteAcinzentado,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: _appTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.vibrantPink,
          textStyle: _appTextTheme.labelMedium,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightGrayBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.vibrantPink, width: 2.0),
        ),
        hintStyle: _appTextTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextDark),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightGrayBackground,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  // Tema escuro (Dark Mode)
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.vibrantPink,
      scaffoldBackgroundColor: AppColors.darkBlueBlackBackground,
      appBarTheme: AppBarTheme( // Removendo 'const' aqui
        backgroundColor: AppColors.darkBlueBlackBackground,
        foregroundColor: AppColors.primaryTextLight,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _appTextTheme.headlineMedium?.copyWith(
          color: AppColors.primaryTextLight,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      textTheme: _appTextTheme.copyWith( // Aplica o tema de texto personalizado
        displayLarge: _appTextTheme.displayLarge?.copyWith(color: AppColors.primaryTextLight),
        displayMedium: _appTextTheme.displayMedium?.copyWith(color: AppColors.primaryTextLight),
        displaySmall: _appTextTheme.displaySmall?.copyWith(color: AppColors.primaryTextLight),
        headlineMedium: _appTextTheme.headlineMedium?.copyWith(color: AppColors.primaryTextLight),
        headlineSmall: _appTextTheme.headlineSmall?.copyWith(color: AppColors.primaryTextLight),
        titleLarge: _appTextTheme.titleLarge?.copyWith(color: AppColors.primaryTextLight),
        bodyLarge: _appTextTheme.bodyLarge?.copyWith(color: AppColors.primaryTextLight),
        bodyMedium: _appTextTheme.bodyMedium?.copyWith(color: AppColors.primaryTextLight),
        labelLarge: _appTextTheme.labelLarge?.copyWith(color: AppColors.primaryTextLight),
        bodySmall: _appTextTheme.bodySmall?.copyWith(color: AppColors.secondaryTextLight),
        labelSmall: _appTextTheme.labelSmall?.copyWith(color: AppColors.secondaryTextLight),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.vibrantPink,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.vibrantPink,
          foregroundColor: AppColors.primaryTextLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: _appTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.vibrantPink,
          textStyle: _appTextTheme.labelMedium,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkGrayCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.vibrantPink, width: 2.0),
        ),
        hintStyle: _appTextTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextLight),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkGrayCard,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
