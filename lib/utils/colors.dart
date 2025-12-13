import 'package:flutter/material.dart';

class ColorsUtil {
  static const primaryColor = Color(0xFFFFB347);
  static const secondaryColor = Color(0xFFFFFFFF);
  static const backgroundColor = Color(0xFFF1F1F1);
  static const gradiantColor = Color(0xFF787878);
  static const bottomNavBarColor = Color(0xFFC4C4C4);

  /// Create a [Color] from a hex string, like `#RRGGBB` or `#AARRGGBB`.
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    String hex = hexString.replaceFirst('#', '');
    if (hex.length == 6) buffer.write('ff');
    buffer.write(hex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Return a readable text color (black or white) depending on background luminance.
  static Color readableTextColor(String backgroundHex) {
    final bg = fromHex(backgroundHex);
    return bg.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
