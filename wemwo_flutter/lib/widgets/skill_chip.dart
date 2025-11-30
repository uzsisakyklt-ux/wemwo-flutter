import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String skill;
  final String? experience; // pvz. "3 m."
  final String? level;      // pvz. "Senior"

  const SkillChip({
    super.key,
    required this.skill,
    this.experience,
    this.level,
  });

  @override
  Widget build(BuildContext context) {
    final metaParts = <String>[];

    if (experience != null && experience!.trim().isNotEmpty) {
      metaParts.add(experience!.trim());
    }
    if (level != null && level!.trim().isNotEmpty) {
      metaParts.add(level!.trim());
    }

    final meta = metaParts.join(' · ');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: const Color(0xFF8A6CFF).withOpacity(0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '# $skill',
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3B2E7A),
            ),
          ),
          if (meta.isNotEmpty) ...[
            const SizedBox(width: 4),
            Text(
              meta,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
