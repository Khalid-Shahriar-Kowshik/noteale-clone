import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: ColorsUtil.backgroundColor,
  ),
  brightness: Brightness.light,
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: ColorsUtil.secondaryColor,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorsUtil.primaryColor,
    brightness: Brightness.light,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(ColorsUtil.primaryColor),
    trackColor: MaterialStateProperty.all(ColorsUtil.primaryColor.withOpacity(0.4)),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorsUtil.primaryColor,
    brightness: Brightness.dark,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(ColorsUtil.primaryColor),
    trackColor: MaterialStateProperty.all(ColorsUtil.primaryColor.withOpacity(0.4)),
  ),
);
