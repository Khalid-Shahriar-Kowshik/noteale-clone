import 'package:flutter/material.dart';
import 'package:noteale_clone/utils/colors.dart';

class SplashScreenView extends StatelessWidget{
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: ColorsUtil.primaryColor,
  body: Center(
    child: Image.asset(
      'assets/logo.png',
      width: 250,
      height: 250,
    ),
  ),
  bottomNavigationBar: const Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: Text(
      "© Copyright HABIT 2021. All rights reserved",
      textAlign: TextAlign.center,
    ),
  ),
);
  }
}