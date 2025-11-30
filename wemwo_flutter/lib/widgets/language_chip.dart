// FILE: lib/widgets/language_chip.dart

import 'package:flutter/material.dart';

class LanguageChip extends StatelessWidget {
  final String name;
  final String level;

  const LanguageChip({
    super.key,
    required this.name,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F0), // švelniai kreminė
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$name • $level',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
