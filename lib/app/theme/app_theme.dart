// Flutter imports
import 'package:flutter/material.dart';

// Custom theme extension import
import 'custom_colors_theme.dart';

/// AppTheme class provides application-wide theme data.
/// It supports both light and dark themes and custom color extensions.
class AppTheme {
  // Custom color definitions using HexColor utility
  static HexColor colorOrange = HexColor('#FFA400');
  static HexColor colorGray = HexColor('#373A36');

  /// Returns ThemeData based on the [isLight] flag.
  /// Includes custom color extensions and overrides for FAB, AppBar, and ColorScheme.
  static ThemeData get({required bool isLight}) {
    final base = isLight ? ThemeData.light() : ThemeData.dark();
    return base.copyWith(
      // Add custom color extension for navigation bar and labels
      extensions: [
        CustomColorsTheme(
          colorLabelColor: isLight ? Colors.grey : const Color(0xFF7A7FB0),
          bottomNavigationBarBackgroundColor: isLight ? Colors.blue : colorGray,
          activeNavigationBarColor: isLight ? Colors.yellow : colorOrange,
          notActiveNavigationBarColor: Colors.white,
          shadowNavigationBarColor: isLight ? Colors.blue : colorOrange,
        )
      ],
      // Floating Action Button theme customization
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isLight ? Colors.yellow : colorOrange,
      ),
      // AppBar theme customization
      appBarTheme: AppBarTheme(
        backgroundColor: isLight ? Colors.blue : colorGray,
      ),
      // Color scheme customization for surface and background
      colorScheme: base.colorScheme.copyWith(
        surface: isLight ? Colors.blue : colorGray,
        background: isLight ? Colors.white : colorGray,
      ),
    );
  }
}

/// Utility class to convert hex color strings to [Color] objects.
class HexColor extends Color {
  /// Creates a [Color] from a hex string, e.g. '#FFA400' or 'FFA400'.
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  /// Converts a hex string to an integer value for [Color].
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor; // Add alpha if not provided
    }
    return int.parse(hexColor, radix: 16);
  }
}