import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteale_clone/utils/colors.dart';

import 'package:noteale_clone/viewmodels/theme_viewmodel.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            Consumer<ThemeViewModel>(
              builder: (context, themeVM, _) {
                return SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Dark Mode',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  value: themeVM.isDarkMode,
                  activeColor: ColorsUtil.primaryColor,
                  onChanged: (value) {
                    themeVM.toggleTheme(value);
                  },
                );
              },
            ),
            const SizedBox(height: 16),
           
          ],
        ),
      ),
    );
  }
}
