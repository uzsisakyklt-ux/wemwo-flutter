import 'package:flutter/material.dart';

/// Bendras Wemwo žingsnių indikatorius.
/// Pvz.:
/// WemwoStepsHeader(
///   labels: ['Paskyra', 'Patvirtinimas', 'Profilis'],
///   currentStep: 3,
/// )
class WemwoStepsHeader extends StatelessWidget {
  final List<String> labels;
  /// 1-based index: 1, 2, 3...
  final int currentStep;

  const WemwoStepsHeader({
    super.key,
    required this.labels,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < labels.length; i++) ...[
          _StepItem(
            title: labels[i],
            stepNumber: i + 1,
            isCompleted: i + 1 < currentStep,
            isCurrent: i + 1 == currentStep,
          ),
          if (i != labels.length - 1) const _StepDivider(),
        ],
      ],
    );
  }
}

class _StepItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final bool isCurrent;
  final int stepNumber;

  const _StepItem({
    required this.title,
    required this.isCompleted,
    required this.isCurrent,
    required this.stepNumber,
  });

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF8A6CFF),
        Color(0xFFFF6FD8),
      ],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: gradient,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  )
                : Text(
                    '$stepNumber',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w500,
            color: isCurrent
                ? const Color(0xFF8A6CFF)
                : Colors.purple.shade400,
          ),
        ),
      ],
    );
  }
}

class _StepDivider extends StatelessWidget {
  const _StepDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 34,
      height: 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: const Color(0xFFE2D5FF),
      ),
    );
  }
}
