// lib/core/theme/app_colors.dart
// Importação obrigatória para usar o tipo Color
import 'package:flutter/material.dart';

class AppColors {
  // Cores primárias e de fundo (default/light mode)
  static const Color primaryWhiteAcinzentado = Color(0xFFEEEEEE); // Quase branco suave
  static const Color lightGrayBackground = Color(0xFFE0E0E0); // Cinza muito sutil
  static const Color mediumGrayBorder = Color(0xFFBDBDBD); // Cinza para bordas/divisores

  // Cores primárias e de fundo (dark mode)
  static const Color darkBlueBlackBackground = Color(0xFF121212); // Azul escuro/preto profundo
  static const Color darkGrayCard = Color(0xFF212121); // Cinza escuro para cards
  static const Color darkGrayBorder = Color(0xFF424242); // Cinza escuro suave para bordas

  // Cores de texto
  static const Color primaryTextDark = Color(0xFF1A237E); // Azul escuro para texto principal (light)
  static const Color secondaryTextDark = Color(0xFF757575); // Cinza médio para texto secundário (light)
  static const Color primaryTextLight = Color(0xFFEEEEEE); // Branco acinzentado para texto principal (dark)
  static const Color secondaryTextLight = Color(0xFFBDBDBD); // Cinza claro para texto secundário (dark)

  // Cores de destaque/ação
  static const Color vibrantPink = Color(0xFFE91E63); // Rosa vibrante para elementos interativos
  static const Color vibrantPinkAccent = Color(0xFFFF4081); // Rosa mais acentuado

  // Cores prateadas/platina para detalhes
  static const Color silveryDetail = Color(0xFFC0C0C0); // Prata para detalhes (light)
  static const Color platinumDetail = Color(0xFFD3D3D3); // Platina para detalhes (dark)
}
