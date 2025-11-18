import 'package:flutter/material.dart';
import '../theme/wemwo_theme.dart';

class WemwoLogoText extends StatelessWidget {
  final double fontSize;
  const WemwoLogoText({super.key, this.fontSize = 32});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          WemwoTheme.accentGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
      child: Text(
        "Wemwo",
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: Colors.white, // turi būti baltas -> dengia Shader
        ),
      ),
    );
  }
}
