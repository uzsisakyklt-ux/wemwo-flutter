import 'package:flutter/material.dart';
import '../theme/wemwo_theme.dart';

class WemwoScreenContainer extends StatelessWidget {
  final Widget child;

  const WemwoScreenContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        // svarbu: kad nemestų baltos spalvos virš gradient
        color: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 420,
            minHeight: 620,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            gradient: WemwoTheme.backgroundGradient,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
