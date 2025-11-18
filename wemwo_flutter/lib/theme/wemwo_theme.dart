import 'package:flutter/material.dart';

class WemwoTheme {
  static const Color background = Color(0xFFF2F3F7);
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF707070);

  // Fonas kortelei (Welcome, Login ir t.t.)
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF6F2FF),
      Color(0xFFFDF1FF),
      Color(0xFFFFFFFF),
    ],
  );

  // Akcento gradientas mygtukams, logo ir pan.
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6C63FF),
      Color(0xFFA06AFD),
      Color(0xFFFF8ABF),
    ],
  );
}
