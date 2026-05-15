import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0D1117);
  static const Color surface = Color(0xFF161B22);
  static const Color surfaceElevated = Color(0xFF1C2333);
  static const Color border = Color(0xFF30363D);

  static const Color primary = Color(0xFF00D4AA);
  static const Color primaryDark = Color(0xFF00A882);
  static const Color accent = Color(0xFF7C3AED);
  static const Color accentLight = Color(0xFF9D5CF6);

  static const Color textPrimary = Color(0xFFE6EDF3);
  static const Color textSecondary = Color(0xFF8B949E);
  static const Color textMuted = Color(0xFF484F58);

  static const Color success = Color(0xFF3FB950);
  static const Color warning = Color(0xFFD29922);
  static const Color danger = Color(0xFFF85149);
  static const Color info = Color(0xFF58A6FF);

  static const Color sidebarBg = Color(0xFF0D1117);
  static const Color headerBg = Color(0xFF161B22);
  static const Color cardBg = Color(0xFF161B22);

  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [Color(0xFF00D4AA), Color(0xFF00A882)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get accentGradient => const LinearGradient(
        colors: [Color(0xFF7C3AED), Color(0xFF9D5CF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get dangerGradient => const LinearGradient(
        colors: [Color(0xFFF85149), Color(0xFFFF6B6B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}