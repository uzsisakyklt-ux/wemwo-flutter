import 'package:flutter/material.dart';
import 'responsive_layout.dart';

class WemwoScaffold extends StatelessWidget {
  final Widget child;
  final bool scrollable;
  final PreferredSizeWidget? appBar;

  const WemwoScaffold({
    super.key,
    required this.child,
    this.scrollable = true,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveLayout.horizontalPadding(context),
      ).copyWith(
        top: ResponsiveLayout.verticalSpacingLarge(context),
        bottom: ResponsiveLayout.verticalSpacingLarge(context),
      ),
      child: child,
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: scrollable
            ? SingleChildScrollView(child: content)
            : content,
      ),
    );
  }
}
