import 'package:flutter/material.dart';

enum ScreenSize { small, medium, large }

class ResponsiveLayout {
  static ScreenSize sizeOf(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 360) return ScreenSize.small;   // labai maži telefonai
    if (width < 600) return ScreenSize.medium;  // normali dauguma telefonų
    return ScreenSize.large;                    // planšetės ir pan.
  }

  static double horizontalPadding(BuildContext context) {
    final size = sizeOf(context);
    switch (size) {
      case ScreenSize.small:
        return 16;
      case ScreenSize.medium:
        return 20;
      case ScreenSize.large:
        return 32;
    }
  }

  static double verticalSpacingSmall(BuildContext context) {
    final size = sizeOf(context);
    switch (size) {
      case ScreenSize.small:
        return 8;
      case ScreenSize.medium:
        return 12;
      case ScreenSize.large:
        return 16;
    }
  }

  static double verticalSpacingLarge(BuildContext context) {
    final size = sizeOf(context);
    switch (size) {
      case ScreenSize.small:
        return 16;
      case ScreenSize.medium:
        return 24;
      case ScreenSize.large:
        return 32;
    }
  }
}
