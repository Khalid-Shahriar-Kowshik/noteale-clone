import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteale_clone/utils/colors.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _darkModeEnabled = false;
  bool _notificationsEnabled = true;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.secondaryColor,
      appBar: AppBar(
        backgroundColor: ColorsUtil.secondaryColor,
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
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              value: _darkModeEnabled,
              activeColor: ColorsUtil.primaryColor,
              onChanged: (value) {
                setState(() => _darkModeEnabled = value);
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Sound Effects',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              value: _notificationsEnabled,
              activeColor: ColorsUtil.primaryColor,
              onChanged: (value) {
                setState(() => _notificationsEnabled = value);
              },
            ),
           
          ],
        ),
      ),
    );
  }
}
