import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteale_clone/utils/colors.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsUtil.primaryColor, // Orange color
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: const Text('About', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Orange header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(color: ColorsUtil.primaryColor),
            child: Container(
              width: 154,
              height: 154,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Image.asset("assets/logo.png"),
            ),
          ),

          // List items section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Text('Application: HaBiT Note'),
                Text('Version: V1.0.0'),
                Text('Privacy Policy'),
                Text('Terms of Use'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
