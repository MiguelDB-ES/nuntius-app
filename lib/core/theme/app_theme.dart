// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores principais da paleta (ajustadas para um visual moderno)
  static const Color _primaryColor = Color(0xFF42A5F5); // Um azul vibrante
  static const Color _primaryLightColor = Color(0xFF80D6FF);
  static const Color _primaryDarkColor = Color(0xFF0077C2);
  static const Color _secondaryColor = Color(0xFF66BB6A); // Um verde para acentuação
  static const Color _secondaryLightColor = Color(0xFFA2F78D);
  static const Color _secondaryDarkColor = Color(0xFF338A3E);
  static const Color _textColor = Color(0xFF212121); // Texto escuro para contraste
  static const Color _lightTextColor = Color(0xFFF5F5F5); // Texto claro para fundos escuros
  static const Color _backgroundColor = Color(0xFFF0F2F5); // Fundo claro e suave
  static const Color _cardColor = Colors.white; // Cor do cartão
  static const Color _errorColor = Color(0xFFEF5350); // Vermelho para erros

  // Tema claro
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.light( // Explicitamente Light
      primary: _primaryColor,
      onPrimary: _lightTextColor,
      secondary: _secondaryColor,
      onSecondary: _lightTextColor,
      error: _errorColor,
      onError: _lightTextColor,
      background: _backgroundColor,
      onBackground: _textColor,
      surface: _cardColor,
      onSurface: _textColor,
      brightness: Brightness.light, // Garante que o brilho do ColorScheme corresponde
    ),
    scaffoldBackgroundColor: _backgroundColor,
    cardColor: _cardColor,
    dividerColor: Colors.grey[300],
    hintColor: Colors.grey[500],
    textTheme: GoogleFonts.interTextTheme(_buildLightTextTheme()),
    appBarTheme: AppBarTheme(
      color: _primaryColor,
      foregroundColor: _lightTextColor,
      elevation: 4.0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        color: _lightTextColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: _lightTextColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: _lightTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 5,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryColor,
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryColor,
        side: const BorderSide(color: _primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: _primaryColor, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: _errorColor, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: _errorColor, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(color: Colors.grey[700]),
      hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
    ),
    cardTheme: CardTheme( // Usar CardTheme (não CardThemeData)
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.all(8.0),
      color: _cardColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _secondaryColor,
      foregroundColor: _lightTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 6,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _cardColor,
      selectedItemColor: _primaryColor,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.inter(fontSize: 12),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
  );

  // Tema escuro
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _primaryDarkColor,
    colorScheme: ColorScheme.dark( // Explicitamente Dark
      primary: _primaryDarkColor,
      onPrimary: _lightTextColor,
      secondary: _secondaryDarkColor,
      onSecondary: _lightTextColor,
      error: _errorColor,
      onError: _lightTextColor,
      background: const Color(0xFF121212),
      onBackground: _lightTextColor,
      surface: const Color(0xFF1E1E1E),
      onSurface: _lightTextColor,
      brightness: Brightness.dark, // Garante que o brilho do ColorScheme corresponde
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    dividerColor: Colors.grey[700],
    hintColor: Colors.grey[600],
    textTheme: GoogleFonts.interTextTheme(_buildDarkTextTheme()),
    appBarTheme: AppBarTheme(
      color: _primaryDarkColor,
      foregroundColor: _lightTextColor,
      elevation: 4.0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        color: _lightTextColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: _lightTextColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryDarkColor,
        foregroundColor: _lightTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 5,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryLightColor,
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryLightColor,
        side: const BorderSide(color: _primaryLightColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: _primaryLightColor, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey[700]!, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: _errorColor, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: _errorColor, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(color: Colors.grey[400]),
      hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
    ),
    cardTheme: CardTheme( // Usar CardTheme (não CardThemeData)
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.all(8.0),
      color: const Color(0xFF1E1E1E),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _secondaryDarkColor,
      foregroundColor: _lightTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 6,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF212121),
      selectedItemColor: _primaryLightColor,
      unselectedItemColor: Colors.grey[400],
      selectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.inter(fontSize: 12),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
  );

  // Configuração de texto para o tema claro
  static TextTheme _buildLightTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.inter(fontSize: 57, fontWeight: FontWeight.normal, color: _textColor),
      displayMedium: GoogleFonts.inter(fontSize: 45, fontWeight: FontWeight.normal, color: _textColor),
      displaySmall: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.normal, color: _textColor),
      headlineLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, color: _textColor),
      headlineMedium: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, color: _textColor),
      headlineSmall: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: _textColor),
      titleLarge: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: _textColor),
      titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: _textColor),
      titleSmall: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: _textColor),
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal, color: _textColor),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal, color: _textColor),
      bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey[700]),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: _textColor),
      labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: _textColor),
      labelSmall: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: _textColor),
    );
  }

  // Configuração de texto para o tema escuro
  static TextTheme _buildDarkTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.inter(fontSize: 57, fontWeight: FontWeight.normal, color: _lightTextColor),
      displayMedium: GoogleFonts.inter(fontSize: 45, fontWeight: FontWeight.normal, color: _lightTextColor),
      displaySmall: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.normal, color: _lightTextColor),
      headlineLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, color: _lightTextColor),
      headlineMedium: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, color: _lightTextColor),
      headlineSmall: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: _lightTextColor),
      titleLarge: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: _lightTextColor),
      titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: _lightTextColor),
      titleSmall: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: _lightTextColor),
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal, color: _lightTextColor),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal, color: _lightTextColor),
      bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey[400]),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: _lightTextColor),
      labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: _lightTextColor),
      labelSmall: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: _lightTextColor),
    );
  }
}
