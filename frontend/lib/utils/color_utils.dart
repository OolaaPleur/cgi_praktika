import 'package:flutter/material.dart';

/// Utility method to parse hex color strings to Color objects
Color parseColor(String hexColor) {
  // Remove any '#' if present
  hexColor = hexColor.replaceAll('#', '');

  // Add FF prefix only if it's a 6-digit hex
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }

  // Parse the color
  return Color(int.parse(hexColor, radix: 16));
}
