import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteale_clone/utils/colors.dart';
// theme-aware; no ColorsUtil needed here

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsUtil.primaryColor, // primary color from theme
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          'About',
          style: TextStyle(
            color: theme.appBarTheme.foregroundColor ?? colorScheme.onPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          // Orange header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(color: ColorsUtil.primaryColor),
            child: Container(
              width: 154,
              height: 154,
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsUtil.primaryColor,
                ),
              child: Image.asset("assets/logo.png")),
            ),
          ),

          // List items section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Text(
                  'Application: HaBiT Note',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                Text(
                  'Version: V1.0.0',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                Text(
                  'Privacy Policy',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                Text(
                  'Terms of Use',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
