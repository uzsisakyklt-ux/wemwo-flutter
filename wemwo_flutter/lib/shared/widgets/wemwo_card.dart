import 'package:flutter/material.dart';

class WemwoCard extends StatelessWidget {
  final Widget child;

  const WemwoCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
