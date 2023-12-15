import 'package:flutter/material.dart';

extension StringExtensions on String {
  /// Converts a string to a [Color] based on its hash code.
  Color toColor() {
    final hash = hashCode;
    final maskedHashCode = hash & 0xffffff;
    final shiftedHashCode = maskedHashCode << 8;
    final maskedShiftedHashCode = shiftedHashCode & 0xffffff;
    final color = maskedShiftedHashCode | 0xFF000000;
    return Color(color);
  }
}
