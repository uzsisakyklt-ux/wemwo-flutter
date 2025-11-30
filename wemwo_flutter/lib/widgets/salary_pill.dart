// FILE: lib/widgets/salary_pill.dart

import 'package:flutter/material.dart';

class SalaryPill extends StatelessWidget {
  final String text;

  const SalaryPill(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFBF5), // švelniai žalia
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.green.shade700,
        ),
      ),
    );
  }
}
